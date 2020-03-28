var page = require('webpage').create();
page.open('http://www.google.com/', function () {
    page.render('D:/go.png');
    phantom.exit();
});
