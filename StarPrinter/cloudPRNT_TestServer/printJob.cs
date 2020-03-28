using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;

namespace cloudPRNT_TestServer
{
    class printJob
    {
        public string jobId;
        public byte[] jobData;
        public string mediaType;
        public uijson.orderRequest order = null;


        private string m_returnedEncoding;
        public string LastGeneratedEncoding {  get { return m_returnedEncoding; } }

        /// <summary>
        /// Generate the print job in the required encoding (if available)
        /// If not available, then just return the encoding that is.
        /// </summary>
        /// <param name="encding"></param>
        /// <returns></returns>
        public byte[] GenerateData(string encoding)
        {
            if(jobData != null)
            {
                if (string.IsNullOrEmpty(mediaType))
                    m_returnedEncoding = "application/octet-stream";                            // unknown binary data
                else
                {
                    // if the requested encoding is in the mediaType list provided then return it
                    // otherwise return the first listed encoding
                    // It may not make much different, because the jobData is already fixed, but could cause the client
                    // to handler the job in different ways (.e. if octet-stream, print verification is disabled)
                    string[] encList = mediaType.Split(new char[] { ';' });
                    m_returnedEncoding = encList[0];

                    foreach (string enc in encList)
                        if (enc == encoding)
                            m_returnedEncoding = encoding;
                }

                return jobData;
            }

            if (order == null)
            {
                m_returnedEncoding = "application/octet-stream";
                return jobData;
            }

            if (encoding == "text/plain")
                return renderOrderToText();

            if (encoding == "application/vnd.star.line")
                return renderOrderToStarLine();

            if (encoding == "image/png")
                return renderToPNG();

            if (encoding == "image/jpeg")
                return renderToJpeg();

            return renderOrderToText();             // use plain tex as fallback option, since almost any cient can handle it.
        }


        private byte[] renderOrderToText()
        {
            m_returnedEncoding = "text/plain";

            StringBuilder sb = new StringBuilder();
            sb.Append("New Order\n");
            sb.Append("========================================\n\n");

            sb.AppendFormat("  Deliver to: {0}\n", order.name);

            string[] addressLines = order.address.Split(new char[] { ',' });
            sb.AppendFormat("  At Address: {0}\n", addressLines[0].Trim());

            if(addressLines.Length > 1)
            {
                for (int al = 1; al < addressLines.Length; al++)
                    sb.AppendFormat("              {0}\n", addressLines[al].Trim());
            }

            sb.Append("\n\n");
            sb.Append("Products to Deliver\n");
            sb.Append("----------------------------------------\n\n");

            if (order.tsp650)
                sb.Append("  1x Star TSP654vII\n");

            if (order.tsp700)
                sb.Append("  1x Star TSP743vII\n");

            if (order.tsp800)
                sb.Append("  1x Star TSP843vII\n");

            if (order.sp700)
                sb.Append("  1x Star SP742\n");

            sb.Append("\n\n");

            return System.Text.ASCIIEncoding.ASCII.GetBytes(sb.ToString());
        }

        private byte[] renderOrderToStarLine()
        {
            m_returnedEncoding = "application/vnd.star.line";

            MemoryStream stream = new MemoryStream();

            write(stream, "\x1b@\x1b\x1d"+"a1\x1bi22New Order\x1bi00\n");
            write(stream, "\x1b\x1d"+"a0\n");

            write(stream, "  Deliver to: " + order.name + "\n");

            string[] addressLines = order.address.Split(new char[] { ',' });
            write(stream, "  At Address: " + addressLines[0].Trim() + "\n");

            if (addressLines.Length > 1)
            {
                for (int al = 1; al < addressLines.Length; al++)
                    write(stream, "              " + addressLines[al].Trim() + "\n");
            }

            write(stream, "\n\n");
            write(stream, "\x1b-1\x1bi11Products to Deliver\x1bi00\x1b-0\n\n");

            write(stream, "\x1bi01");

            if (order.tsp650)
                write(stream, " 1x Star TSP654vII\n");

            if (order.tsp700)
                write(stream, " 1x Star TSP743vII\n");

            if (order.tsp800)
                write(stream, " 1x Star TSP843vII\n");

            if (order.sp700)
                write(stream, " 1x Star SP742\n");

            write(stream, "\x1bi00\n\n\x1b"+"d2");

            byte[] jobdata = stream.ToArray();
            return jobdata;
        }


        private void write(Stream s, string data)
        {
            byte[] bd = System.Text.ASCIIEncoding.ASCII.GetBytes(data);
            s.Write(bd, 0, bd.Length);
        }


        private byte[] renderToPNG()
        {
            m_returnedEncoding = "image/png";

            Image i = renderToImage();

            MemoryStream stream = new MemoryStream();

            i.Save(stream, System.Drawing.Imaging.ImageFormat.Png);
            i.Dispose();

            byte[] jobdata = stream.ToArray();
            return jobdata;
        }

        private byte[] renderToJpeg()
        {
            m_returnedEncoding = "image/jpeg";

            Image i = renderToImage();

            MemoryStream stream = new MemoryStream();

            i.Save(stream, System.Drawing.Imaging.ImageFormat.Jpeg);
            i.Dispose();

            byte[] jobdata = stream.ToArray();
            return jobdata;
        }

        private Image renderToImage()
        {
            Image i = new Bitmap(576, 700, System.Drawing.Imaging.PixelFormat.Format24bppRgb);

            Graphics g = Graphics.FromImage(i);
            g.PageUnit = GraphicsUnit.Pixel;

            g.FillRectangle(Brushes.White, 0, 0, i.Width, i.Height);

            Font heading = new Font("Tahoma", 40, FontStyle.Regular, GraphicsUnit.Pixel);
            Font norm = new Font("Tahoma", 20, FontStyle.Regular, GraphicsUnit.Pixel);
            Font prod = new Font("Tahoma", 30, FontStyle.Regular, GraphicsUnit.Pixel);

            StringFormat centre = new StringFormat();
            centre.Alignment = StringAlignment.Center;
            centre.LineAlignment = StringAlignment.Center;


            g.DrawString("New Order", heading, Brushes.Black, new RectangleF(0, 0, i.Width, 40), centre);
            g.FillRectangle(Brushes.Black, 0, 41, i.Width, 5);

            string address = order.name + "\n";
            string[] addressLines = order.address.Split(new char[] { ',' });

            for (int c = 0; c < addressLines.Length; c++)
            {
                if (c > 0)
                    address += "\n";

                address += addressLines[c].Trim();
            }

            SizeF addsize = g.MeasureString(address, norm);

            g.DrawString("Deliver To:", norm, Brushes.Black, new RectangleF(20, 60, i.Width - 40, 40));
            g.DrawString(address, norm, Brushes.Black, new RectangleF(255, 65, addsize.Width, addsize.Height));
            g.DrawRectangle(Pens.Black, 250, 60, addsize.Width + 10, addsize.Height + 10);

            int vpos = 100 + (int)addsize.Height;

            string products = string.Empty;

            if (order.tsp650)
                products += "1x TSP654vII\n";

            if (order.tsp700)
                products += "1x TSP743vII\n";

            if (order.tsp800)
                products += "1x TSP843vII\n";

            if (order.sp700)
                products += "1x SP742\n";


            g.DrawString("Products", heading, Brushes.Black, new RectangleF(0, vpos + 20, i.Width, 40), centre);
            vpos += 61;
            g.FillRectangle(Brushes.Black, 50, vpos, i.Width - 100, 5);
            vpos += 10;
            SizeF ps = g.MeasureString(products, prod);

            g.DrawString(products, prod, Brushes.Black, new RectangleF(60, vpos, ps.Width, ps.Height));


            g.Dispose();
            return i;
        }
    }
}
