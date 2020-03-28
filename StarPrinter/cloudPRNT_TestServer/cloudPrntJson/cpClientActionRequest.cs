using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;

namespace cloudPRNT_TestServer.cloudPrntJson
{
    [Serializable]
    public class cpClientActionRequest
    {
        public string request;
        public string result;

        public cpClientActionRequest()
        {
            //request = string.Empty;
            //result = string.Empty;
        }

        public cpClientActionRequest(string caRequest, string caResult)
        {
            request = caRequest;
            result = caResult;
        }
    }
}
