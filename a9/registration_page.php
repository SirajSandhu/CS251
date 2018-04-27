<!DOCTYPE HTML>
<html>
<head>
</head>
<body>

<script src="validation.js"></script>

<?php
// define variables and set to empty values
$name = $address = $email = $mobile = $bank_acc = $bank_pwd = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $name = test_input($_POST["name"]);
  $address = test_input($_POST["address"]);
  $email = test_input($_POST["email"]);
  $mobile = test_input($_POST["mobile"]);
  $bank_acc = test_input($_POST["bank_acc"]);
  $bank_pwd = test_input($_POST["bank_pwd"]);
}

function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}
?>

<h2>Registration Page</h2>
<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
  Name: <input type="text" name="name" id="nme">
  <br><br>
  Address: <input type="text" name="address" id="adr">
  <br><br>
  E-mail: <input type="text" name="email" id="eml">
  <br><br>
  Mobile No: <input type="text" name="mobile" id="mno">
  <br><br>
  Bank account: <input type="text" name="bank_acc" id="acc">
  <br><br>
  Bank password: <input type="text" name="bank_pwd" id="pwd">
  <br><br>
  <button type="button" onclick="validate_input()">Submit</button>
  <p id="msg"></p>
</form>

<?php
echo "<h2>Your Input:</h2>";
echo $name;
echo "<br>";
echo $address;
echo "<br>";
echo $email;
echo "<br>";
echo $mobile;
echo "<br>";
echo $bank_acc;
echo "<br>";
echo $bank_pwd;
?>

</body>
</html>
