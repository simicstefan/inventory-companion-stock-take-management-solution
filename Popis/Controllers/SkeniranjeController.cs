using Popis.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Entity;
using System.Web.Security;

namespace Popis.Controllers
{
    public class SkeniranjeController : Controller
    {
        // GET: Skeniranje
        public ActionResult Index()
        {
            return View();
        }

        [Authorize(Roles = "Prijavljen")]
        public ActionResult DajSveSkeniranoZaKorisnika()
        {
            Skeniranje model = new Skeniranje();
            model.skeniranje.IDKorisnik = (int)Session["IDKorisnik"];
            model.DajSveSkeniranoZaKorisnika();
            return View("Skeniranje", model);
        }

        [Authorize(Roles = "Prijavljen")]
        public ActionResult DodajSkeniranjeFunkcija(Skeniranje model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    int IDKorisnik = (int)Session["IDKorisnik"];
                    int IDProjekat = (int)Session["IDProjekat"];
                    int IDZona = (int)Session["IDZona"];
                    model.DodajSkeniranje(IDKorisnik, IDProjekat, IDZona);
                }
                return RedirectToAction("DodajSkeniranjeView");              
            }
            catch
            {
                ModelState.AddModelError("", Lokalizacija.Languages.langres.MaterijalPodTomOznakomNePostoji);
                model.DajSveSkeniranoZaKorisnika();
            }
            return View("DodajSkeniranje", model);
        }

        [Authorize(Roles = "Prijavljen")]
        public ActionResult DodajSkeniranjeView()
        {
            Skeniranje model = new Skeniranje();
            model.skeniranje.IDKorisnik = (int)Session["IDKorisnik"];
            model.DajSveSkeniranoZaKorisnika();
            return View("DodajSkeniranje", model);
        }

        [Authorize(Roles = "Prijavljen")]
        public ActionResult ObrisiSkeniranje(int IDSkeniranje)
        {
            Skeniranje model = new Skeniranje();
            model.ObrisiSkeniranje(IDSkeniranje);
            return RedirectToAction("DodajSkeniranjeView");

        }
    }
}