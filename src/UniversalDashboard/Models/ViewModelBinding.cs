using System.Collections;

namespace UniversalDashboard.Models
{
    public class ViewModelBinding
    {
        public ViewModelBinding(string name, Hashtable boundProperties)
        {
            ViewModelName = name;
            BoundProperties = boundProperties;
        }

        public string ViewModelName { get; set; }
        public Hashtable BoundProperties { get; set; }
    }
}
