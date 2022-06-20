if (document.getElementsByTagName('base')[0].href.indexOf("_BASEHREF_") == -1)
{
    __webpack_public_path__ =  document.getElementsByTagName('base')[0].href;
    window.baseUrl = document.getElementsByTagName('base')[0].href.replace(window.location.origin, "").replace(/\/$/, "");;
}
else 
{
    __webpack_public_path__ = "/"
    window.baseUrl = ""
}