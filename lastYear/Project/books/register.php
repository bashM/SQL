<!DOCTYPE html>
<?php session_start();
error_reporting(0);
require('config.php');
if(isset($_SESSION['auth'])){
 header("Location: home");

}else {
    include('forms.php');
    include('bs.txt');
    include('sql.php');
}
if(isset($_POST['register']))
{
   $name=$_POST['uname'];
    $email=$_POST['email'];
    $pass=md5($_POST['passwd']);
    $phone=$_POST['phone'];
    $register=registerhim($name,$email,$pass, $phone);
    if($register==1){
        header("Location: login.php?register=1;");
    }else{
       echo "<h2>Something Went Wrong with registeration, Try Again</h2";
    }

}else{

?>

    <meta charset="UTF-8">
    <title>
        Register New Account.
    </title>
</head>
<html lang="en">

<body class="box">
<center>
<div class="container">
    <main>
<h3> Register New Account</h3>
<table><form method="POST" action="register.php">

    <tr><td><input type="text" value="Name" placeholder="username" name="uname" required></td></tr>
        <tr><td><input type="Email" value="Email" placeholder="yourname@mail.com" name="email" required></td></tr>

    <tr><td><input type="password" value="passwd" placeholder="password" name="passwd" required></td></tr>
        <tr><td><input type="number" value="phone" placeholder="Phone #" name="phone" required></td></tr>

    <tr><td><input type="submit" class="btn-primary" value="Sign-up" name="register"</td></tr>

</form></table>

</body>
</html>
<?php }?>