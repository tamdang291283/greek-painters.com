using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;

namespace cloudPRNT_TestServer.cloudPrntJson
{
    [Serializable]
    public class cpPollRequest
    {
        public string status;
        public string printerMAC;
        public string uniqueID;
        public string statusCode;
        public List<cpClientActionRequest> clientAction;

        public cpPollRequest()
        {
            //clientAction = new List<cpClientActionRequest>();
        }

    }
}
