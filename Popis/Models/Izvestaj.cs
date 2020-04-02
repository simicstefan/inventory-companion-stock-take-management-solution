using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Entity;

namespace Popis.Models
{
    public class Izvestaj
    {
        public IzvestajEntity izvestaj { get; set; }

        public List<IzvestajEntity> IzvestajList { get; set; }

        public Izvestaj()
        {
            izvestaj = new IzvestajEntity();
            IzvestajList = new List<IzvestajEntity>();
        }

        public void DajIzvestaj()
        {
            DataTable dt = DAL.DALSkeniranje.DajIzvestaj();
            foreach(DataRow red in dt.Rows)
            {
                string OznakaMaterijala = red["OznakaMaterijala"].ToString();
                int Kolicina = (int)red["Kolicina"];
                IzvestajEntity ent = new IzvestajEntity(OznakaMaterijala, Kolicina);
                IzvestajList.Add(ent);
            }

        }
    }
}