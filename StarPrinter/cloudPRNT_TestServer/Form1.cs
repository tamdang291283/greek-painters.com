using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Net;
using System.Diagnostics;

namespace cloudPRNT_TestServer
{
    public partial class Form1 : Form
    {
        private webServer cloudPRNT;

        public Form1()
        {
            InitializeComponent();

            cloudPRNT = new webServer();
            cloudPRNT.logHandler = log;

            string sHostName = Dns.GetHostName();
            IPHostEntry ipE = Dns.GetHostByName(sHostName);
            IPAddress[] IpA = ipE.AddressList;

            LinkLabel.Link l = new LinkLabel.Link();

            if (IpA.Length == 0)
            {
                label3.Hide();

                l.LinkData = "http://localhost:8080";

            }
            else
            {
                l.LinkData = String.Format("http://{0}:8080", IpA[0].ToString());
                label3.Text = String.Format("http://{0}:8080/starcloudprnt", IpA[0].ToString());
            }
            linkLabel2.Text = l.LinkData.ToString();
            linkLabel2.Links.Add(l);

            timer1.Start();
        }

        ~Form1()
        {
            cloudPRNT.Close();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            labelHits.Text = "Hits: " + cloudPRNT.hits.ToString();
        }

        private void log(string info)
        {
            this.Invoke((MethodInvoker)delegate
            {
                textBoxLog.Text += string.Format("{0}\x0d\x0a", info);
            });
        }

        private void buttonAdd_Click(object sender, EventArgs e)
        {
            string hello = "Hello World\n\n\n\n\n\n\n\n\x1b" + "d2";
            cloudPRNT.m_pmanager.getQueueByMac("Test1").AddJob(Encoding.UTF8.GetBytes(hello));
        }

        private void linkLabel2_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            Process.Start(e.Link.LinkData as string);
        }

        private void buttonClearLog_Click(object sender, EventArgs e)
        {
            this.textBoxLog.Text = string.Empty;
        }
    }
}
