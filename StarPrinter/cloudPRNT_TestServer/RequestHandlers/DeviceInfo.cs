using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace cloudPRNT_TestServer.RequestHandlers
{
    class DeviceInfo : IRequestHandler
    {
        PrinterManager m_pmanager;
        private fastJSON.JSONParameters jp;


        public DeviceInfo(PrinterManager m)
        {
            // Initialise clourprnt with a printer manager object
            m_pmanager = m;

            jp = new fastJSON.JSONParameters();
            jp.UseExtensions = false;
            jp.UseEscapedUnicode = true;
            jp.SerializeNullValues = true;
        }

        public bool canHandle(HttpListenerRequest request)
        {
            if (request.Url.AbsolutePath == "/deviceinfo")
                return true;

            return false;
        }

        public bool handleRequest(HttpListenerContext context)
        {
            StringBuilder replydata = new StringBuilder();

            HttpListenerRequest request = context.Request;
            HttpListenerResponse response = context.Response;

            response.AddHeader("WWW-Authenticate", "Basic Realm=\"cloudPRNT Management\"");

            string auth = request.Headers["Authorization"];

            string user = string.Empty;
            string pass = string.Empty;

            if (string.IsNullOrEmpty(auth))
            {
                webServer.GenerateError(response, 401, "Unauthorised");
                return true;
            }
            else
            {
                if (auth.ToLower().StartsWith("basic "))
                {
                    string credentials = Encoding.UTF8.GetString(Convert.FromBase64String(auth.Substring(6)));

                    string[] cl = credentials.Split(':');
                    if (cl.Length == 2)
                    {
                        user = cl[0];
                        pass = cl[1];
                    }
                }
            }

            if (user != "manager" || pass != "letmein")
            {
                webServer.GenerateError(response, 401, "Unauthorised");
                return true;
            }

            PrinterQueue q = m_pmanager.getQueueByMac(request.QueryString["mac"]);
            if (q == null)
            {
                webServer.GenerateError(response, 404, "Printer not found");
                return true;
            }

            if(! string.IsNullOrEmpty(request.QueryString["setuid"]))
            {
                q.setNewUID(WebUtility.UrlDecode(request.QueryString["setuid"]));
            }

            response.AppendHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
            response.AppendHeader("Pragma", "no-cache"); // HTTP 1.0.
            response.AppendHeader("Expires", "0"); // Proxies.

            response.ContentType = "application/json";


            uijson.DeviceInfoPack pack = new uijson.DeviceInfoPack(q);

            string responseString = fastJSON.JSON.ToNiceJSON(pack, jp);

            byte[] serveData = System.Text.Encoding.UTF8.GetBytes(responseString);
            response.ContentLength64 = serveData.LongLength;
            response.OutputStream.Write(serveData, 0, serveData.Length);

            return true;

        }
    }
}
