using System;

namespace UniversalDashboard
{
    public class ValidationErrorMessage : Attribute
    {
        public ValidationErrorMessage(string message)
        {
            Message = message;
        }

        public string Message { get; set; }
    }
}
