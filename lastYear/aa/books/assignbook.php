<?php
include('head.php');
require('sql.php');
if(isset($_POST['assign']))
{ 
	$bid=$_POST['bid'];
	$sid=$_SESSION['sid'];
	$issue = date("Y-m-d H:i:s");
	$end = date("Y-m-d H:i:s",strtotime("+1 week"));
   $check=alreadyissue($bid,$sid);
   if($check=="OK"){
  $query = dbConnect()->prepare("update books set studentID=:sid where bookID=:bid");
  $query->bindParam(':bid', $bid);
  $query->bindParam(':sid', $sid);
  if($query->execute()){
	  $query = dbConnect()->prepare("update books set stock=stock-1 where bookId=:bid");
	  $query->bindParam(':bid', $bid);
	  $query->execute();
	  
	  header("Location: $home/mybook.php");
  }
   }else{
	   header("Location: $home/mybooks.php");
	   
   }
	
	
}
if(isset($_POST['return']))
{ 
	$bid=$_POST['bid'];
	$sid=$_SESSION['sid'];
	$issue = date("Y-m-d H:i:s");
	$end = date("Y-m-d H:i:s",strtotime("+1 week"));
   $check=alreadyissue($bid,$sid);$query = dbConnect()->prepare("delete from transactions where bookId=:bid and studentId=:sid");
  $query->bindParam(':bid', $bid);
  $query->bindParam(':sid', $sid);
  if($query->execute()){
	  $query = dbConnect()->prepare("update books set studentID = 48484, stock= stock+1 where bookId=:bid");
	  $query->bindParam(':bid', $bid);
	  $query->execute();
	  header("Location: $home/mybooks.php");
  }
   	
}
else{header("Location: $home");}
?>
