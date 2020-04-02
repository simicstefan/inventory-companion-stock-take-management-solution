using Popis.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Popis.Controllers
{
    public class IzvestajController : Controller
    {
        // GET: Izvestaj
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult DajIzvestaj()
        {
            Izvestaj model = new Izvestaj();
            model.DajIzvestaj();
            return View("Izvestaj", model);
        }

    }
}