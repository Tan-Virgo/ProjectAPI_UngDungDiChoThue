using System.Web;
using System.Web.Mvc;

namespace UngDung_DiChoThue
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
