using Popis.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace Popis.Controllers
{
    public class JezikController : Controller
    {
        // GET: Jezik
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult JezikView()
        {

            FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1, "Jezik", DateTime.Now, DateTime.Now.AddMinutes(300), false, "Inicijalno", FormsAuthentication.FormsCookiePath);
            string hash = FormsAuthentication.Encrypt(ticket);
            HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, hash);

            Session["Jezik"] = "en";

            if (ticket.IsPersistent)
            {
                cookie.Expires = ticket.Expiration;
            }

            Response.Cookies.Add(cookie);


            Jezik model = new Jezik();
            return View("Jezik", model);


        }

        [Authorize(Roles = "Inicijalno")]
        public ActionResult IzaberiJezik(int IDJezik)
        {
            if(IDJezik == 1)
            {
                Session["Jezik"] = "sr";
            } 
            
            else if (IDJezik == 2)
            {
                Session["Jezik"] = "en";
            }
            
            else if (IDJezik == 3)
            {
                Session["Jezik"] = "fr";
            }
            
            else if (IDJezik == 4)
            {
                Session["Jezik"] = "de";
            }

            return RedirectToAction("Prijava", "Prijava");
        }
    }
}