using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class JezikEntity
    {
        public int IDJezik { get; set; }
        public String NazivJezika { get; set; }

        public JezikEntity(int iDJezik, string nazivJezika)
        {
            IDJezik = iDJezik;
            NazivJezika = nazivJezika;
        }

        public JezikEntity()
        {
            
        }


    }
}
