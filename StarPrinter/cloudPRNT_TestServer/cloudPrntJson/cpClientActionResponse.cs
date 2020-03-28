using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace cloudPRNT_TestServer.cloudPrntJson
{
    [Serializable]
    public class cpClientActionResponse
    {
        public string request;
        public string options;

        public cpClientActionResponse()
        {
            //request = string.Empty;
            //options = string.Empty;
        }

        public cpClientActionResponse(string cpRequest, string cpOptions)
        {
            request = cpRequest;
            options = cpOptions;
        }
    }
}
