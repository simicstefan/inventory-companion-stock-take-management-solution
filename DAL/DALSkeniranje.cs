using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entity;

namespace DAL
{
    public class DALSkeniranje
    {
        public static DataTable DajSvejezike()
        {
            SqlConnection Conn = new SqlConnection(Connection.Conn);
            Conn.Open();
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("sp_DajSveJezike", Conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter adap = new SqlDataAdapter(cmd);
            adap.Fill(dt);
            Conn.Close();
            return dt;
        }

        public static DataTable DajIzvestaj()
        {
            SqlConnection Conn = new SqlConnection(Connection.Conn);
            Conn.Open();
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("sp_Izvestaj", Conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter adap = new SqlDataAdapter(cmd);
            adap.Fill(dt);
            Conn.Close();
            return dt;
        }


        public static DataTable DajSveSkeniranoZaKorisnika(int IDKorisnik)
        {
            SqlConnection Conn = new SqlConnection(Connection.Conn);
            Conn.Open();
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("sp_DajSveSkeniranoZaKorisnika", Conn);
            cmd.Parameters.AddWithValue("@IDKorisnik", IDKorisnik);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter adap = new SqlDataAdapter(cmd);
            adap.Fill(dt);
            Conn.Close();
            return dt;
        }

        public static DataSet VratiPodatke(int IDProjekat, int IDZona, int IDKorisnik)
        {

            SqlConnection Conn = new SqlConnection(Connection.Conn);
            Conn.Open();
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand("sp_VratiPodatke", Conn);
            cmd.Parameters.AddWithValue("@IDProjekat", IDProjekat);
            cmd.Parameters.AddWithValue("@IDZona", IDZona);
            cmd.Parameters.AddWithValue("@IDKorisnik", IDKorisnik);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter adap = new SqlDataAdapter(cmd);
            adap.Fill(ds);
            Conn.Close();
            ds.Tables[0].TableName = "Projekat";
            ds.Tables[1].TableName = "Zona";
            ds.Tables[2].TableName = "Korisnik";
            return ds;
        }

        public static DataTable PrijavaKorisnika(int IDKartica)
        {
            SqlConnection Conn = new SqlConnection(Connection.Conn);
            Conn.Open();
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("sp_PrijavaKorisnika", Conn);
            cmd.Parameters.AddWithValue("@IDKartica", IDKartica);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter adap = new SqlDataAdapter(cmd);
            adap.Fill(dt);
            Conn.Close();
            return dt;
        }

        public static void ObrisiSkeniranje(int ID)
        {
            SqlConnection conn = new SqlConnection(Connection.Conn);
            conn.Open();
            SqlCommand cmd = new SqlCommand("sp_ObrisiSkeniranje", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IDSkeniranje", ID);
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        public static void DodajSkeniranje(SkeniranjeEntity entitet)
        {                
            SqlConnection Conn = new SqlConnection(Connection.Conn);
            Conn.Open();
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("sp_DodajSkeniranje", Conn);
            cmd.Parameters.AddWithValue("@IDKorisnik", entitet.IDKorisnik);
            cmd.Parameters.AddWithValue("@OznakaMaterijala", entitet.OznakaMaterijala);
            cmd.Parameters.AddWithValue("@Kolicina", entitet.Kolicina);
            cmd.Parameters.AddWithValue("@Komentar", entitet.Komentar);
            cmd.Parameters.AddWithValue("@IDProjekat", entitet.IDProjekat);
            cmd.Parameters.AddWithValue("@IDZona", entitet.IDZona);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter adap = new SqlDataAdapter(cmd);
            adap.Fill(dt);
            Conn.Close();
        }

        public static DataTable DajSveProjekte()
        {
            SqlConnection Conn = new SqlConnection(Connection.Conn);
            Conn.Open();
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("sp_DajSveProjekteZaCmb", Conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter adap = new SqlDataAdapter(cmd);
            adap.Fill(dt);
            Conn.Close();
            return dt;
        }

        public static DataTable DajSveZone()
        {
            SqlConnection Conn = new SqlConnection(Connection.Conn);
            Conn.Open();
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("sp_DajSveZoneZaCmb", Conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter adap = new SqlDataAdapter(cmd);
            adap.Fill(dt);
            Conn.Close();
            return dt;
        }
    }
}
