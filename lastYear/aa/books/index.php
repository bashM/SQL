<?php
include('head.php');
require('sql.php');
?>
<body class="box">
<main><div class="row">
        <div class="col-md-2">
            <h2>Menu</h2>
		    <a href="<?php echo $home;?>">Homepage</a><br>
			<a href="<?php echo $home."/mybooks.php";?>">My Books ( <?php echo countmybooks();?> )</a><br>
			<a href="<?php echo $home."/newbook.php";?>">Add New books in Store</a>
			
		    </div>
            <div class="col-md-10" class="b0x">
			<legend>Available Books in Store</legend>
			<br>
  
  <table class="table">
    <thead>
      <tr>
        <th>Book Title</th>
        <th>Author Name</th>
        <th>Available</th>
		<th>Assign book</th>
      </tr>
    </thead>
	 <tbody>
	 <?php 
	 if(isset($_POST['delbook'])){ 
	 if(delbook($_POST['bid'])==1){?>
		 		<div class="alert alert-danger">
        <span class="close" data-dismiss="alert">&times;</span>
		<strong>Deleted. </strong>Book deleted from Store.</div>
	 <?php 
	 }/*
	 sleep(3);
	 header("Location: index.php");*/}
			 
		 
		 
	 $data=getBooks();
	 if($data==0)die("<center><h2>No books in Database.<h2></center>");
	 foreach($data as $book){
		$author=$book['author'];
		$bid=$book['bookId'];
		$bname=$book['bookTitle'];
		$available=available($bid);
		
		
	 ?>
	 <tr>
	 <td>
	 <form action="assignbook.php" method="POST">
	 <input type="hidden" name="bid" value="<?php echo $bid;?>">
	 
	 <a href="<?php echo $home."/bookdetails.php?bid=".$bid;?>"><?php echo $bname;?></a>
	 </td><td>
	 <?php echo $author;?>
	 </td><td>
	 <?php echo $available;?>
	 </td>
	 <?php if($available=="YES"){?>
	 <td><input type="submit" name="assign" value="Buy Book" class="btn-success"> </form><form action="" method="POST" onsubmit="return confirm('Are you sure you want to delete this book')">
	 <input type="hidden" name="bid" value="<?php echo $bid;?>"><input type="Submit" value="Delete" class="btn-danger" name="delbook"></form></td>
	 
	 <?php }else{ ?>
	 <td><input type="button" name="assign" value="Not Available for Now" class="btn-disabled" disabled> </form>
	 <form action="" method="POST"  onsubmit="return confirm('Are you sure you want to delete this book')">
	 <input type="hidden" name="bid" value="<?php echo $bid;?>">
	 <input type="Submit" value="Delete" class="btn-danger" name="delbook"></form></td>
		 
	 <?php } ?>
	
	 </tr>
	 <?php }?>
	</tbody>
	</table>
  
 
  
</div>


</div>
</main>
</body>