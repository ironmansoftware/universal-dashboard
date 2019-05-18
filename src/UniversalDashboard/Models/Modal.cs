namespace UniversalDashboard.Models
{
    public class Modal
    {
        public bool BottomSheet { get; set; }
        public bool FixedFooter { get; set; }
        public object[] Header { get; set; }
        public object[] Content { get; set; }
        public object[] Footer { get; set; }
        public string FontColor { get; set; }
        public string BackgroundColor { get; set; }
        public string Height { get; set; }
        public string Width { get; set; }
        public bool Dismissible { get; set; }
    }
}
