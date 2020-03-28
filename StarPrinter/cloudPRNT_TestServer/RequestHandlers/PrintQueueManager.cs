using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;

namespace cloudPRNT_TestServer.RequestHandlers
{
    class PrintQueueManager : IRequestHandler
    {
        PrinterManager m_pmanager;
        private fastJSON.JSONParameters jp;

        public PrintQueueManager(PrinterManager m)
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
            if (request.Url.AbsolutePath == "/printers")
                return true;

            return false;
        }

        public bool handleRequest(HttpListenerContext context)
        {
            HttpListenerRequest request = context.Request;
            HttpListenerResponse response = context.Response;

            response.AddHeader("WWW-Authenticate","Basic Realm=\"cloudPRNT Management\"");

            string auth = request.Headers["Authorization"];

            string user = string.Empty;
            string pass = string.Empty;

            if(string.IsNullOrEmpty(auth))
            {
                webServer.GenerateError(response, 401, "Unauthorised");
                return true;
            }
            else
            {
                if(auth.ToLower().StartsWith("basic "))
                {
                    string credentials = Encoding.UTF8.GetString(Convert.FromBase64String(auth.Substring(6)));

                    string[] cl = credentials.Split(':');
                    if(cl.Length == 2)
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

            response.AppendHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
            response.AppendHeader("Pragma", "no-cache"); // HTTP 1.0.
            response.AppendHeader("Expires", "0"); // Proxies.

            response.ContentType = "text/html";

            StringBuilder sb = new StringBuilder();


            sb.Append("<html>");

            sb.Append("<head>");
            sb.Append("<meta http-equiv=\"refresh\" content=\"2;\">");
            sb.Append("<title>Star cloudPRNT sample server</title>");
            sb.Append("<link href=\"style.css\" rel=\"stylesheet\" type=\"text/css\" />");
            sb.Append("</head>");

            sb.Append("<body>");

            sb.Append("<h1>cloudPRNT Printer List</h1>");

            sb.Append("<table>");
            sb.Append("<tr><td><em>Printer ID</em></td><td><em>Jobs</em></td><td><em>Latency</em></td><td><em>Status</em></td><td><em>Print Actions</em></td><tr>");

            foreach (PrinterQueue pq in m_pmanager.m_queues)
            {
                int jobs = pq.jobCount;
           
                sb.Append("<tr>");

                sb.Append("<td><a href=\"PrinterDetails.html?mac=" + pq.Mac + "\">" + pq.Mac + ( (string.IsNullOrEmpty(pq.uniqueID)) ? ("") : (" (" + pq.uniqueID + ")") ) + "</a></td>");
                sb.Append("<td>" + jobs.ToString() + "</td>");
                sb.Append("<td>" + pq.latency.ToString() + "</td>");
                sb.Append("<td>" + pq.status + "</td>");
                //sb.Append("<td><a href=\"/demo?pid=" + pq.pId + "&demo=0\">Hello</a>");
                sb.Append("<td>");
                sb.Append("<a class=\"buttonlink\" href=\"/demo?pid=" + pq.Mac + "&file=pizza.dmo\">Pizza (Raster)</a>");
                sb.Append("<a class=\"buttonlink\" href=\"/demo?pid=" + pq.Mac + "&file=eco_col.png\">Eco (PNG)</a>");
                sb.Append("</td>");

                sb.Append("</tr>");
            }

            sb.Append("</table>");

            //sb.Append("<p><a href=\"/printers\">[Refresh]</a></p>");

            sb.Append("</body>");
            sb.Append("</html>");

            byte[] serveData = Encoding.UTF8.GetBytes(sb.ToString());
            response.ContentLength64 = serveData.LongLength;
            response.OutputStream.Write(serveData, 0, serveData.Length);

            return true;
        }
    }
}
