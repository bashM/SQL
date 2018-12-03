<?php
function dbConnect(){
    try{
        $username = 'basep_16080416'; //your phpmyadmin credentials
        $password = '//??//'; //
        $conn = new pdo("mysql:host=sql104.base.pk;dbname=basep_16080416_books;", $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $conn;

    }   catch(PDOException $e){
        echo 'ERROR', $e->getMessage();
    }


}

$title="Book Store";
$home="http://basheerma.base.pk/books";
$email="test@Hotmail.com";


?>