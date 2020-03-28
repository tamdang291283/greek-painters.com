using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace cloudPRNT_TestServer.uijson
{
    [Serializable]
    public class DeviceInfoPack
    {
        public string uid = string.Empty;
        public string clientType = string.Empty;
        public string clientVersion = string.Empty;
        public string encodings = string.Empty;
        public string statusCode = string.Empty;
        public string status = string.Empty;
        public string jobs = string.Empty;

        public DeviceInfoPack()
        {

        }

        internal DeviceInfoPack(PrinterQueue q)
        {
            uid = q.uniqueID;
            clientType = q.clientType;
            clientVersion = q.clientVersion;
            encodings = q.supportedContentEncodings;
            statusCode = q.status;
            status = q.asbStatus;
            jobs = q.jobCount.ToString();
        }
    }


}
