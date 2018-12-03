<!DOCTYPE html>
<?php session_start();
if(isset($_SESSION['auth'])){
 header("Location: home");

}else{
include('forms.php');
include('bs.txt');
?>
<html lang="en">

<body class="box">
<div class="container">
    <main>
        <?php
		echo "<center>";
        global $old;
        if(isset($_GET['location'])){
         $_SESSION['old']=htmlspecialchars($_GET['location']);
        }
        if(!isset($_POST['login'])){
            if(isset($_GET['register'])){
                echo "<h2> Your account has been registered. Please login</h2>";
            }
           loginform();
        }else{

            if (empty($_POST['uname'])||empty($_POST['passwd'])){echo "<center><font color='red'>Invalid Username/Password</font>";
                loginform();
            die();}
            $uname=$_POST['uname'];
            $passwd=$_POST['passwd'];
            $passwd=md5($passwd);
            require 'config.php';
            $query = dbConnect()->prepare("SELECT * FROM students WHERE email=:name AND password=:password");
            $query->bindParam(':name', $uname);
            $query->bindParam(':password', $passwd);
            $query->execute();

            if($row = $query->fetch()){


                    $_SESSION['auth'] = $row['name'];
					$_SESSION['rollNo'] = $row['rollNo'];
					$_SESSION['sid'] = $row['studentId'];
					

                echo $_SESSION['old']. " is next page";
                $old=$_SESSION['old'];
               header("Location: $old");
            }else
            {
                echo "<center><font color='red'>Invalid Username/Password</font>";
                loginform();
                die();
            }
            //echo "to be coded!";



        }
}

        ?>
        <br><br><br>

    </main>
</div>
</body>
</html>

