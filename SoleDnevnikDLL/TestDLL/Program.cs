using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eDnevnikDLL
{
    class Program
    {
        static void Main(string[] args)
        {
            //Test professor
           Profesor prof = new Profesor();
            prof.ImeProfesora = "Le"; //Data anotacija treba da ga izbaci
            prof.Email = "nindza@kornjaca.com";
            prof.KontaktTelefon = "123";
            prof.LoginSifra = "abcd";
            prof.Admin = false;
            prof.NazivPredmeta = "Umetnost";
            prof.BrojOdeljenja = 2;
            prof.GodinaSkolovanja = 1;
            prof.SkolskaGodina = 2018;
            Console.WriteLine(VezaSBazom.DodavanjeProfesora(prof));
            Console.ReadKey();

            //int vracenID = -1;
           // string maticniID = "";

            //Console.WriteLine(VezaSBazom.LoginKorisnika("Em1", "neki hash", ref vracenID , ref maticniID ));
            //Console.WriteLine(vracenID);
            //Console.WriteLine(maticniID);
            //Console.ReadKey();





        }
    }
}
