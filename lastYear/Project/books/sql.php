<?php
//require('config.php');

function registerhim($uname,$email,$passwd, $phone){

$roll=rand(100,999);
    $query = dbConnect()->prepare("insert into students(name, email, password, rollNo, phone) Values(:name, :email, :passwd, :rollno, :phone)");
    $query->bindParam(':rollno',$roll);
    $query->bindParam(':name', $uname);
    $query->bindParam(":email", $email);
    $query->bindParam(":passwd",$passwd);
     $query->bindParam(":phone",$phone);

if($query->execute()){
    return 1;
}
    else return 0;


}

function checkmail($mail){
    $query = dbConnect()->prepare("Select * from students where email=:mail");
    $query->bindParam(":mail",$mail);
    $query->execute();
    $count = $query -> rowcount();
    if($count>0){

        return 0;
    }else{return 1;}




}
function available($bid){
	$query = dbConnect()->prepare("Select * from books where bookId=:bid");
	$query -> bindParam(":bid", $bid);
	$query->execute();
	$data=$query->fetchAll();
	foreach($data as $book){
		$stock=$book['stock'];
	}
	if($stock!=0){
		return "YES";
		}else{return "NO";}
	}
function countbooks()
{
$query = dbConnect()->prepare("Select * from books");
$query->execute();
$count = $query -> rowcount();
return $count;
}
function delbook($bid){
	$query = dbConnect()->prepare("delete from books where bookId=:bid ");
	$query -> bindParam(":bid", $bid);
	if($query->execute()){return 1;}else{return 0;}
	
}
function countmybooks()
{
$query = dbConnect()->prepare("Select * from books where studentId=:sid");
$query ->bindParam(":sid", $_SESSION['sid']);
$query->execute();
$count = $query -> rowcount();
return $count;
}
function alreadyissue($bid,$sid){
$query = dbConnect()->prepare("Select * from transactions where studentId=:std and bookId=:bid");
$query->bindParam(":bid", $bid);
$query->bindParam(":std", $sid);
$query->execute();
if($row = $query->fetch()){
	return "Already";
	
}else{return "OK";}

	
	
}

function getBooksbyID($id){
	$query = dbConnect()->prepare("Select * from books where bookId=:id");
	$query->bindParam(":id",$id);
	$query->execute();
    $count = $query -> rowcount();
	if($count>0){
		$data=$query->fetchAll();
		return $data;
	}else{return 0;}
}


function getBooks(){
	$query = dbConnect()->prepare("Select * from books");
	$query->execute();
    $count = $query -> rowcount();
	if($count>0){
		$data=$query->fetchAll();
		return $data;
	}else{return 0;}
}
	function myBooks(){
	$query = dbConnect()->prepare("Select * from books where studentID=:std");
	$query->bindParam(":std",$_SESSION['sid']);
	$query->execute();
    $count = $query -> rowcount();
	if($count>0){
		$data=$query->fetchAll();
		return $data;
	}else{return 0;}
}


	
	
	
	
	
	
?>