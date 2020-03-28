<!-- sha1.js contains also helper functions (dateFormatter, charToByte,
byteToHex, ...) -->
<script LANGUAGE=JScript RUNAT=Server src="sha1.js">
</script>
<!-- google CryptoJS for SHA256 -->
<script LANGUAGE=JScript RUNAT=Server src="sha256.js">
</script>
<script LANGUAGE=JScript RUNAT=Server>
 var today = new Date();
 var formattedDate = today.formatDate("Y:m:d-H:i:s");
 /*
 Function that calculates the hash of the following parameters:
 - Store Id
 - Date/Time(see $dateTime above)
 - chargetotal
 - currency (numeric ISO value)
 - shared secret
 */
 function createHash(chargetotal, currency) {
 // Please change the store Id to your individual Store ID
 var storeId = "1120541446";
 // NOTE: Please DO NOT hardcode the secret in that script. For example
//read it from a database.
 var sharedSecret = "g#5vK2r[Qc";
 var stringToHash = storeId + formattedDate + chargetotal + currency +
sharedSecret;
 var ascii = getHexFromChars(stringToHash);
 var hash = CryptoJS.SHA256(ascii);
 Response.Write(hash);
 }
 function getHexFromChars(value) {
 var char_str = value;
 var hex_str = "";
 var i, n;
 for(i=0; i < char_str.length; i++) {
 n = charToByte(char_str.charAt(i));
 if(n != 0) {
 hex_str += byteToHex(n);
 }
 }
 return hex_str.toLowerCase();
 }
 function getDateTime() {
 Response.Write(formattedDate);
 }
</script>