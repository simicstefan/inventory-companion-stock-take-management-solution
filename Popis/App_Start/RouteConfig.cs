using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Popis
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Jezik", action = "JezikView", id = UrlParameter.Optional }

            //defaults: new { controller = "Skeniranje", action = "PrijavaKorisnikaView", id = UrlParameter.Optional }
            );
        }
    }
}
