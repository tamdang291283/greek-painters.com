using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Net;
using cloudPRNT_TestServer.cloudPrntJson;

namespace cloudPRNT_TestServer.RequestHandlers
{
    class cloudprnt : IRequestHandler
    {

        PrinterManager m_pmanager;
        public int pollInterval = 1;

        private fastJSON.JSONParameters jp;


        public cloudprnt(PrinterManager m)
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
            if (request.Url.AbsolutePath == "/starcloudprnt")
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

            if (! string.IsNullOrEmpty(auth))
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

            byte[] serveData = null;
            string serverfile = request.Url.AbsolutePath;

            //logHandler(serverfile);

            try
            {
                if (request.HttpMethod == "POST")
                {
                    // dsable caching, although webprnt clients won't cache anyway, it may cause a problem when using testing tools or a proxy service.
                    response.AppendHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
                    response.AppendHeader("Pragma", "no-cache"); // HTTP 1.0.
                    response.AppendHeader("Expires", "0"); // Proxies.

                    // Get the body and decode into a cpPollRequest
                    byte[] bodyData = new byte[(int)request.ContentLength64];
                    request.InputStream.Read(bodyData, 0, (int)request.ContentLength64);
                    string bodyStr = Encoding.UTF8.GetString(bodyData);
                    cpPollRequest cpReq = fastJSON.JSON.ToObject<cpPollRequest>(bodyStr, jp);

                    //logHandler(bodyStr);

                    PrinterQueue q = m_pmanager.getQueueByMac(cpReq.printerMAC);
                    if (q == null)
                    {
                        m_pmanager.AddPrinterQueue(cpReq.printerMAC);

                        q = m_pmanager.getQueueByMac(cpReq.printerMAC);

                        if (q == null)
                        {
                            webServer.GenerateError(response, 404, "Printer not found");
                            return true;
                        }
                    }

                    if (q.useHttpBasicAuth)
                        response.AddHeader("WWW-Authenticate", "Basic Realm=\"cloudPRNT " + q.Mac + "\"");

                    if (!q.ValidateCredentials(user, pass))
                    {
                        webServer.GenerateError(response, 401, "Unauthorised");
                        q.status = "Authentication Failed!";
                        return true;
                    }

                    if(cpReq.uniqueID != q.uniqueID)
                    {
                        q.uniqueID = cpReq.uniqueID;
                    }

                    q.status = WebUtility.UrlDecode(cpReq.statusCode);
                    q.asbStatus = cpReq.status;

                    if ( ! cpReq.statusCode.Trim().StartsWith("2"))
                    {
                        q.printing = false;         // all non-ok statuses mean thet printing has stopped;
                    }

                    // Check for client action responses
                    if(cpReq.clientAction != null)
                    {
                        foreach(cpClientActionRequest caReq in cpReq.clientAction)
                        {
                            if (caReq.request == "GetPollInterval")
                            {
                                q.latency = int.Parse(caReq.result);
                            }
                            else if (caReq.request == "ClientType")
                            {
                                q.clientType = caReq.result;
                            }
                            else if (caReq.request == "ClientVersion")
                            {
                                q.clientVersion = caReq.result;
                            }
                            else if (caReq.request == "Encodings")
                            {
                                q.supportedContentEncodings = caReq.result;
                            }
                        }
                    }


                    // Create cpPollResponse for the reply
                    cpPollResponse presp = new cpPollResponse();

                    // Set the print jbs available flag correctly.
                    presp.jobReady = (q.jobCount > 0);

                    if (presp.jobReady)
                    {
                        if (presp.mediaTypes == null)
                            presp.mediaTypes = new List<string>();

                        if (string.IsNullOrEmpty(q.getCurrentJob().mediaType))
                            presp.mediaTypes.Add("application/octet-stream");
                        else
                        {
                            string[] tlist = q.getCurrentJob().mediaType.Split(new char[] { ';' });
                            foreach (string t in tlist)
                                presp.mediaTypes.Add(t.Trim());
                        }
                    }

                    // set up any client action requests
                    List<cpClientActionResponse> caResp = new List<cpClientActionResponse>();
                    if(q.latency < 0)
                    {
                        caResp.Add(new cpClientActionResponse("GetPollInterval", ""));
                    }

                    if (string.IsNullOrEmpty(q.clientType))
                    {
                        caResp.Add(new cpClientActionResponse("ClientType", ""));
                        q.clientType = "n/a";
                    }

                    if (string.IsNullOrEmpty(q.clientVersion))
                    {
                        caResp.Add(new cpClientActionResponse("ClientVersion", ""));
                        q.clientVersion = "n/a";
                    }

                    if (string.IsNullOrEmpty(q.supportedContentEncodings))
                    {
                        caResp.Add(new cpClientActionResponse("Encodings", ""));
                        q.supportedContentEncodings = "n/a";
                    }

                    if (! string.IsNullOrEmpty(q.changeUniqueID))
                    {
                        if (q.changeUniqueID == cpReq.uniqueID)
                        {
                            q.changeUniqueID = string.Empty;
                        }
                        else
                        {
                            caResp.Add(new cpClientActionResponse("SetID", q.changeUniqueID));
                            q.changeUniqueID = string.Empty;
                        }
                    }

                    if (caResp.Count > 0)
                    {
                        presp.clientAction = caResp;
                    }


                    // convert cpPollResponse to json and send it back to the client
                    string responseString = fastJSON.JSON.ToNiceJSON(presp, jp);

                    serveData = System.Text.Encoding.UTF8.GetBytes(responseString);
                    response.ContentType = "application/json";
                    response.StatusCode = 200;
                    response.StatusDescription = "OK";

                    //logHandler(responseString);

                    //logHandler(serverfile + " [Content-Type: " + request.ContentType + "]");
                }
                else if (request.HttpMethod == "GET")
                {
                    //logHandler(request.RawUrl);

                    // decode the parameters from the query string
                    string pid = request.QueryString["uid"];
                    string mac = request.QueryString["mac"];
                    string type = request.QueryString["type"];


                    if (string.IsNullOrEmpty(mac))
                    {
                        webServer.GenerateError(response, 404, "Printer MAC address not specified not found");
                        return true;
                    }

                    PrinterQueue q = m_pmanager.getQueueByMac(mac);
                    if (q == null)
                    {
                        webServer.GenerateError(response, 404, "Printer not found");
                        return true;
                    }

                    if (q.jobCount == 0)
                    {
                        webServer.GenerateError(response, 404, "no job data");
                        return true;
                    }

                    printJob pj;

                    pj = q.getCurrentJob();
                    q.printing = true;


                    if (pj == null)
                    {
                        q.printing = false;
                        webServer.GenerateError(response, 404, "Job does not exist");
                        return true;
                    }

                    serveData = pj.GenerateData(type); 

                    if (serveData == null)
                    {
                        q.printing = false;
                        q.deleteJob();              // An empty job, so just remove it

                        webServer.GenerateError(response, 410, "Job does not exist");

                        return true;
                    }      

                    response.ContentType = pj.LastGeneratedEncoding;
                    response.StatusCode = 200;
                    response.StatusDescription = "OK";
                }
                else if (request.HttpMethod == "DELETE")
                {
                    //logHandler(request.RawUrl);

                    // decode the parameters from the query string
                    string uid = request.QueryString["uid"];
                    string mac = request.QueryString["mac"];
                    string code = request.QueryString["code"];



                    if (string.IsNullOrEmpty(mac))
                    {
                        webServer.GenerateError(response, 404, "Printer not found");
                        return true;
                    }

                    PrinterQueue q = m_pmanager.getQueueByMac(mac);
                    if (q == null)
                    {
                        webServer.GenerateError(response, 404, "Printer not found");
                        return true;
                    }
                    else
                    {
                        q.printing = false;
                    }
                    
                    if (q.jobCount == 0)
                    {
                        webServer.GenerateError(response, 404, "Job data not found");
                        return true;
                    }

                    q.deleteJob();

                    response.ContentType = "";
                    response.StatusCode = 200;
                    response.StatusDescription = "OK";
                }
                else
                {
                    webServer.GenerateError(response, 400, "Bad Request");
                    return true;
                }

                response.ContentLength64 = serveData.Length;
                System.IO.Stream output = response.OutputStream;
                output.Write(serveData, 0, serveData.Length);
                // You must close the output stream.
                output.Close();
                return true;
            }
            catch (Exception ex)
            {
                webServer.GenerateError(response, 400, "Bad Request");
            }

            return true;
        }
    }
}
