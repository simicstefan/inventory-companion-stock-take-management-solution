using Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Popis.Models
{
    public class Prijava
    {
        public List<SelectListItem> ListaProjekata;
        public List<SelectListItem> ListaZona;

        public PrijavaEntity prijava { get; set; }

        public string ImeIPrezimeKorisnika;
        public string Projekat;
        public string Zona;

        public Prijava()
        {

        }

        public List<SelectListItem> PopuniListuProjekataCmb()
        {
            ListaProjekata = new List<SelectListItem>();
            DataTable dt = DAL.DALSkeniranje.DajSveProjekte();
            foreach (DataRow red in dt.Rows)
            {
                int IDProjekat = (int)red["IDProjekat"];
                string NazivProjekta = red["NazivProjekta"].ToString();
                ListaProjekata.Add(new SelectListItem { Text = NazivProjekta, Value = IDProjekat.ToString(), Selected = IDProjekat.ToString() == "0" });
            }

            return ListaProjekata;
        }


        public List<SelectListItem> PopuniListuZonaCmb()
        {
            ListaZona = new List<SelectListItem>();
            DataTable dt = DAL.DALSkeniranje.DajSveZone();
            foreach (DataRow red in dt.Rows)
            {
                int IDZona = (int)red["IDZona"];
                string NazivZone = red["NazivZone"].ToString();
                ListaZona.Add(new SelectListItem { Text = NazivZone, Value = IDZona.ToString(), Selected = IDZona.ToString() == "0" });
            }

            return ListaZona;
        }

        public int PrijavaKorisnika()
        {
            DataTable dt = DAL.DALSkeniranje.PrijavaKorisnika(prijava.IDKartica);
            if(dt.Rows.Count == 0)
            {
                return 0;
            }

            foreach (DataRow red in dt.Rows)
            {
                int IDKorisnik = (int)red["IDKorisnik"];
                prijava.IDKorisnik = IDKorisnik;
            }

            return 1;                                    
        }

        public void VratiPodatke(int IDProjekat, int IDZona, int IDKorisnik)
        {
            DataSet ds = DAL.DALSkeniranje.VratiPodatke(IDProjekat, IDZona, IDKorisnik);

            foreach (DataRow red in ds.Tables["Projekat"].Rows)
            {
                this.Projekat = red["NazivProjekta"].ToString();
            }

            foreach (DataRow red in ds.Tables["Zona"].Rows)
            {
                this.Zona = red["NazivZone"].ToString();
            }

            foreach (DataRow red in ds.Tables["Korisnik"].Rows)
            {
                this.ImeIPrezimeKorisnika = red["Ime"].ToString();
            }
        }
    }
}