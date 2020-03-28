using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;

namespace Test
{
    [Serializable]
    public class cpPollResponse
    {
        //public string setToken;
        public bool jobReady;
        public List<string> mediaTypes;
        //public List<cpClientActionResponse> clientAction;
    }
}
