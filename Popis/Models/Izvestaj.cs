using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using ClosedXML.Excel;
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

        public byte[] IzvozUExcel()
        {
            DateTime datumvreme = new DateTime();
            string naziv = "izvestaj popis";
            string folder = HttpContext.Current.Server.MapPath("~/Excel/" + naziv + ".xlsx");
            DataTable dt = DAL.DALSkeniranje.DajIzvestaj();
            XLWorkbook wb = new XLWorkbook();
            wb.Worksheets.Add(dt, "excel");
            wb.SaveAs(folder);
            return GetFile(folder);
                  
        }

        byte[] GetFile(string s)
        {
            System.IO.FileStream fs = System.IO.File.OpenRead(s);
            byte[] data = new byte[fs.Length];
            int br = fs.Read(data, 0, data.Length);
            if (br != fs.Length)
                throw new System.IO.IOException(s);
            fs.Close();
            var uri = new Uri(s, UriKind.Absolute);
            System.IO.File.Delete(uri.LocalPath);
            return data;
        }

    }
}