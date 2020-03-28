var page = require('webpage').create();
/*page.viewportSize = {
    width: 300,
    height: 800
};*/
var args = require('system').args;
var address = args[1];
var filename = args[2];
console.log(address + '|' + filename);
page.open(address, function (status) {
    var base64 = page.renderBase64('png');    
    var fs = require('fs');
    var height = page.evaluate(function () { return document.body.offsetHeight });
    var width = page.evaluate(function () { return document.body.offsetWidth });
    fs.write(filename,height + "\n" + width + "\n" + base64, 'w');
    //page.render(filename);
    phantom.exit();
});

