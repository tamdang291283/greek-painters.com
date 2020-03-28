using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Test
{
    class Program
    {
        static void Main(string[] args)
        {
            // Create cpPollResponse for the reply
            cpPollResponse presp = new cpPollResponse();

            // Set the print jbs available flag correctly.
            presp.jobReady = true;

            if (presp.jobReady)
            {
                if (presp.mediaTypes == null)
                    presp.mediaTypes = new List<string>();


                presp.mediaTypes.Add("image/png");
               
            }
              fastJSON.JSONParameters jp;
              jp = new fastJSON.JSONParameters();
              jp.UseExtensions = false;
              jp.UseEscapedUnicode = true;
              jp.SerializeNullValues = true;
            // convert cpPollResponse to json and send it back to the client
            string responseString = fastJSON.JSON.ToNiceJSON(presp, jp);

        }
    }
}
