using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Lokalizacija;
using Lokalizacija.Languages;

namespace Entity
{
    public class SkeniranjeEntity
    {
        public int IDSkeniranje { get; set; }
        public int IDKorisnik { get; set; }
        [Display(Name = "IDMaterijal", ResourceType = typeof(Lokalizacija.Languages.langres))]
        public int IDMaterijal { get; set; }
        //[Required(ErrorMessageResourceName = "NeophodnoJeUnetiKolicinu", ErrorMessageResourceType = typeof(Lokalizacija.Languages.langres))]
        [Required(ErrorMessage = "It is necessary to input quantity.")]
        [RegularExpression(@"^[0-9]*$", ErrorMessage = "It is necessary to input number.")]
        [Display(Name = "Kolicina", ResourceType = typeof(Lokalizacija.Languages.langres))]
        public int Kolicina { get; set; }
        [Required(ErrorMessage = "It is necessary to input quantity confirmation.")]
        [RegularExpression(@"^[0-9]*$", ErrorMessage = "It is necessary to input number.")]
        [Display(Name = "PotvrdaKolicine", ResourceType = typeof(Lokalizacija.Languages.langres))]
        public int KolicinaPotvrda { get; set; }
        [Display(Name = "KomentarOpciono", ResourceType = typeof(Lokalizacija.Languages.langres))]
        public string Komentar { get; set; }
        public DateTime DatumVremeSkeniranja { get; set; }
        [Required(ErrorMessage = "It is necessary to input material number.")]
        [Display(Name = "OznakaMaterijala", ResourceType = typeof(Lokalizacija.Languages.langres))]
        public string OznakaMaterijala { get; set; }
        public int IDProjekat { get; set; }
        public int IDZona { get; set; }


        public SkeniranjeEntity(int IDSkeniranje, int IDKorisnik, int IDMaterijal, string OznakaMaterijala, int Kolicina, string Komentar, DateTime DatumVremeSkeniranja)
        {
            this.IDSkeniranje = IDSkeniranje;
            this.IDKorisnik = IDKorisnik;
            this.IDMaterijal = IDMaterijal;
            this.Kolicina = Kolicina;
            this.DatumVremeSkeniranja = DatumVremeSkeniranja;
            this.OznakaMaterijala = OznakaMaterijala;
            this.Komentar = Komentar;
        }

        //konstruktor za ubacivanje podataka
        public SkeniranjeEntity(int IDKorisnik, int Kolicina, int KolicinaPotvrda, string Komentar, string OznakaMaterijala)
        { 
            this.IDKorisnik = IDKorisnik;
            this.KolicinaPotvrda = KolicinaPotvrda;
            this.Kolicina = Kolicina;
            this.Komentar = Komentar;
            this.OznakaMaterijala = OznakaMaterijala;
        }

        public SkeniranjeEntity(int IDKorisnik, int IDProjekat, int IDZona)
        {
            this.IDKorisnik = IDKorisnik;
            this.IDProjekat = IDProjekat;
            this.IDZona = IDZona;
        }

        public SkeniranjeEntity()
        {
            

        }

    }
}
