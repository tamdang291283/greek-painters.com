// Validators
// Check US Date format (mm/dd/yyyy)

function ew_CheckUSDate(object_value) {
	return ew_CheckDateEx(object_value, "us", EW_DATE_SEPARATOR);
}

// Check US Date format (mm/dd/yy)
function ew_CheckShortUSDate(object_value) {
	return ew_CheckDateEx(object_value, "usshort", EW_DATE_SEPARATOR);
}

// Check Date format (yyyy/mm/dd)
function ew_CheckDate(object_value) {
	return ew_CheckDateEx(object_value, "std", EW_DATE_SEPARATOR);
}

// Check Date format (yy/mm/dd)
function ew_CheckShortDate(object_value) {
	return ew_CheckDateEx(object_value, "stdshort", EW_DATE_SEPARATOR);
}

// Check Euro Date format (dd/mm/yyyy)
function ew_CheckEuroDate(object_value) {
	return ew_CheckDateEx(object_value, "euro", EW_DATE_SEPARATOR);
}

// Check Euro Date format (dd/mm/yy)
function ew_CheckShortEuroDate(object_value) {
	return ew_CheckDateEx(object_value, "euroshort", EW_DATE_SEPARATOR);
}

// Check date format
// Format: std/stdshort/us/usshort/euro/euroshort

function ew_CheckDateEx(value, format, sep) {
	if (!value || value.length == "")
		return true;
	while (value.indexOf("  ") > -1)
		value = value.replace(/  /g, " ");
	value = value.replace(/^\s*|\s*$/g, "");
	var arDT = value.split(" ");
	if (arDT.length > 0) {
		var re, sYear, sMonth, sDay;
		re = /^(\d{4})-([0][1-9]|[1][0-2])-([0][1-9]|[1|2]\d|[3][0|1])$/;
		if (ar = re.exec(arDT[0])) {
			sYear = ar[1];
			sMonth = ar[2];
			sDay = ar[3];
		} else {
			var wrksep = "\\" + sep;
			switch (format) {
				case "std":
					re = new RegExp("^(\\d{4})" + wrksep + "([0]?[1-9]|[1][0-2])" + wrksep + "([0]?[1-9]|[1|2]\\d|[3][0|1])$");
					break;
				case "stdshort":
					re = new RegExp("^(\\d{2})" + wrksep + "([0]?[1-9]|[1][0-2])" + wrksep + "([0]?[1-9]|[1|2]\\d|[3][0|1])$");
					break;
				case "us":
					re = new RegExp("^([0]?[1-9]|[1][0-2])" + wrksep + "([0]?[1-9]|[1|2]\\d|[3][0|1])" + wrksep + "(\\d{4})$");
					break;
				case "usshort":
					re = new RegExp("^([0]?[1-9]|[1][0-2])" + wrksep + "([0]?[1-9]|[1|2]\\d|[3][0|1])" + wrksep + "(\\d{2})$");
					break;
				case "euro":
					re = new RegExp("^([0]?[1-9]|[1|2]\\d|[3][0|1])" + wrksep + "([0]?[1-9]|[1][0-2])" + wrksep + "(\\d{4})$");
					break;
				case "euroshort":
					re = new RegExp("^([0]?[1-9]|[1|2]\\d|[3][0|1])" + wrksep + "([0]?[1-9]|[1][0-2])" + wrksep + "(\\d{2})$");
					break;
			}
			if (!re.test(arDT[0]))
				return false;
			var arD = arDT[0].split(sep);
			switch (format) {
				case "std":
				case "stdshort":
					sYear = ew_UnformatYear(arD[0]);
					sMonth = arD[1];
					sDay = arD[2];
					break;
				case "us":
				case "usshort":
					sYear = ew_UnformatYear(arD[2]);
					sMonth = arD[0];
					sDay = arD[1];
					break;
				case "euro":
				case "euroshort":
					sYear = ew_UnformatYear(arD[2]);
					sMonth = arD[1];
					sDay = arD[0];
					break;
			}
		}
		if (!ew_CheckDay(sYear, sMonth, sDay))
			return false;
	}
	if (arDT.length > 1 && !ew_CheckTime(arDT[1]))
		return false;
	return true;
}

// Unformat 2 digit year to 4 digit year
function ew_UnformatYear(yr) {
	if (yr.length == 2)
		return (yr > EW_UNFORMAT_YEAR) ? "19" + yr : "20" + yr;
	return yr;
}

// Check day
function ew_CheckDay(checkYear, checkMonth, checkDay) {
	checkYear = parseInt(checkYear, 10);
	checkMonth = parseInt(checkMonth, 10);
	checkDay = parseInt(checkDay, 10);
	var maxDay = (checkMonth == 4 || checkMonth == 6 ||	checkMonth == 9 || checkMonth == 11) ? 30 : 31;
	if (checkMonth == 2)
		maxDay = (checkYear % 4 > 0 || checkYear % 100 == 0 && checkYear % 400 > 0) ? 28 : 29;
	return ew_CheckRange(checkDay, 1, maxDay);
}

// Check integer
function ew_CheckInteger(object_value) {
	if (!object_value || object_value.length == 0)
		return true;
	if (object_value.indexOf(EW_DECIMAL_POINT) > -1)
		return false;
	return ew_CheckNumber(object_value);	
}

// Check number
function ew_CheckNumber(object_value) {
	if (object_value)
		object_value = String(object_value);
	if (!object_value || object_value.length == 0)
		return true;
	object_value = object_value.replace(/^\s*|\s*$/g, "");
	var sepexp;
	if (!EW_THOUSANDS_SEP) {
		sepexp = "";
	} else if (/[\u0020|\u00A0]{1}/.test(EW_THOUSANDS_SEP)) {
		sepexp = "[\u0020|\u00A0]?";
	} else {
		sepexp = "\\" + EW_THOUSANDS_SEP + "?";
	}
	var re = new RegExp("^[+-]?(\\d{1,3}(" + sepexp + "\\d{3})*(\\" + EW_DECIMAL_POINT + "\\d+)?|\\" + EW_DECIMAL_POINT + "\\d+)$");
	return re.test(object_value);
}

// Convert to float
function ew_StrToFloat(object_value) {
	if (object_value)
		object_value = String(object_value);
	if (!object_value || object_value.length == 0)
		return object_value;
	if (EW_THOUSANDS_SEP != "") {
		var sepexp;
		if (/[\u0020|\u00A0]{1}/.test(EW_THOUSANDS_SEP)) {
			sepexp = "[\u0020|\u00A0]";
		} else {
			sepexp = "\\" + EW_THOUSANDS_SEP;
		}
		var re = new RegExp(sepexp, "g");
		object_value = object_value.replace(re, "");
	}
	if (EW_DECIMAL_POINT != "")
		object_value = object_value.replace(EW_DECIMAL_POINT, ".");
	return parseFloat(object_value);
}

// Convert string (yyyy-mm-dd hh:mm:ss) to date object
function ew_StrToDate(object_value) {
	var re = /^(\d{4})-([0][1-9]|[1][0-2])-([0][1-9]|[1|2]\d|[3][0|1]) (?:(0\d|1\d|2[0-3]):([0-5]\d):([0-5]\d))?$/;
	var ar = object_value.replace(re, "$1 $2 $3 $4 $5 $6").split(" ");
	return new Date(ar[0], ar[1]-1, ar[2], ar[3], ar[4], ar[5]);
}

// Check range
function ew_CheckRange(object_value, min_value, max_value) {
	if (!object_value || object_value.length == 0)
		return true;

	//var L = ewLang;
	var L = {
		isNull: function(o) {
			return o === null;
		},
		isNumber: function(o) {
			return typeof o === 'number' && isFinite(o);
		}
	};
	if (L.isNumber(min_value) || L.isNumber(max_value)) { // Number
		if (ew_CheckNumber(object_value))
			object_value = ew_StrToFloat(object_value);
	}
	if (!L.isNull(min_value) && object_value < min_value)
		return false;
	if (!L.isNull(max_value) && object_value > max_value)
		return false;
	return true;
}

// Check time
function ew_CheckTime(object_value) {
	if (!object_value || object_value.length == 0)
		return true;
	object_value = object_value.replace(/^\s*|\s*$/g, "");
	var re = /^(0\d|1\d|2[0-3]):[0-5]\d(:[0-5]\d)?$/;
	return re.test(object_value);
}

// Check phone
function ew_CheckPhone(object_value) {
	if (!object_value || object_value.length == 0)
		return true;
	object_value = object_value.replace(/^\s*|\s*$/g, "");
	var re = /^\(\d{3}\) ?\d{3}( |-)?\d{4}|^\d{3}( |-)?\d{3}( |-)?\d{4}$/;
	return re.test(object_value);
}

// Check zip
function ew_CheckZip(object_value) {
	if (!object_value || object_value.length == 0)
		return true;
	object_value = object_value.replace(/^\s*|\s*$/g, "");
	var re = /^\d{5}$|^\d{5}-\d{4}$/;
	return re.test(object_value);
}

// Check credit card
function ew_CheckCreditCard(object_value) {
	if (!object_value || object_value.length == 0)
		return true;
	var creditcard_string = object_value.replace(/\D/g, "");	
	if (creditcard_string.length == 0)
		return false;
	var doubledigit = creditcard_string.length % 2 == 1 ? false : true;
	var tempdigit, checkdigit = 0;
	for (var i = 0, len = creditcard_string.length; i < len; i++) {
		tempdigit = parseInt(creditcard_string.charAt(i));		
		if (doubledigit) {
			tempdigit *= 2;
			checkdigit += (tempdigit % 10);			
			if (tempdigit / 10 >= 1.0)
				checkdigit++;			
			doubledigit = false;
		}	else {
			checkdigit += tempdigit;
			doubledigit = true;
		}
	}		
	return (checkdigit % 10 == 0);
}

// Check social security number
function ew_CheckSSC(object_value) {
	if (!object_value || object_value.length == 0)
		return true;
	object_value = object_value.replace(/^\s*|\s*$/g, "");
	var re = /^(?!000)([0-6]\d{2}|7([0-6]\d|7[012]))([ -]?)(?!00)\d\d\3(?!0000)\d{4}$/;
	return re.test(object_value);
}

// Check emails
function ew_CheckEmailList(object_value, email_cnt) {
	if (!object_value || object_value.length == 0)
		return true;
	var arEmails = object_value.replace(/,/g, ";").split(";");
	for (var i = 0, len = arEmails.length; i < len; i++) {
		if (email_cnt > 0 && len > email_cnt)
			return false;
		if (!ew_CheckEmail(arEmails[i]))
			return false;
	}
	return true;
}

// Check email
function ew_CheckEmail(object_value) {
	if (!object_value || object_value.length == 0)
		return true;
	object_value = object_value.replace(/^\s*|\s*$/g, "");
	var re = /^[\w.%+-]+@[\w.-]+\.[A-Z]{2,6}$/i;
	return re.test(object_value);
}

// Check GUID {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
function ew_CheckGUID(object_value) {
	if (!object_value || object_value.length == 0)
		return true;
	object_value = object_value.replace(/^\s*|\s*$/g, "");
	var re = /^\{\w{8}-\w{4}-\w{4}-\w{4}-\w{12}\}$/;
	var re2 = /^\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$/;
	return re.test(object_value) || re2.test(object_value);
}

// Check file extension
function ew_CheckFileType(object_value, extensions) {
	if (!object_value || object_value.length == 0)
		return true;
	if (!extensions)
		return true;
	if (extensions.replace(/^\s*|\s*$/g, "") == "")
		return true;	
	var exts = extensions.toLowerCase().split(",");
	var ext = object_value.substr(object_value.lastIndexOf(".") + 1).toLowerCase();

	//return (ew_InArray(ext, exts) > -1);
	for (var i=0; i < exts.length; i++) {
		if (exts[i] == ext)
			return true;
	}
	return false;
}

// Check by regular expression
function ew_CheckByRegEx(object_value, pattern) {
	if (!object_value || object_value.length == 0)
		return true;
	return (object_value.match(pattern)) ? true : false;
}
