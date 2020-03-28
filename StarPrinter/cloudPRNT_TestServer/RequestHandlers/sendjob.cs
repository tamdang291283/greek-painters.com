using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using cloudPRNT_TestServer.cloudPrntJson;

namespace cloudPRNT_TestServer.RequestHandlers
{
    class sendjob : IRequestHandler
    {
        PrinterManager m_pmanager;
        private fastJSON.JSONParameters jp;

        public sendjob(PrinterManager m)
        {
            // Initialise clourprnt with a printer manager object
            m_pmanager = m;

            jp = new fastJSON.JSONParameters();
            jp.UseExtensions = false;
            jp.UseEscapedUnicode = true;
            jp.SerializeNullValues = true;
        }


        public bool canHandle(System.Net.HttpListenerRequest request)
        {
            if (request.Url.AbsolutePath == "/sendjob")
                return true;
            else if (request.Url.AbsolutePath == "/addOrder")
                return true;


            return false;
        }

        public bool handleRequest(System.Net.HttpListenerContext context)
        {
            HttpListenerRequest request = context.Request;
            HttpListenerResponse response = context.Response;

            string auth = request.Headers["Authorization"];

            string user = string.Empty;
            string pass = string.Empty;

            if (!string.IsNullOrEmpty(auth))
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

            if (request.Url.AbsolutePath == "/addOrder" && request.HttpMethod == "POST")
            {
                return handleAddOrder(context);
            }


            byte[] serveData = null;
            string serverfile = request.Url.AbsolutePath;

            //try
            //{
            //    // Never cache the PUT response
            //    response.AppendHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
            //    response.AppendHeader("Pragma", "no-cache"); // HTTP 1.0.
            //    response.AppendHeader("Expires", "0"); // Proxies.

            //    // Get the body and decode into a cpPollRequest
            //    byte[] bodyData = new byte[(int)request.ContentLength64];
            //    request.InputStream.Read(bodyData, 0, (int)request.ContentLength64);
            //    string bodyStr = Encoding.UTF8.GetString(bodyData);
            //    cpPollRequest cpReq = fastJSON.JSON.ToObject<cpPollRequest>(bodyStr, jp);

            //    //logHandler(bodyStr);

            //    PrinterQueue q = m_pmanager.getQueueById(cpReq.printerId);
            //    if (q == null)
            //    {
            //        webServer.GenerateError(response, 404, "Printer ID not found");
            //        return true;
            //    }

            //    if (q.useHttpBasicAuth)
            //        response.AddHeader("WWW-Authenticate", "Basic Realm=\"cloudPRNT " + q.pId + "\"");

            //    if (!q.ValidateCredentials(user, pass))
            //    {
            //        webServer.GenerateError(response, 401, "Unauthorised");
            //        q.status = "Authentication Failed!";
            //        return true;
            //    }
            //}
            //catch (Exception ex)
            //{
            //    webServer.GenerateError(response, 400, "Bad Request");
            //}

            webServer.GenerateError(response, 400, "Bad Request");

            return true;

        }

        bool handleAddOrder(System.Net.HttpListenerContext context)
        {
            HttpListenerRequest request = context.Request;
            HttpListenerResponse response = context.Response;

            response.AppendHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
            response.AppendHeader("Pragma", "no-cache"); // HTTP 1.0.
            response.AppendHeader("Expires", "0"); // Proxies.

            string pid = request.QueryString["pid"];

            PrinterQueue pq = m_pmanager.getQueueByMac(pid);

            byte[] bodyData = new byte[(int)request.ContentLength64];
            request.InputStream.Read(bodyData, 0, (int)request.ContentLength64);
            string bodyStr = Encoding.UTF8.GetString(bodyData);

            uijson.orderRequest order = fastJSON.JSON.ToObject<uijson.orderRequest>(bodyStr, jp);

            pq.AddJob(order);


            webServer.GenerateError(response, 200, "OK");

            return true;
        }
    }
}
