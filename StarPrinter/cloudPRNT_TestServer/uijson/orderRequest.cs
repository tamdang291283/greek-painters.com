using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace cloudPRNT_TestServer.uijson
{
    [Serializable]
    public class orderRequest
    {
        public String name = string.Empty;
        public String address = string.Empty;

        public bool tsp650 = false;
        public bool tsp700 = false;
        public bool tsp800 = false;
        public bool sp700 = false;

        public bool allowText = false;
        public bool allowStarLine = false;
        public bool allowPNG = false;
        public bool allowJpeg = false;
    }
}
