using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace cloudPRNT_TestServer
{
    class PrinterManager
    {
        private string m_status;
        public string status { set { m_status = value; } get { return m_status; } }

        public List<PrinterQueue> m_queues;


        public PrinterManager()
        {
            m_queues = new List<PrinterQueue>();
        }
        
        public PrinterQueue getQueueByMac(string mac)
        {
            foreach ( PrinterQueue pq in m_queues )
            {
                if (pq.Mac == mac)
                    return pq;
            }

            return null;
        }

        public void AddPrinterQueue(string id)
        {
            if (getQueueByMac(id) != null)
                return;

            m_queues.Add(new PrinterQueue(id));
        }


    }
}
