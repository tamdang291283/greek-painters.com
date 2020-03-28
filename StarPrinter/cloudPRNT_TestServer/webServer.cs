using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.IO;

using cloudPRNT_TestServer.cloudPrntJson;

namespace cloudPRNT_TestServer
{
    class webServer
    {
        //private BaseConfiguration mConfig;
        private HttpListener mListener;
        public int hits = 0;

        public delegate void log(string info);
        public log logHandler;
     
        public PrinterManager m_pmanager = new PrinterManager();

        private List<RequestHandlers.IRequestHandler> m_pageRequestHandlers;

        public webServer()
        {
            m_pageRequestHandlers = new List<RequestHandlers.IRequestHandler>();

            m_pageRequestHandlers.Add(new RequestHandlers.cloudprnt(m_pmanager));
            m_pageRequestHandlers.Add(new RequestHandlers.PrintQueueManager(m_pmanager));
            m_pageRequestHandlers.Add(new RequestHandlers.printdemo(m_pmanager));
            m_pageRequestHandlers.Add(new RequestHandlers.DeviceInfo(m_pmanager));
            m_pageRequestHandlers.Add(new RequestHandlers.sendjob(m_pmanager));

            m_pageRequestHandlers.Add(new RequestHandlers.LocalFile());

            
            InitRequestHandlers();

            m_pmanager.AddPrinterQueue("00:11:e5:06:04:ff");
            m_pmanager.AddPrinterQueue("00001");
            m_pmanager.AddPrinterQueue("00002");
            m_pmanager.AddPrinterQueue("00003");
            m_pmanager.AddPrinterQueue("00004");
            //m_pmanager.AddPrinterQueue("00005");
            //m_pmanager.AddPrinterQueue("00006");
            //m_pmanager.AddPrinterQueue("Mano1");
            //m_pmanager.AddPrinterQueue("Mano2");
            //m_pmanager.AddPrinterQueue("Test1");
            //m_pmanager.AddPrinterQueue("Test2");
            //m_pmanager.AddPrinterQueue("Lawrence1");
            //m_pmanager.AddPrinterQueue("Lawrence2");
            //m_pmanager.AddPrinterQueue("Pearce1");
            //m_pmanager.AddPrinterQueue("Pearce2");
            //m_pmanager.AddPrinterQueue("Yukie");
            //m_pmanager.AddPrinterQueue("Yukie2");
            //m_pmanager.AddPrinterQueue("Avanti1");

            //m_pmanager.getQueueByMac("Lawrence2").RequireAuth("lawrence", "cloudPRNT");
            //m_pmanager.getQueueByMac("Yukie2").RequireAuth("yukie", "demo");
            //m_pmanager.getQueueByMac("Avanti1").RequireAuth("Avanti", "cloudPRNT");


            mListener = new HttpListener();
            mListener.Prefixes.Add(String.Format("http://+:{0}/", "8080"));
            //mListener.Realm = "";
            //mListener.AuthenticationSchemes = AuthenticationSchemes.Basic;
            mListener.Start();
            mListener.BeginGetContext(new AsyncCallback(RequestBroker), mListener);
            //System.Diagnostics.EventLog.WriteEntry("Star Web Server", "Server Started.");

        }

        public void Start()
        {

        }

        public void Close()
        {
            mListener.Stop();
        }

        private void InitRequestHandlers()
        {
            //foreach (IRequestHandler rh in mConfig.RequestHandlers)
            //    rh.WebServer = this;
        }

        //internal BaseConfiguration Configuration
        //{
        //    get { return mConfig; }
        //}

        internal string getMimeType(string extension)
        {
            try
            {
                //return mConfig.ExtentionMimeTypes[extension.ToLower()];
                return string.Empty;
            }
            catch
            {
                return string.Empty;
            }
        }

        public static void GenerateError(HttpListenerResponse response, int code, string desc)
        {
            response.StatusCode = code;
            response.StatusDescription = desc;

            string e = String.Format("<html><body><h1>Error {0}, {1}</h1><h2>Computer says no.</h2></body></html>", code.ToString(), desc);

            byte[] serveData = Encoding.UTF8.GetBytes(e);
            response.ContentLength64 = serveData.LongLength;
            response.OutputStream.Write(serveData, 0, serveData.Length);

            response.OutputStream.Close();
        }

        public void RequestBroker(IAsyncResult result)
        {
            hits++;

            try
            {
                HttpListener listener = (HttpListener)result.AsyncState;
                // Call EndGetContext to complete the asynchronous operation.
                HttpListenerContext context = listener.EndGetContext(result);
                listener.BeginGetContext(new AsyncCallback(RequestBroker), listener);

                //HttpListenerRequest request = context.Request;

                //// Obtain a response object.
                //HttpListenerResponse response = context.Response;

                //if(context.Request.Url.AbsolutePath.EndsWith("/starcloudprnt") && context.Request.HttpMethod != "POST")
                if (context.Request.Url.AbsolutePath.EndsWith("/starcloudprnt"))
                    logHandler("http (" + context.Request.HttpMethod + ") " + context.Request.Url.AbsolutePath + context.Request.Url.Query);


                // Try each handler, in list order
                bool handled = false;
                foreach (RequestHandlers.IRequestHandler rh in m_pageRequestHandlers)
                {
                    if(rh.canHandle(context.Request))
                    {
                        handled = rh.handleRequest(context);
                        if (handled)
                            break;
                    }
                }

                if (!handled)
                    GenerateError(context.Response, 404, "Not found");

            }
            catch (HttpListenerException hlex)
            {
                System.Diagnostics.EventLog.WriteEntry("Star Web Server", "HttpListenerException: " + hlex.Message);
            }
        }


    }
}
