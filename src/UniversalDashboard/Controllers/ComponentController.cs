using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using NLog;
using UniversalDashboard.Models;
using UniversalDashboard.Services;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Microsoft.AspNetCore.Routing;
using System.Threading.Tasks;
using UniversalDashboard.Execution;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.Features;
using UniversalDashboard.Interfaces;
using Microsoft.Extensions.Primitives;
using System.Collections;

namespace UniversalDashboard.Controllers
{
    [Route("api/internal/component")]
    public class ComponentController : Controller
    {
        private static readonly Logger Log = LogManager.GetLogger(nameof(ComponentController));
        private readonly IExecutionService _executionService;
        private readonly IDashboardService _dashboardService;
        private readonly IMemoryCache _memoryCache;
        private readonly StateRequestService _stateRequestService;
        private readonly ConnectionManager _connectionManager;

        public ComponentController(IExecutionService executionService, IDashboardService dashboardService, IMemoryCache memoryCache, StateRequestService stateRequestService, ConnectionManager connectionManager)
        {
            _executionService = executionService;
            _dashboardService = dashboardService;
            _memoryCache = memoryCache;
            _stateRequestService = stateRequestService;
            _connectionManager = connectionManager;
        }

        public virtual async Task<IActionResult> RunScript(AbstractEndpoint endpoint, Dictionary<string, object> parameters = null, bool noSerialization = false)
        {
            try {
                var variables = new Dictionary<string, object> {
                    {"Request", Request},
                    {"Response", Response},
                    {"User", HttpContext?.User?.Identity?.Name},
                    {"MemoryCache", _memoryCache},
                    {"UDConnectionManager", _connectionManager }
                };

                try
                {
                    if (HttpContext.Request.Cookies.ContainsKey("location") == true) {
                        var location = HttpContext.Request.Cookies["location"];
                        if (!string.IsNullOrEmpty(location)) {
                            location = Encoding.UTF8.GetString(Convert.FromBase64String(location));
                            var locationObject = JsonConvert.DeserializeObject<Location>(location);
                            variables.Add("Location", locationObject);
                        }
                    }
                }
                catch (Exception ex)
                {
                    Log.Error("RunScript() Exception processing geolocation. " + ex.Message);
                }

                ExecutionContext executionContext = new ExecutionContext(endpoint, variables, parameters, HttpContext?.User);
                executionContext.NoSerialization = noSerialization;

                if (HttpContext.Request.Headers.TryGetValue("UDConnectionId", out StringValues connectionId))
                {
                    executionContext.SessionId = _connectionManager.GetSessionId(connectionId);
                    executionContext.ConnectionId = connectionId;
                }

                var result = await _executionService.ExecuteEndpointAsync(executionContext, endpoint);
                var actionResult = ConvertToActionResult(result);

                return actionResult;
            }
            catch (Exception ex) {
                Log.Warn("RunScript() " + ex.Message + Environment.NewLine + ex.StackTrace);
                throw ex;
            }
        }

        private IActionResult ConvertToActionResult(object result)
        {
            var resString = result as string;
            if (resString != null)
            {
                Log.Debug("ConvertToActionResult() " + resString);
                var contentType = string.IsNullOrEmpty(Request.ContentType) ? "application/json; charset=utf-8" : Request.ContentType;
                return Content(resString, contentType);
            }
            else if (Request.ContentType?.Equals("application/json; charset=utf-8", StringComparison.OrdinalIgnoreCase) == true)
            {
                Log.Debug("ConvertToActionResult() " + result);
                return Json(result);
            }
            else
            {
                if (Log.IsDebugEnabled)
                {
                    var json = JsonConvert.SerializeObject(result);
                    Log.Debug("ConvertToActionResult() " + json);
                }

                return Json(result);
            }
        }

        [Route("element/{id}")]
        [ResponseCache(NoStore = true, Location = ResponseCacheLocation.None)]
        public async Task<IActionResult> Element(string id)
        {
            var variables = new Dictionary<string, object>();

            foreach (var item in Request.Query)
            {
                var values = item.Value.ToArray();

                if (values.Length == 1)
                {
                    variables.Add(item.Key, values.First());
                }
                else
                {
                    variables.Add(item.Key, values);
                }
            }

            Log.Debug($"Element - id = {id}");

            var endpoint = _dashboardService.EndpointService.Get(id, SessionId);

            if (endpoint == null)
            {
                Log.Warn($"Endpoint {id} not found.");
                return NotFound();
            }

            return await RunScript(endpoint, variables);
        }

        [HttpPost]
        [Route("element/{id}")]
        public async Task<IActionResult> ElementPost(string id)
        {
            var variables = new Dictionary<string, object>();

            string body = string.Empty;
            using (var streamReader = new StreamReader(Request.Body))
            {
                body = streamReader.ReadToEnd();
            }

            if (!string.IsNullOrEmpty(body)) {
                variables.Add("body", body);
            }

            Log.Debug($"Element POST - id = {id}");

            var endpoint = _dashboardService.EndpointService.Get(id, SessionId);

            if (endpoint == null)
            {
                Log.Warn($"Endpoint {id} not found.");
                return NotFound();
            }

            return await RunScript(endpoint, variables);
        }

        [HttpGet]
		[Route("/api/{*parts}")]
		public async Task<IActionResult> GetEndpoint()
		{
			var parts = HttpContext.GetRouteValue("parts") as string;

			Log.Info($"GetEndpoint - {parts}");

			var variables = new Dictionary<string, object>();
            SetQueryStringValues(variables);

            var endpoint = _dashboardService.EndpointService.GetByUrl(parts, "GET", variables);
            if (endpoint != null)
            {
                return await RunScript(endpoint, variables);
            }

			Log.Info("Did not match endpoint.");

			return StatusCode(404);
		}

		[HttpDelete]
		[Route("/api/{*parts}")]
		public async Task<IActionResult> DeleteEndpoint()
		{
			var parts = HttpContext.GetRouteValue("parts") as string;

			Log.Info($"DeleteEndpoint - {parts}");

            var variables = new Dictionary<string, object>();

            SetQueryStringValues(variables);

            if (!await TryProcessBodyAsForm(Request, variables))
            { 
                //If we made it here we either have a non-form content type
                //or the request was made with the default content type of form
                //when it is really something else (probably application/json)
                ProcessBodyAsRaw(Request, variables);                              
            }

            var endpoint = _dashboardService.EndpointService.GetByUrl(parts, "DELETE", variables);
            if (endpoint != null)
            {
                return await RunScript(endpoint, variables);
            }

            Log.Info("Did not match endpoint.");

			return StatusCode(404);
		}

        private async Task<bool> TryProcessBodyAsForm (HttpRequest request, Dictionary<string,object> variables)
        {
            if (HttpContext.Request.HasFormContentType)
            {     
                Log.Debug("HasFormContentType");

                var form = await Request.ReadFormAsync(new FormOptions() { BufferBody = true });

                if (form != null && form.Any())
                {   
                    foreach (var value in form)
                    {
                        if (value.Value.Count == 1) {
                            variables.Add(value.Key, value.Value.First());
                        } else {
                            variables.Add(value.Key, value.Value);
                        }
                    }
                    return true;
                }
		        return false;
            }
            return false;
	        
        }

        private async Task<bool> TryProcessFile (HttpRequest request, Dictionary<string,object> variables)
        {
            if (HttpContext.Request.ContentType.Contains("image/") || HttpContext.Request.ContentType.Contains("file/")) 
            {
                Log.Debug("HasFileOrImageContenttype");
                using (MemoryStream stream = new MemoryStream())
                {
                    await HttpContext.Request.Body.CopyToAsync(stream);
                    if (stream != null) {
                        variables.Add("File", stream.ToArray());
                        Log.Debug("File from RESTAPI found.");
                        return true;
                    }
                    else 
                    {
                        Log.Debug("Filestream is empty.");
                        return false;
                    }
                }
            }
            return false;
        }

        private void ProcessBodyAsRaw(HttpRequest request, Dictionary<string, object> variables)
        {
            Log.Debug($"Content type: {HttpContext.Request.ContentType}");
            using (var streamReader = new StreamReader(Request.Body))
            {
                var body = streamReader.ReadToEnd();
                variables.Add("body", body);
            }
        }

		[HttpPost]
		[Route("/api/{*parts}")]
		public async Task<IActionResult> PostEndpoint()
		{
			var parts = HttpContext.GetRouteValue("parts") as string;

			Log.Info($"PostEndpoint - {parts}");

			var variables = new Dictionary<string, object>();
            SetQueryStringValues(variables);
            
            if (!HttpContext.Request.ContentType.Contains("image/") && !HttpContext.Request.ContentType.Contains("file/")) 
            {
                if (!await TryProcessBodyAsForm(Request, variables))
                { 
                    //If we made it here we either have a non-form content type
                    //or the request was made with the default content type of form
                    //when it is really something else (probably application/json)
                    Log.Debug("Processing as RAW");
                    ProcessBodyAsRaw(Request, variables);                              
                }
            }

            
            var endpoint = _dashboardService.EndpointService.GetByUrl(parts, "POST", variables);
 
            if (endpoint.AcceptFileUpload) {
                if (await TryProcessFile(Request, variables)) {
                    Log.Debug("Reccieved a file!");
                    
                }
                else {
                    Log.Debug("Endpoint supported file content, but no files present.");
                }
            }
            if (endpoint != null)
            {
                return await RunScript(endpoint, variables);
            }

            Log.Info("Did not match endpoint.");

			return StatusCode(404);
		}

        [HttpPatch]
        [Route("/api/{*parts}")]
        public async Task<IActionResult> PatchEndpoint()
        {
            var parts = HttpContext.GetRouteValue("parts") as string;

            Log.Info($"PatchEndpoint - {parts}");

            var variables = new Dictionary<string, object>();
            SetQueryStringValues(variables);

            if (!await TryProcessBodyAsForm(Request, variables))
            {
                //If we made it here we either have a non-form content type
                //or the request was made with the default content type of form
                //when it is really something else (probably application/json)
                ProcessBodyAsRaw(Request, variables);
            }

            var endpoint = _dashboardService.EndpointService.GetByUrl(parts, "PATCH", variables);
            if (endpoint != null)
            {
                return await RunScript(endpoint, variables);
            }

            Log.Info("Did not match endpoint.");

            return StatusCode(404);
        }

        [HttpPut]
		[Route("/api/{*parts}")]
		public async Task<IActionResult> PutEndpoint()
		{
			var parts = HttpContext.GetRouteValue("parts") as string;

			Log.Info($"PutEndpoint - {parts}");

			var variables = new Dictionary<string, object>();
            SetQueryStringValues(variables);

            if (!await TryProcessBodyAsForm(Request, variables))
            {
                //If we made it here we either have a non-form content type
                //or the request was made with the default content type of form
                //when it is really something else (probably application/json)
                ProcessBodyAsRaw(Request, variables);
            }

            var endpoint = _dashboardService.EndpointService.GetByUrl(parts, "PUT", variables);
            if (endpoint != null)
            {
                return await RunScript(endpoint, variables);
            }

            Log.Info("Did not match endpoint.");

			return StatusCode(404);
		}

        [HttpPost]
        [Route("element/sessionState/{requestId}")]
        public IActionResult SetElementSessionState([FromRoute]string requestId, [FromBody]JObject jobject)
        {
            var element = (Hashtable)jobject.ToObject(typeof(Hashtable));

            _stateRequestService.Set(requestId, element);
            return Json(new { message = "Session state set" });
        }

        private void SetQueryStringValues(Dictionary<string, object> variables)
        {
            foreach (var item in HttpContext.Request.Query)
            {
                if (item.Value.Count == 1)
                {
                    variables.Add(item.Key, item.Value[0]);
                }
                else
                {
                    variables.Add(item.Key, item.Value.Select(m => m).ToList());
                }
            }
        }

        public string SessionId
        {
            get
            {
                if (HttpContext.Session.TryGetValue("SessionId", out byte[] sessionIdBytes))
                {
                    var sessionId = new Guid(sessionIdBytes);
                    return sessionId.ToString();
                }
                return null;
            }
        }
	}
}
