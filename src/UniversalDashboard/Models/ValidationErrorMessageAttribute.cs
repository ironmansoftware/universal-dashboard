namespace System.Management.Automation
{
    public class ValidationErrorMessageAttribute : Attribute
    {
        public ValidationErrorMessageAttribute(string message)
        {
            Message = message;
        }

        public string Message { get; set; }
    }
}
