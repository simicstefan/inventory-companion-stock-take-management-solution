using Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Lokalizacija.Languages;

namespace Popis.Models
{
    public class Skeniranje
    {
        public List<SkeniranjeEntity> SkeniranjeList { get; set; }

        public SkeniranjeEntity skeniranje { get; set; }

        public Skeniranje()
        {
            skeniranje = new SkeniranjeEntity();
            SkeniranjeList = new List<SkeniranjeEntity>();
        }

        public void DajSveSkeniranoZaKorisnika()
        {
            DataTable dt = DAL.DALSkeniranje.DajSveSkeniranoZaKorisnika(skeniranje.IDKorisnik);
            foreach(DataRow red in dt.Rows)
            {
                int IDSkeniranje = (int)red["IDSkeniranje"];
                int IDKorisnik = (int)red["IDKorisnik"];
                int IDMaterijal = (int)red["IDMaterijal"];
                string OznakaMaterijala = red["OznakaMaterijala"].ToString();
                int Kolicina = (int)red["Kolicina"];
                string Komentar = red["Komentar"].ToString();
                DateTime DatumVremeSkeniranje = (DateTime)red["DatumVremeSkeniranje"];
                SkeniranjeEntity ent = new SkeniranjeEntity(IDSkeniranje, IDKorisnik ,IDMaterijal, OznakaMaterijala, Kolicina, Komentar, DatumVremeSkeniranje);
                SkeniranjeList.Add(ent);
            }
        }


        public void DodajSkeniranje(int IDKorisnik, int IDProjekat, int IDZona)
        {
            skeniranje.IDKorisnik = IDKorisnik;
            skeniranje.IDProjekat = IDProjekat;
            skeniranje.IDZona = IDZona;
            DAL.DALSkeniranje.DodajSkeniranje(skeniranje);

        }

        public void ObrisiSkeniranje(int IDSkeniranje)
        {
            DAL.DALSkeniranje.ObrisiSkeniranje(IDSkeniranje);
        }

 

    }
}