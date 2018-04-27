function validate_input() {
  var f1 = document.getElementById("nme").value;
  var f2 = document.getElementById("add").value;
  var f3 = document.getElementById("eml").value;
  var f4 = document.getElementById("mno").value;
  var f5 = document.getElementById("acc").value;
  var f6 = document.getElementById("pwd").value;

  var x, text;
    x = document.getElementById("mno").value;
    var rgx = /^\d{10}$/;
    if (x.match(rgx)) {
        text = "Input OK";
    }
    else {
        text = "Input not OK";
    }
    document.getElementById("demo").innerHTML = text;
}
