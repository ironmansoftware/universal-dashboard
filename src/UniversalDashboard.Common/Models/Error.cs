using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;
using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
    public class Error : Component
    {
		public Error(IEnumerable<ErrorRecord> errorRecords) 
		{
			ErrorRecords = errorRecords.Select(m => new UDErrorRecord(m)).ToArray();
		}

		public Error(Exception exception) 
		{
			ErrorRecords = new [] { new UDErrorRecord(exception) };
		}

		[JsonProperty("errorRecords")]
		public UDErrorRecord[] ErrorRecords { get; set; }

		[JsonProperty("type")]
		public override string Type => "error";
    }

	public class UDErrorRecord 
	{
		public UDErrorRecord(ErrorRecord errorRecord) 
		{
			if (errorRecord == null) throw new ArgumentNullException(nameof(errorRecord));

			Message = errorRecord.ErrorDetails == null ? errorRecord.Exception?.Message : errorRecord.ErrorDetails.Message;
			Location = errorRecord.ScriptStackTrace;
		}

		public UDErrorRecord(Exception exception) 
		{
			Message = exception.Message;
			Location = exception.StackTrace;
		}

		[JsonProperty("message")]
		public string Message { get; set; }

		[JsonProperty("location")]
		public string Location { get; set; }
	}
}
