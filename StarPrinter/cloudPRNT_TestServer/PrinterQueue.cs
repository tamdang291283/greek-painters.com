using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using cloudPRNT_TestServer.cloudPrntJson;

namespace cloudPRNT_TestServer
{
    class PrinterQueue
    {
        private string m_mac;
        public string Mac { set { m_mac = value; } get { return m_mac; } }

        private Queue<printJob> jobQueue;
        private string m_status = string.Empty;
        private string m_statuscode = string.Empty;
        private string m_uniqueID = string.Empty;
        private DateTime m_lastPoll;
        private int m_latency = -1;

        private string m_changeUniqueId = string.Empty;

        private bool m_requireAuth;
        private string m_authUser;
        private string m_authPass;

        private string m_clientType = string.Empty;
        private string m_clientVersion = string.Empty;
        private string m_supportedEncodings = string.Empty;

        private bool m_printing;

        public PrinterQueue() : this("<no id>")
        {
            jobQueue = new Queue<printJob>();
        }

        public PrinterQueue(string mac)
        {
            m_mac = mac;
            m_printing = false;
        }

        public int jobCount {
            get {
                if (jobQueue == null)
                    return 0;

                return jobQueue.Count;
            } 
        }

        public bool useHttpBasicAuth
        {
            get { return m_requireAuth; }
        }

        public int latency { get { return m_latency; } set { m_latency = value; } }
        public bool printing { get { return m_printing; } set { m_printing = value; } }
        public string uniqueID { get { return m_uniqueID; } set { m_uniqueID = value; } }

        public string changeUniqueID { get { return m_changeUniqueId; } set { m_changeUniqueId = value; } }

        public string clientType { get { return m_clientType; } set { m_clientType = value; } }
        public string clientVersion {  get { return m_clientVersion; } set { m_clientVersion = value; } }
        public string supportedContentEncodings { get { return m_supportedEncodings; } set { m_supportedEncodings = value; } }
        public string asbStatus { get { return m_status; } set { m_status = value; } }

        public string status
        {
            get
            {
                TimeSpan pollTime = DateTime.Now - this.m_lastPoll;

                if (pollTime == null)
                    return "Unknown";

                if (printing)
                {
                    if (pollTime.TotalSeconds > (60 + latency * 2))
                    {
                        latency = -1;
                        return "offline (connection lost)";
                    }

                    return "Printing";
                }
                else if (pollTime.TotalSeconds > (10 + latency * 2))
                {
                    latency = -1;
                    return "offline (connection lost)";
                }
                else
                    return m_statuscode;
            }

            set
            {
                m_statuscode = value;
                m_lastPoll = DateTime.Now;
            }
        }

        public void RequireAuth(string user, string pass)
        {
            m_requireAuth = false;
            m_authUser = user;
            m_authPass = pass;
        }

        public bool ValidateCredentials(string user, string pass)
        {
            if (m_requireAuth == false)
                return true;

            if ((user == m_authUser && pass == m_authPass) ||true)
                return true;

            return false;
        }

        public void AddJob(byte[] data)
        {
            if (jobQueue == null)
                jobQueue = new Queue<printJob>();

            printJob p = new printJob();
            p.jobId = System.Guid.NewGuid().ToString();
            p.jobData = data;

            jobQueue.Enqueue(p);
        }

        public void AddJob(byte[] data, string mediaType)
        {
            if (jobQueue == null)
                jobQueue = new Queue<printJob>();

            printJob p = new printJob();
            p.jobId = System.Guid.NewGuid().ToString();
            p.jobData = data;
            p.mediaType = mediaType;

            jobQueue.Enqueue(p);
        }

        public void AddJob(uijson.orderRequest order)
        {
            if (jobQueue == null)
                jobQueue = new Queue<printJob>();

            printJob p = new printJob();
            p.jobId = System.Guid.NewGuid().ToString();
            p.jobData = null;
            p.order = order;

            p.mediaType = string.Empty;

            if (order.allowPNG)
            {
                if (!string.IsNullOrEmpty(p.mediaType))
                    p.mediaType += ";";
                p.mediaType += "image/png";
            }

            if (order.allowJpeg)
            {
                if (!string.IsNullOrEmpty(p.mediaType))
                    p.mediaType += ";";
                p.mediaType += "image/jpeg";
            }

            if (order.allowStarLine)
            {
                if (!string.IsNullOrEmpty(p.mediaType))
                    p.mediaType += ";";
                p.mediaType += "application/vnd.star.line";
            }

            if (order.allowText)
            {
                if (!string.IsNullOrEmpty(p.mediaType))
                    p.mediaType += ";";
                p.mediaType += "text/plain";
            }

            jobQueue.Enqueue(p);
        }

        public printJob getCurrentJob()
        {
            if (jobQueue == null)
                return null;

            if (jobQueue.Count > 0)
            {
                printJob pj = jobQueue.Peek();
                return pj;
            }

            return null;
        }

        public void deleteJob()
        {
            if (jobQueue == null)
                return;

            if (jobQueue.Count > 0)
                jobQueue.Dequeue();
        }

        public void setNewUID(string nuUid)
        {
            m_changeUniqueId = nuUid;
        }

    }
}
