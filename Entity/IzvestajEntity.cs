using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class IzvestajEntity
    {
        public string OznakaMaterijala { get; set; }
        public int Kolicina { get; set; }

        public IzvestajEntity(string oznakaMaterijala, int kolicina)
        {
            OznakaMaterijala = oznakaMaterijala;
            Kolicina = kolicina;
        }        

        public IzvestajEntity()
        {

        }

    }
}
