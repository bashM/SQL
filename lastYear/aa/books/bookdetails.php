<head>
<style>
.attr {
	background-color: #8258FA;
   color: white;
} 
.val{
	background-color: #20B2AA;
    color: white;
	
}
</style>
</head>
<?php
include('head.php');
require('sql.php');
?>
<body class="box">
<main><div class="row">
        <div class="col-md-2">
            <h2>Menu</h2>
			<a href="<?php echo $home;?>">Homepage</a><br>
			<a href="<?php echo $home."/mybooks.php";?>">Issued Books ( <?php echo countmybooks();?> )</a><br>
			<a href="<?php echo $home."/newbook.php";?>">Add New books in Library</a>
		    </div>
            <div class="col-md-10" class="b0x">
			<legend>Book Details </legend>
			<?php
if(isset($_GET['bid'])){
	$bid=$_GET['bid'];
	$data=getBooksbyID($bid);
	if($data==0)
	{echo "<center>"; die("Book Not Found");}
	foreach($data as $book){
		$author=$book['author'];
		$bname=$book['bookTitle'];
		$available=available($bid);
		$pages=$book['pages'];
		$stock=$book['stock'];
	}
	?>
	<div class="col-md-4" class="b0x">
	<table class="table">
	<tr>
	<td class="attr"> Book Title
	</td>
	<td class="val">
	<?php echo $bname;?>
	</td>
	</tr>
	<tr>
	<td class="attr"> Author Name
	</td>
	<td class="val">
	<?php echo $author;?>
	</td>
	</tr>
	<tr>
	<td class="attr"> Book Pages
	</td>
	<td class="val">
	<?php echo $pages;?>
	</td>
	</tr>
	<tr>
	<td class="attr"> Copies Available
	</td>
	<td class="val">
	<?php echo $stock;?>
	</td>
	</tr>
	</div>
	
	<?php
}else{
	header("Location: $home");
}
?>