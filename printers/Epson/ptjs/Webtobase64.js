var page = require('webpage').create();
/*page.viewportSize = {
    width: 300,
    height: 800
};*/
var args = require('system').args;
var address = args[1];
var filename = args[2];
console.log(address + '|' + filename);
page.open("http://my.outsource.com/printers/epson/print_t.asp?mod=dishname&id_o=2831&id_r=2&isPrint=&idlist=", function (status) {
    var base64 = page.renderBase64('png');    
    var fs = require('fs');        
    fs.write(filename, base64, 'w');
    //page.render(filename);
    phantom.exit();
});

