using System;
using System.IO;
using System.Threading;
using System.Windows;

using System.Windows.Forms;
using web = System.Windows.Forms;
using drawing = System.Drawing;
using System.Management;


using System.Drawing.Printing;

using System.Net;

using System.Runtime.InteropServices;
using System.Windows.Media.Imaging;
using System.Collections.Generic;

namespace Printing_Receipt
{

    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    ///
    public partial class MainWindow : Window
    {
        public byte[] picbytes;
        public string RootPath = "";  //ConfigurationSettings.AppSettings["RootPath"].ToString(); //System.IO.Path.GetFullPath("PrinterReceipt");
        public string PrintSettingPath = "";
        public string logpath = "";
        public string printsettingfile = "";
        public string SITEURL = "" ;

        System.Windows.Forms.Timer aTimer = new System.Windows.Forms.Timer();
        System.Windows.Forms.Timer aTimerSound = new System.Windows.Forms.Timer();
        public bool printed = false;
        public string fileimageprinting = "";
        public bool flagtest = false;
        System.Media.SoundPlayer player =  new System.Media.SoundPlayer();
        enum PrinterStatus
        {
            Other = 1,
            Unknown,
            Idle,
            Printing,
            Warmup,
            Stopped,
            printing,
            Offline
        }
        public MainWindow()
        {
            try
            {
                InitializeComponent();

                //player.SoundLocation = System.IO.Path.GetFullPath("beep.wav");
                //player.Load();

                EnableSound.IsChecked = true;
                txtInterval.Text = "5";
                RootPath = System.IO.Path.GetFullPath(@"PrinterReceipt\");
                PrintSettingPath = System.IO.Path.GetFullPath(@"PrinterSetting\");
                logpath = System.IO.Path.GetFullPath(@"log\");
                bool exists = System.IO.Directory.Exists(PrintSettingPath);
                if (!exists)
                    System.IO.Directory.CreateDirectory(PrintSettingPath);
                printsettingfile = PrintSettingPath + "setting.txt";

                int index = 0;
                var printerQuery = new ManagementObjectSearcher("SELECT * from Win32_Printer");
                string printernamedefault = "";
                foreach (var printer in printerQuery.Get())
                {
                    var name = printer.GetPropertyValue("Name");
                    var status = printer.GetPropertyValue("Status");
                    var isDefault = (bool)printer.GetPropertyValue("Default");
                    if (isDefault == true)
                        printernamedefault = name.ToString();
                    var isNetworkPrinter = printer.GetPropertyValue("Network");
                    cbPrinterList.Items.Insert(index, name);
                    index += 1;
                }
                if (printernamedefault != "")
                    cbPrinterList.Text = printernamedefault;

                btnStop.IsEnabled = false;
                FixBrowserVersion();
                //txtAddressURL.Text = pageOrdercome;
                ReadSetting(printsettingfile);

                aTimer.Interval = 1000 * Int32.Parse(txtInterval.Text); // specify interval time as you want
                aTimer.Tick += new EventHandler(timer_Tick);

                if (File.Exists(System.IO.Path.GetFullPath("PrinterLog.txt")))
                    File.Delete(System.IO.Path.GetFullPath("PrinterLog.txt"));
                if (AutoStart.IsChecked == true)
                    trigerStart();
            }
            catch (Exception ex)
            {
                WriteErrorLog(ex.Message.ToString() + " trace " + ex.StackTrace.ToString(), "Error Main:");
                web.MessageBox.Show("Error: " + ex.ToString());
                
            }          
        }

        public static int GetEmbVersion()
        {
            int ieVer = GetBrowserVersion();

            if (ieVer > 9)
                return ieVer * 1100 + 1;

            if (ieVer > 7)
                return ieVer * 1111;

            return 7000;
        } // End Function GetEmbVersion
        public static void FixBrowserVersion()
        {
            string appName = System.IO.Path.GetFileNameWithoutExtension(System.Reflection.Assembly.GetExecutingAssembly().Location);
            FixBrowserVersion(appName);
        }
        public static void FixBrowserVersion(string appName)
        {
            FixBrowserVersion(appName, GetEmbVersion());
        }
        public static void FixBrowserVersion(string appName, int ieVer)
        {
            FixBrowserVersion_Internal("HKEY_LOCAL_MACHINE", appName + ".exe", ieVer);
            FixBrowserVersion_Internal("HKEY_CURRENT_USER", appName + ".exe", ieVer);
            FixBrowserVersion_Internal("HKEY_LOCAL_MACHINE", appName + ".vshost.exe", ieVer);
            FixBrowserVersion_Internal("HKEY_CURRENT_USER", appName + ".vshost.exe", ieVer);
        } // End Sub FixBrowserVersion 

        private static void FixBrowserVersion_Internal(string root, string appName, int ieVer)
        {
            try
            {
                //For 64 bit Machine 
                if (Environment.Is64BitOperatingSystem)
                    Microsoft.Win32.Registry.SetValue(root + @"\Software\Wow6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION", appName, ieVer);
                else  //For 32 bit Machine 
                    Microsoft.Win32.Registry.SetValue(root + @"\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION", appName, ieVer);


            }
            catch (Exception ex)
            {
                // some config will hit access rights exceptions
                // this is why we try with both LOCAL_MACHINE and CURRENT_USER
               // WriteErrorLog(ex.Message.ToString() + " trace " + ex.StackTrace.ToString(), "Error FixBrowserVersion_Internal:");
            }
        } // End Sub FixBrowserVersion_Internal 
        private static int GetBrowserVersion()
        {
            
            // string strKeyPath = @"HKLM\SOFTWARE\Microsoft\Internet Explorer";
            string strKeyPath = @"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer";
            string[] ls = new string[] { "svcVersion", "svcUpdateVersion", "Version", "W2kVersion" };

            int maxVer = 0;
            try {
                for (int i = 0; i < ls.Length; ++i)
                {
                    object objVal = Microsoft.Win32.Registry.GetValue(strKeyPath, ls[i], "0");
                    string strVal = System.Convert.ToString(objVal);
                    if (strVal != null)
                    {
                        int iPos = strVal.IndexOf('.');
                        if (iPos > 0)
                            strVal = strVal.Substring(0, iPos);

                        int res = 0;
                        if (int.TryParse(strVal, out res))
                            maxVer = Math.Max(maxVer, res);
                    } // End if (strVal != null)

                } // Next i
            } catch (Exception ex) {
              //  WriteErrorLog(ex.Message.ToString() + " trace " + ex.StackTrace.ToString(), "Error GetBrowserVersion:");
              
            }


                return maxVer;
        }
        private static Dictionary<string, drawing.Imaging.ImageCodecInfo> encoders = null;
        public static Dictionary<string, drawing.Imaging.ImageCodecInfo> Encoders
        {
            //get accessor that creates the dictionary on demandd
            get
            {
                //if the quick lookup isn't initialised, initialise it
                if (encoders == null)
                {
                    encoders = new Dictionary<string, drawing.Imaging.ImageCodecInfo>();
                }

                //if there are no codecs, try loading them
                if (encoders.Count == 0)
                {
                    //get all the codecs
                    foreach (drawing.Imaging.ImageCodecInfo codec in drawing.Imaging.ImageCodecInfo.GetImageEncoders())
                    {
                        //add each codec to the quick lookup
                        encoders.Add(codec.MimeType.ToLower(), codec);
                    }
                }

                //return the lookup
                return encoders;
            }
        }
        private static drawing.Imaging.ImageCodecInfo getEncoderInfo(string mimeType)
        {
            //do a case insensitive look at the mime type
            mimeType = mimeType.ToLower();
            //the codec to return, default to null
            drawing.Imaging.ImageCodecInfo foundCodec = null;
            //if we have the encoder, get it to return
            if (Encoders.ContainsKey(mimeType))
            {
                //pull the codec from the lookup
                foundCodec = Encoders[mimeType];
            }
            return foundCodec;
        }

        public drawing.Image ScaleByWH(drawing.Image original, int destWidth, int destHeight)
        {
          
            drawing.Bitmap b = new drawing.Bitmap(destWidth, destHeight);
            drawing.Graphics g = drawing.Graphics.FromImage((drawing.Image)b);            
            try
            {
                g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                g.SmoothingMode = drawing.Drawing2D.SmoothingMode.HighQuality;
                g.PixelOffsetMode = drawing.Drawing2D.PixelOffsetMode.Half;
                g.DrawImage(original, 0, 0, destWidth, destHeight);
                
                //SetContrast(b, 50);
            }
            finally
            {
                g.Dispose();
            }

            return (drawing.Image)b;
        }
        public static drawing.Bitmap MedianFilter(drawing.Bitmap Image, int Size)
     {
         System.Drawing.Bitmap TempBitmap = Image;
        System.Drawing.Bitmap NewBitmap = new System.Drawing.Bitmap(TempBitmap.Width, TempBitmap.Height);
        System.Drawing.Graphics NewGraphics = System.Drawing.Graphics.FromImage(NewBitmap);
       NewGraphics.DrawImage(TempBitmap, new System.Drawing.Rectangle(0, 0, TempBitmap.Width, TempBitmap.Height), new System.Drawing.Rectangle(0, 0, TempBitmap.Width, TempBitmap.Height), System.Drawing.GraphicsUnit.Pixel);
        NewGraphics.Dispose();
        Random TempRandom = new Random();
        int ApetureMin = -(Size / 2);
       int ApetureMax = (Size / 2);
       for (int x = 0; x < NewBitmap.Width; ++x)
       {
           for (int y = 0; y < NewBitmap.Height; ++y)
           {
               List<int> RValues = new List<int>();
               List<int> GValues = new List<int>();
               List<int> BValues = new List<int>();
               for (int x2 = ApetureMin; x2 < ApetureMax; ++x2)
               {
                   int TempX = x + x2;
                   if (TempX >= 0 && TempX < NewBitmap.Width)
                   {
                       for (int y2 = ApetureMin; y2 < ApetureMax; ++y2)
                       {
                           int TempY = y + y2;
                           if (TempY >= 0 && TempY < NewBitmap.Height)
                           {
                                    drawing.Color TempColor = TempBitmap.GetPixel(TempX, TempY);
                               RValues.Add(TempColor.R);
                               GValues.Add(TempColor.G);
                              BValues.Add(TempColor.B);
                           }
                       }
                }
               }
               RValues.Sort();
               GValues.Sort();
              BValues.Sort();
               drawing.Color MedianPixel = drawing.Color.FromArgb(RValues[RValues.Count / 2],
                   GValues[GValues.Count / 2], 
                  BValues[BValues.Count / 2]);
              NewBitmap.SetPixel(x, y, MedianPixel);
           }
       }
       return NewBitmap;
  }

        // this code relies on the LockedBitmap class
        // threshold should be a value between -100 and 100
        private static void SetContrast(drawing.Bitmap bmp, int threshold)
        {
            var lockedBitmap = new LockBitmap(bmp);
            lockedBitmap.LockBits();

            var contrast = Math.Pow((100.0 + threshold) / 100.0, 2);

            for (int y = 0; y < lockedBitmap.Height; y++)
            {
                for (int x = 0; x < lockedBitmap.Width; x++)
                {
                    var oldColor = lockedBitmap.GetPixel(x, y);
                    var red = ((((oldColor.R / 255.0) - 0.5) * contrast) + 0.5) * 255.0;
                    var green = ((((oldColor.G / 255.0) - 0.5) * contrast) + 0.5) * 255.0;
                    var blue = ((((oldColor.B / 255.0) - 0.5) * contrast) + 0.5) * 255.0;
                    if (red > 255) red = 255;
                    if (red < 0) red = 0;
                    if (green > 255) green = 255;
                    if (green < 0) green = 0;
                    if (blue > 255) blue = 255;
                    if (blue < 0) blue = 0;

                    var newColor = drawing.Color.FromArgb(oldColor.A, (int)red, (int)green, (int)blue);
                    lockedBitmap.SetPixel(x, y, newColor);
                }
            }
            lockedBitmap.UnlockBits();
        }
        // Get ImageEncodeInfo of Image
        private drawing.Imaging.ImageCodecInfo GetEncoder(drawing.Imaging.ImageFormat format)
        {
            drawing.Imaging.ImageCodecInfo[] codecs = drawing.Imaging.ImageCodecInfo.GetImageDecoders();
            foreach (drawing.Imaging.ImageCodecInfo codec in codecs)
            {
                if (codec.FormatID == format.Guid)
                {
                    return codec;
                }
            }
            return null;
        }
        private void printing(string url,string imgfilename)
        {
            try {

                bool exists = System.IO.Directory.Exists(RootPath);
                if (!exists)
                    System.IO.Directory.CreateDirectory(RootPath);




                //picbytes = null;
                //makepicture(url);
                ////drawing.Bitmap bmSave = ByteToImage(picbytes);
                //drawing.Image img = ByteToImageImg(picbytes);



                #region GeneratePhotoFromHTML
                string html = getResponsePostRequest(url);

                drawing.Image img = TheArtOfDev.HtmlRenderer.WinForms.HtmlRender.RenderToImage(html);

                #endregion

                //bmSave.Dispose();
                //Bitmap newImage = new Bitmap(newWidth, newHeight);
                int newHeight = img.Height;//(int)((295 * img.Height) / (img.Width));               
                int newWidth = img.Width;// 295;


                int printHeight = (int)((295 * img.Height) / (img.Width));
                int printWidth = 295;

                //img = ScaleByWH(img, newWidth, newHeight);


                //img.Save(RootPath + imgfilename + ".png", drawing.Imaging.ImageFormat.Png);
                //fileimageprinting = RootPath + imgfilename + ".png";

                img.Save(RootPath + imgfilename + ".png", drawing.Imaging.ImageFormat.Png);
                fileimageprinting = RootPath + imgfilename + ".png";
                
                img.Dispose();

               

                PrintDocument pd = new PrintDocument();
                PaperSize pkCustomSize1 = new PaperSize("First custom size", printWidth, printHeight);
                pd.DefaultPageSettings.Margins.Left = 0;
                pd.DefaultPageSettings.Margins.Top = 0;
                pd.DefaultPageSettings.PrinterResolution.Kind = PrinterResolutionKind.High;
               // pd.PrinterSettings.


                pd.DefaultPageSettings.PaperSize = pkCustomSize1;
                
                //  printDoc.DefaultPageSettings.PaperSize = pkCustomSize1
                pd.PrintPage += new PrintPageEventHandler(this.PrintPage);
                pd.Print();

            }
            catch (Exception ex) {
                WriteErrorLog(ex.Message.ToString() + " trace " + ex.StackTrace.ToString(), "Error printing:");
            }       
        }

       private  PrinterStatus GetPrinterStat(string printerDevice)
        {
            PrinterStatus ret = 0;
            try {
                string path = "win32_printer.DeviceId='" + printerDevice + "'";
                using (ManagementObject printer = new ManagementObject(path))
                {
                    printer.Get();
                    PropertyDataCollection printerProperties = printer.Properties;
                    PrinterStatus st =
                    (PrinterStatus)Convert.ToInt32(printer.Properties["PrinterStatus"].Value);
                    ret = st;
                }
            }
            catch (Exception ex)
            {
                
                WriteErrorLog(ex.Message.ToString() + " trace " + ex.StackTrace.ToString(), "Error PrinterStatus:");
            }
            
            return ret;
        }
    
        private void playSound(string path)
        {
            System.Media.SoundPlayer player =
                new System.Media.SoundPlayer();
            player.SoundLocation = path;
            player.Load();           
            player.Play();
        }

        private void playPrinting()
        {
            player.Stop();
            player.SoundLocation = System.IO.Path.GetFullPath("beep.wav");
            player.Load();
            player.PlayLooping();
        }

        private void playServerError()
        {
            player.Stop();
            player.SoundLocation = System.IO.Path.GetFullPath("response-error.wav");
            player.Load();
            player.PlayLooping();
        }

        private void playNetworkError()
        {
            player.Stop();
            player.SoundLocation = System.IO.Path.GetFullPath("connection-error.wav");
            player.Load();
            player.PlayLooping();
        }
        private string getResponsePostRequest(string url)
        {
            string content = "";
            try {
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
                HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                if (!response.StatusCode.ToString().ToLower().Contains("ok"))
                    return "NOTFOUND";
                content = new StreamReader(response.GetResponseStream()).ReadToEnd();
                if (content.Contains("errorpage.asp")) { playServerError(); return "NOTFOUND"; }
                }
            catch (Exception ex)
            {
                WriteErrorLog(ex.Message.ToString() + " trace " + ex.StackTrace.ToString() + " url " + url, "Error getResponsePostRequest:");
                playNetworkError();
                return "ERROR";
            }
            
            return content;
        }
        private void makepicture(string url)
        {
           try {
                 Thread thread = new Thread(delegate ()
                 {
                    using (System.Windows.Forms.WebBrowser browser = new System.Windows.Forms.WebBrowser())
                    {
                        browser.ScrollBarsEnabled = false;
                        browser.AllowNavigation = true;
                     browser.BringToFront();
                        browser.DocumentCompleted += new WebBrowserDocumentCompletedEventHandler(DocumentCompleted);
                        browser.Navigate(url);
                        while (browser.ReadyState != WebBrowserReadyState.Complete)
                        {
                            System.Windows.Forms.Application.DoEvents();
                        }

                    }
                 });
                thread.SetApartmentState(ApartmentState.STA);
                thread.Start();
                thread.Join();
            }
            catch (Exception ex)
            {
                WriteErrorLog(ex.Message.ToString() + " trace " + ex.StackTrace.ToString(), "Error makepicture:");
            }
            
        }

        

        private void PrintPage(object o, PrintPageEventArgs e)
        {

            try {
                System.Drawing.Image i = System.Drawing.Image.FromFile(fileimageprinting);

                e.Graphics.SmoothingMode = drawing.Drawing2D.SmoothingMode.HighQuality;
                e.Graphics.InterpolationMode = drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                e.Graphics.PixelOffsetMode = drawing.Drawing2D.PixelOffsetMode.HighQuality;
                e.PageSettings.PrinterResolution.Kind = PrinterResolutionKind.High;
                e.Graphics.DrawImage(i, e.PageBounds);
                // e.Graphics.DrawImage(i, e.PageBounds);
                i.Dispose();
                if (File.Exists(fileimageprinting))
                {
                    File.Delete(fileimageprinting);
                }
            }
            catch (Exception ex)
            {
                WriteErrorLog(ex.Message.ToString() + " trace " + ex.StackTrace.ToString(), "Error PrintPage :");
            }
            
        }
        private void DocumentCompleted(object sender, WebBrowserDocumentCompletedEventArgs e)
        {
            try {
                web.WebBrowser browser = sender as web.WebBrowser;
                int scrollWidth = 0;
                int scrollHeight = 0;

                scrollHeight = browser.Document.Body.ScrollRectangle.Height;
                scrollWidth = 512;
                browser.Size = new System.Drawing.Size(scrollWidth, scrollHeight);


                //Bitmap bm = new Bitmap(scrollWidth, scrollHeight);
                using (drawing.Bitmap bitmap = new drawing.Bitmap(scrollWidth, scrollHeight))
                {
                    browser.DrawToBitmap(bitmap, new System.Drawing.Rectangle(0, 0, browser.Width, browser.Height));
                    using (MemoryStream stream = new MemoryStream())
                    {
                        //bitmap.Save(stream, System.Drawing.Imaging.ImageFormat.Png);
                        bitmap.Save(stream, System.Drawing.Imaging.ImageFormat.Jpeg);
                        byte[] bytes = stream.ToArray();
                        picbytes = bytes;

                    }
                }
            }
            catch (Exception ex)
            {
                WriteErrorLog(ex.Message.ToString() + " trace " + ex.StackTrace.ToString(), "Error DocumentCompleted :");
            }
            
        }

        public  drawing.Bitmap ByteToImage(byte[] blob)
        {
            try {
                MemoryStream mStream = new MemoryStream();
                byte[] pData = blob;
                mStream.Write(pData, 0, Convert.ToInt32(pData.Length));
                drawing.Bitmap bm = new drawing.Bitmap(mStream, false);
                mStream.Dispose();
                return bm;
            }
            catch (Exception ex) {
                WriteErrorLog(ex.Message.ToString() + " trace " + ex.StackTrace.ToString(), "Error DocumentCompleted :");
                return null;
            }
            

        }

        

        public  drawing.Image ByteToImageImg(byte[] blob)
        {
            try {
                MemoryStream mStream = new MemoryStream();
                byte[] pData = blob;
                mStream.Write(pData, 0, Convert.ToInt32(pData.Length));
                drawing.Image bm = drawing.Image.FromStream(mStream,true);  //new drawing.Bitmap(mStream, false);
                mStream.Dispose();
                return bm;
            } catch (Exception ex) {
                WriteErrorLog(ex.Message.ToString() + " trace " + ex.StackTrace.ToString(), "Error DocumentCompleted :");
                return null;
            }
            

        }


        void timer_Tick(object sender, EventArgs e)
        {
            processPrinting();
        }
        void timer_TickSound(object sender, EventArgs e)
        {
            player.Stop();
            aTimerSound.Stop();
        }
        private void processPrinting()
        {
            try {
                if (printed == false)
                {
                    if (txtAddressURL.Text.ToString().Trim() != "")
                    {
                        
                        
                        printed = true;
                        WriteLog(txtAddressURL.Text.ToString().Trim(), "URL: ");

                        string responseText = getResponsePostRequest(txtAddressURL.Text.ToString().Trim());
                        WriteLog(responseText, "ResponseText: ");
                        if (responseText != "NOTFOUND")
                        {
                            string[] listresponseText = responseText.Split(new string[] { "[***]" }, StringSplitOptions.None);
                            string[] listparam = listresponseText[0].Split(new string[] { "[**]" }, StringSplitOptions.None);

                            string sURL = "";
                            string OrderID = "";
                            string ResID = "";
                            string[] listURL = new string[] { };
                            int countEN = 0;
                            int countCN = 0;
                            if (listparam.Length >= 3)
                            {
                                sURL = listparam[0];
                                OrderID = listparam[1];
                                ResID = listparam[2];
                                listURL = sURL.Split('|');
                                
                            }
                           
                            aTimerSound.Stop();
                            foreach (string url in listURL)
                            {
                                if (url != "")
                                {
                                    try
                                    {


                                        if (url.Contains("dishname"))
                                        {
                                            if (EnableSound.IsChecked == true)
                                                playPrinting();
                                            WriteLog(url, "printing: ");
                                            printing(url, ResID + "-" + OrderID + "-EN" + countEN);
                                            WriteLog("Success!", "printing: ");
                                            countEN += 1;
                                        }
                                        else
                                        {
                                            if (EnableSound.IsChecked == true)
                                                playPrinting();
                                            WriteLog(url, "printing: ");
                                            printing(url, ResID + "-" + OrderID + "-CN" + countCN);
                                            WriteLog("Success!", "printing: ");
                                            countCN += 1;
                                        }
                                    }
                                    catch (Exception ex)
                                    {
                                        WriteErrorLog(ex.Message.ToString() + " trace " + ex.StackTrace.ToString() + " for URL " + url, "Error : ");
                                        player.Stop();
                                    }


                                }
                            }
                            // mark order is printed
                            if (OrderID != "")
                                responseText = getResponsePostRequest(SITEURL + "printers/WinformsApp/updateprinted.asp?id_r=" + ResID + "&o_id=" + OrderID);


                            // Proccess local
                            listparam = new string[] { };
                            if (listresponseText.Length > 1)
                                listparam = listresponseText[1].Split(new string[] { "[**]" }, StringSplitOptions.None);
                            sURL = "";
                            OrderID = "";
                            ResID = "";
                            listURL = new string[] { };
                            if (listparam.Length >= 3)
                            {
                                sURL = listparam[0];
                                OrderID = listparam[1];
                                ResID = listparam[2];
                                listURL = sURL.Split('|');
                            }

                            countEN = 0;
                            countCN = 0;

                            foreach (string url in listURL)
                            {
                                if (url != "")
                                {
                                    try
                                    {
                                        if (url.Contains("dishname"))
                                        {
                                            if (EnableSound.IsChecked == true)
                                                playPrinting();
                                            WriteLog(url, "printing: ");
                                            printing(url, ResID + "-" + OrderID + "-EN" + countEN);
                                            WriteLog("Success!", "printing: ");
                                            countEN += 1;
                                        }
                                        else
                                        {
                                            if (EnableSound.IsChecked == true)
                                                playPrinting();
                                            WriteLog(url, "printing: ");
                                            printing(url, ResID + "-" + OrderID + "-CN" + countCN);
                                            WriteLog("Success!", "printing: ");
                                            countCN += 1;
                                        }
                                    }
                                    catch (Exception ex)
                                    {                                           
                                        WriteErrorLog(ex.Message.ToString() + " trace " + ex.StackTrace.ToString()+ " for URL " + url, "Error : ");
                                        player.Stop();
                                    }
                                }
                            }
                            if (OrderID != "")
                                responseText = getResponsePostRequest(SITEURL + "printers/WinformsApp/updateprinted.asp?id_r=" + ResID + "&o_id=" + OrderID + "&local=Y");
                            // End 
                            aTimerSound.Interval = 3000; // 20 mins
                            aTimerSound.Tick += new EventHandler(timer_TickSound);
                            aTimerSound.Start();

                        }
                        printed = false;
                    }
                }
            }
            catch (Exception ex) {
                WriteErrorLog(ex.Message.ToString() + " trace " + ex.StackTrace.ToString(), "Error processPrinting :");
            }
            
        }

        private void trigerStart()
        {
            try {
                flagtest = false;
                Win32.SetDefaultPrinter(cbPrinterList.Text.ToString().Trim());
                if (txtAddressURL.Text.ToString().Trim() != "")
                {
                    SITEURL = txtAddressURL.Text.ToString().Trim().Substring(0, txtAddressURL.Text.ToString().Trim().IndexOf("printers"));
                    btnStart.IsEnabled = false;
                    btnStop.IsEnabled = true;
                    // processPrinting();
                    aTimer.Interval = 1000 * Int32.Parse(txtInterval.Text);
                    aTimer.Start();
                    //aTimer.Enabled = true; 
                }
                else
                {
                    web.MessageBox.Show("Please input Address URL");
                }
            }
            catch (Exception ex)
            {
                WriteErrorLog(ex.Message.ToString() + " trace " + ex.StackTrace.ToString(), "Error : ");
            }
           
        }
        private void btnStart_Click(object sender, RoutedEventArgs e)
        {
            try {
                WriteSettingFile(printsettingfile);
                trigerStart();
            } catch (Exception ex) {
                WriteErrorLog(ex.Message.ToString() + " trace " + ex.StackTrace.ToString(), "Error btnStart_Click : ");
            }
            
        }

        private void btnStop_Click(object sender, RoutedEventArgs e)
        {
            
            aTimer.Stop();
            btnStop.IsEnabled = false;
            btnStart.IsEnabled = true;
        }

        private  void WriteErrorLog(string logcontent, string error)
        {
            using (StreamWriter w = File.AppendText(logpath + "ErrorLog.txt"))
            {
                Log(error + logcontent, w);
                // Close the writer and underlying file.
                w.Close();
            }
        }

        private  void WriteLog(string logcontent,string error)
        {
            using (StreamWriter w = File.AppendText(logpath + "PrinterLog.txt"))
            {
                Log(error + logcontent, w);
                // Close the writer and underlying file.
                w.Close();
            }
        }
        private void WriteSettingFile(string FileName)
        {
            using (StreamWriter w = File.CreateText(FileName))
            {
                w.WriteLine("printername|" + cbPrinterList.Text.ToString());
                w.WriteLine("timeinterval|" + txtInterval.Text.ToString());
                w.WriteLine("enablesound|" + EnableSound.IsChecked.ToString().ToLower());
                w.WriteLine("urlordercome|" + txtAddressURL.Text.ToString());
                w.WriteLine("autostart|" + AutoStart.IsChecked.ToString().ToLower());
                w.Flush();
                w.Close();
            }
        }
        private void ReadSetting(string filename)
        {
            try {
                string printername = "", timeinterval = "5", enablesound = "true", urlordercome = "", autostart = "";
                if (File.Exists(filename))
                {
                    using (StreamReader r = new StreamReader(filename))
                    {
                        string line;

                        while ((line = r.ReadLine()) != null)
                        {
                            if (line.Contains("printername|"))
                            {
                                printername = line.Split('|')[1].ToString().Trim();
                            }
                            if (line.Contains("timeinterval|"))
                            {
                                timeinterval = line.Split('|')[1].ToString().Trim();
                            }
                            if (line.Contains("enablesound|"))
                            {
                                enablesound = line.Split('|')[1].ToString().Trim();
                            }
                            if (line.Contains("urlordercome|"))
                            {
                                urlordercome = line.Split('|')[1].ToString().Trim();
                            }
                            if (line.Contains("autostart|"))
                                autostart = line.Split('|')[1].ToString().Trim();
                        }
                        r.Close();

                    }
                }

                if (printername != "")
                    cbPrinterList.Text = printername;
                txtAddressURL.Text = urlordercome;
                txtInterval.Text = timeinterval;
                if (enablesound == "true")
                    EnableSound.IsChecked = true;
                else
                    EnableSound.IsChecked = false;
                if (autostart == "true")
                {
                    AutoStart.IsChecked = true;
                }
            }
            catch (Exception ex)
            {
                WriteErrorLog(ex.Message.ToString() + " trace " + ex.StackTrace.ToString(), "Error : ");
            }
            
        }
        private  void Log(string logMessage, TextWriter w)
        {
            w.Write("\r\nLog Entry : ");
            w.WriteLine("{0} {1}", DateTime.Now.ToLongTimeString(),
                DateTime.Now.ToLongDateString());
            w.WriteLine("  :");
            w.WriteLine("  :{0}", logMessage);
            w.WriteLine("-------------------------------");
            // Update the underlying file.
            w.Flush();
        }
        private  void DumpLog(StreamReader r)
        {
            // While not at the end of the file, read and write lines.
            string line;
            while ((line = r.ReadLine()) != null)
            {
                Console.WriteLine(line);
            }
            r.Close();
        }

        private void EnableSound_Checked(object sender, RoutedEventArgs e)
        {
           
            if (EnableSound.IsChecked == false)
                player.Stop();
        }
        private void AutoStart_Checked(object sender, RoutedEventArgs e)
        {
        }
    }
    public static class Win32
    {
        [DllImport("winspool.drv", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern bool SetDefaultPrinter(string Name);
        
    }



}







