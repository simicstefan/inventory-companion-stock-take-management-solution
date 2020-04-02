using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class Connection
    {
        public static string Conn = ConfigurationManager.ConnectionStrings["Connection1"].ToString();
    }
}
