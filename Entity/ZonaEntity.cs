﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class ZonaEntity
    {

        public int IDZona { get; set; }
        public string NazivZona { get; set; }

        public ZonaEntity(int iDZona, string nazivZona)
        {
            IDZona = iDZona;
            NazivZona = nazivZona;
        }

        public ZonaEntity()
        {
 
        }


    }
}
