using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class ProjekatEntity
    {
        public int IDProjekat { get; set; }
        public string NazivProjekta { get; set; }

        public ProjekatEntity(int IDProjekat, string NazivProjekta)
        {
            this.IDProjekat = IDProjekat;
            this.NazivProjekta = NazivProjekta;
        }

        public ProjekatEntity()
        {

        }

    }
}
