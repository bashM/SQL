<?php
include('head.php');
require('sql.php');
if(isset($_POST['add']))
{
    $bookid=rand(100,999);
  $query = dbConnect()->prepare("insert into books(bookId, author, pages, stock, bookTitle, studentID)
 Values(:bid, :author, :pages, :stock, :title, :std)");
  $query->bindParam(':bid',$bookid);
  $query->bindParam(':author', $_POST['author']);
  $query->bindParam(':pages', $_POST['pages']);
  $query->bindParam(':stock', $_POST['stock']);
  $query->bindParam(':title', $_POST['title']);
    $query->bindParam(':std', $_POST['sid']);

  if($query->execute()){
	  header("Location: $home");
  }
  
	
}
?><body class="box">
<main><div class="row">
        <div class="col-md-2">
            <h2>Menu</h2>
			<a href="<?php echo $home;?>">Homepage</a><br>
			<a href="<?php echo $home."/mybooks.php";?>">My Books ( <?php echo countmybooks();?> )</a><br>
			<a href="<?php echo $home."/newbook.php";?>">Add New books in Library</a>
			</div>
            <div class="col-md-10" class="b0x">
			<legend>New Book </legend>
			<div class="col-md-4">
			<form method="POST" action="" class="form-controls">
                <input type="hidden" name="sid" value="<?php echo $_SESSION['sid'];?>">
			<input type="text" name="title" value="" placeholder="Book Title">
			<input type="text" name="author" value="" placeholder="Author Name">
			<input type="number" min="1" name="stock" value="" placeholder="Quantity">
			<input type="number" name="pages"  min="1" value="" placeholder="Book page count">
			<input type="submit" name="add" value="Add Book" class="btn-primary">
			
			</form>
			</div>
			</div>
			</main>