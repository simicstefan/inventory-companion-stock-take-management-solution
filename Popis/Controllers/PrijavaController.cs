using Popis.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace Popis.Controllers
{
    public class PrijavaController : Controller
    {
        // GET: Prijava
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Prijava()
        {
            Session["IDKorisnik"] = "";
            Prijava model = new Prijava();
            model.PopuniListuProjekataCmb();
            model.PopuniListuZonaCmb();
            return View("Prijava", model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "None")]
        public ActionResult Prijava(Prijava model)
        {
            int PovratnaVrednost = 0;
            model.PopuniListuProjekataCmb();
            model.PopuniListuZonaCmb();

            if (ModelState.IsValid)
            {
                PovratnaVrednost = model.PrijavaKorisnika();
                if (PovratnaVrednost != 0)
                {
                    Session["IDKorisnik"] = model.prijava.IDKorisnik;
                    Session["IDProjekat"] = model.prijava.IDProjekat;
                    Session["IDZona"] = model.prijava.IDZona;

                    model.VratiPodatke((int)Session["IDProjekat"], (int)Session["IDZona"], (int)Session["IDKorisnik"]);
                    Session["Ime"] = model.ImeIPrezimeKorisnika;
                    Session["Projekat"] = model.Projekat;
                    Session["Zona"] = model.Zona;

                    FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1, model.prijava.IDKartica.ToString(), DateTime.Now, DateTime.Now.AddMinutes(300), false, "Prijavljen", FormsAuthentication.FormsCookiePath);
                    string hash = FormsAuthentication.Encrypt(ticket);
                    HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, hash);

                    if (ticket.IsPersistent)
                    {
                        cookie.Expires = ticket.Expiration;
                    }

                    Response.Cookies.Add(cookie);
                    return RedirectToAction("DodajSkeniranjeView", "Skeniranje");

                }

                else
                {
                    ModelState.AddModelError("", "Pogrešan broj kartice.");

                }


            }

            //return RedirectToAction("Prijava");
            return View("Prijava", model);
        }

        [Authorize]
        public ActionResult Odjava()
        {
            FormsAuthentication.SignOut();
            this.Session.Abandon();
            return RedirectToAction("Prijava");
        }

    }
}