using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;

namespace cloudPRNT_TestServer.RequestHandlers
{
    public interface IRequestHandler
    {
        bool canHandle(HttpListenerRequest request);
        bool handleRequest(HttpListenerContext context);
    }
}
