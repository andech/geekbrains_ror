window.onload = function() {
  var div = document.createElement("div");
  div.innerHTML = "<h1>TEST</h1>";

  var main = document.getElementsByTagName("main");
  document.body.insertBefore(div, main[0]);
}