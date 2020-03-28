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
    class LocalFile : IRequestHandler
    {
        public bool canHandle(System.Net.HttpListenerRequest request)
        {
            return true;        // Should always be the last handler in the chain, since it will try to accept everything
        }

        public bool handleRequest(System.Net.HttpListenerContext context)
        {
            HttpListenerRequest request = context.Request;
            HttpListenerResponse response = context.Response;

            try
            {
                string reqPath = request.Url.AbsolutePath;

                if (reqPath == "" || reqPath == "/" || reqPath == "\\")
                    reqPath = "/index.html";

                byte[] serveData = File.ReadAllBytes(Application.StartupPath + "/htdocs/" + reqPath);

                response.ContentType = MIMEtype(reqPath);
                response.ContentLength64 = serveData.Length;
                System.IO.Stream output = response.OutputStream;
                output.Write(serveData, 0, serveData.Length);
                output.Close();
            }
            catch (FileNotFoundException fnfe)
            {
                webServer.GenerateError(response, 404, "File Not Found");
            }
            catch (Exception e)
            {
                webServer.GenerateError(response, 404, "File Not Found");
            }

            return true;
        }

        private string MIMEtype(string source)
        {
            // Generate a mime type string, baser on the extension of the served source file

            string norm = source.ToLower();

            if (norm.EndsWith(".html") || norm.EndsWith(".htm"))
                return "text/html";
            else if (norm.EndsWith(".css"))
                return "text/css";
            else if (norm.EndsWith(".js"))
                return "application/ecmascript";
            else if (norm.EndsWith(".txt"))
                return "text/plain";
            else if (norm.EndsWith(".jpg") || norm.EndsWith(".jpeg"))
                return "image/jpeg";
            else if (norm.EndsWith(".png"))
                return "image/png";
            else
                return "application/octet-stream";

        }

    }
}
