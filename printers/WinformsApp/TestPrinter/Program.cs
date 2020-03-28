using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Printing;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace TestPrinter
{
    class Program
    {
        static private string fileimageprinting = @"D:\Hai.vo\Work\www.ht.com\Denis_FoodOrdering\printers\WinformsApp\printing receipt\bin\Debug\PrinterReceipt\1.jpg";
        static void Main(string[] args)
        {
            string html = "";
            using (StreamReader r = new StreamReader(@"D:\1.html")) 
            {

                html = r.ReadToEnd();
            }


              //  string html = getResponsePostRequest("https://www.greek-painters.com/vo/food/7-4-Dang/printers/WinformsApp/Receipt.asp?mod=dishname&id_o=164&id_r=2&isPrint=&idlist=");
           // html = html.Replace("\n","").Replace("  ", " ").Replace("  ", " ").Replace("  ", " ");
            Image image = TheArtOfDev.HtmlRenderer.WinForms.HtmlRender.RenderToImage(html);
           image.Save(@"D:\Temp\image.png", ImageFormat.Png);

            PrintDocument pd = new PrintDocument();
           
            PrinterSettings printerSettings = new PrinterSettings();

            
            pd.DefaultPageSettings.Landscape = false;
            pd.DefaultPageSettings.Margins.Left = 0;
            pd.DefaultPageSettings.Margins.Top = 0;
            pd.DefaultPageSettings.PrinterResolution.Kind = PrinterResolutionKind.High;
            pd.DefaultPageSettings.PaperSize = new PaperSize("First custom size", 312, 500);


            //pd.DefaultPageSettings.PaperSize = pkCustomSize1;

            //  printDoc.DefaultPageSettings.PaperSize = pkCustomSize1
            pd.PrintPage += new PrintPageEventHandler(PrintPage);
            pd.Print();
        }
        static private void PrintPage(object o, PrintPageEventArgs e)
        {

            try
            {
               
                System.Drawing.Image i = System.Drawing.Image.FromFile(fileimageprinting);

                //e.Graphics.SmoothingMode = drawing.Drawing2D.SmoothingMode.HighQuality;
                //e.Graphics.InterpolationMode = drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                //e.Graphics.PixelOffsetMode = drawing.Drawing2D.PixelOffsetMode.HighQuality;
                //e.PageSettings.PrinterResolution.Kind = PrinterResolutionKind.High;
                //e.PageSettings.PaperSize =  new PaperSize("First custom size", 312, 500);
                e.Graphics.DrawImage(i, e.PageBounds);
                // e.Graphics.DrawImage(i, e.PageBounds);
                i.Dispose();
                //if (File.Exists(fileimageprinting))
                //{
                //    File.Delete(fileimageprinting);
                //}
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message.ToString() + " trace " + ex.StackTrace.ToString(), "Error PrintPage :");
            }

        }
        private static string getResponsePostRequest(string url)
        {
            string content = "";
            try
            {
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
                HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                if (!response.StatusCode.ToString().ToLower().Contains("ok"))
                    return "NOTFOUND";
                content = new StreamReader(response.GetResponseStream()).ReadToEnd();
            }
            catch (Exception ex)
            {
               // WriteErrorLog(ex.Message.ToString() + " trace " + ex.StackTrace.ToString() + " url " + url, "Error getResponsePostRequest:");
            }

            return content;
        }
    }
}
