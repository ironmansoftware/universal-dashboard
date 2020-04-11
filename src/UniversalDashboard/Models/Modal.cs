namespace UniversalDashboard.Models
{
    public class Modal
    {
        public bool FullScreen { get; set; }
        public bool FullWidth { get; set; }
        public string MaxWidth { get; set; }
        public object[] Header { get; set; }
        public object[] Content { get; set; }
        public object[] Footer { get; set; }
        public bool Dismissible { get; set; }
    }
}
