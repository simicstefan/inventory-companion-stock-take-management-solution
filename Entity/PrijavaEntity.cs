using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Entity
{
    public class PrijavaEntity
    {
        public int IDKorisnik { get; set; }

        [Required(ErrorMessage = "Employee ID card necessary.")]       
        [RegularExpression(@"^[0-9]*$", ErrorMessage = "It is necessary to input number.")]
        [Display(Name = "IDKartica", ResourceType = typeof(Lokalizacija.Languages.langres))]
        //[LocalizedRegex("@^[0-9]*$", "NeophodnoJeUnetiBroj", typeof(Lokalizacija.Languages.langres))]
        public int IDKartica { get; set; }
        [Display(Name = "Projekat", ResourceType = typeof(Lokalizacija.Languages.langres))]
        public int IDProjekat { get; set; }
        [Display(Name = "Zona", ResourceType = typeof(Lokalizacija.Languages.langres))]
        public int IDZona { get; set; }

        public PrijavaEntity(int iDKorisnik, int iDKartica, int iDProjekat, int iDZona)
        {
            IDKorisnik = iDKorisnik;
            IDKartica = iDKartica;
            IDProjekat = iDProjekat;
            IDZona = iDZona;
        }

        public PrijavaEntity(int IDKartica)
        {
            this.IDKartica = IDKartica;
        }

        public PrijavaEntity()
        {

        }
        
    }
}
