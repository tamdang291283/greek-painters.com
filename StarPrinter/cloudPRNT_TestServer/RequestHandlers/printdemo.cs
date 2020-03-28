using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Windows.Forms;
using System.Net;

namespace cloudPRNT_TestServer.RequestHandlers
{
    class printdemo : IRequestHandler
    {
        PrinterManager m_pmanager;
        private fastJSON.JSONParameters jp;

        public printdemo(PrinterManager m)
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
            if (request.Url.AbsolutePath == "/demo")
                return true;

            return false;
        }

    

        public bool handleRequest(HttpListenerContext context)
        {
            HttpListenerRequest request = context.Request;
            HttpListenerResponse response = context.Response;

            response.AppendHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
            response.AppendHeader("Pragma", "no-cache"); // HTTP 1.0.
            response.AppendHeader("Expires", "0"); // Proxies.

            string pid = request.QueryString["pid"];
            string demo = request.QueryString["demo"];
            string file = request.QueryString["file"];
            string redirect = request.QueryString["redirect"];

            PrinterQueue pq = m_pmanager.getQueueByMac(pid);

            if(pq == null)
            {
                webServer.GenerateError(response, 404, "Not found");
                return true;
            }

            if(string.IsNullOrEmpty(demo) && string.IsNullOrEmpty(file))
            {
                demo = "";      // outbut the unknown demo
            }


            file = Application.StartupPath + "/demos/" + file;

            if(string.IsNullOrEmpty(demo) && File.Exists(file))
            {
                // Printing from file
                byte[] printData = File.ReadAllBytes(file);
                if(file.ToLower().EndsWith(".png"))
                    pq.AddJob(printData, "image/png");
                else
                    pq.AddJob(printData);
            }
            else
            { 
                // simple built-in demos
                StringBuilder ds = new StringBuilder();

                switch(demo)
                {
                    case "0":
                        ds.Append("Hello World!\n\n\n\n\n\n\x1b" + "d0");
                        break;

                    case "1":
                        ds.Append("Goodbye world\n\n\n\n\n\n\n\n\x1b" + "d0");
                        break;

                    default:
                        ds.Append("Unknown demo ID!\n\n\n\n\n\n\x1b" + "d0");
                        break;
                }

                byte[] printData = Encoding.UTF8.GetBytes(ds.ToString());
                pq.AddJob(printData, "application/vnd.starline");
            }

            //webServer.GenerateError(response, 200, "OK");
            if (redirect == "no")
            {
                response.ContentType = "text/plain";
                byte[] serveData = System.Text.Encoding.UTF8.GetBytes("ok");
                response.ContentLength64 = serveData.LongLength;
                response.OutputStream.Write(serveData, 0, serveData.Length);
            }
            else
            {
                response.Redirect("/printers");
            }

            response.OutputStream.Close();

            return true;
        }
    }
}
