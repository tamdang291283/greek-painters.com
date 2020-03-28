$(function() {
    $('.confirm').click(function() {
        return window.confirm("Are you sure?");
    });
});
function openNewBackgroundTab(pURL) {
    var a = document.createElement("a");
    a.href = pURL;
    var evt = document.createEvent("MouseEvents");
    //the tenth parameter of initMouseEvent sets ctrl key
    evt.initMouseEvent("click", true, true, window, 0, 0, 0, 0, 0,
                                true, false, false, false, 0, null);
    a.dispatchEvent(evt);
}