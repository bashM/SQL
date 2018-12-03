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
			<a href="<?php echo $home."/newbook.php";?>">Add New books in the store</a>
		    </div>
            <div class="col-md-10" class="b0x">
			<legend>Books I have</legend>
			 <table class="table">
    <thead>
      <tr>
        <th>Book Title</th>
        <th>Author Name</th>
        <th>Purchase Date</th>

		<th>Sell Now</th>
      </tr>
    </thead>
	 <tbody>
			
			<?php 
			$books=myBooks();
			if($books==0)
			{
				echo "<center>";
				die("Currently You have no Books.");
			}else
			{
				foreach($books as $mybooks){
					$bid=$mybooks['bookId'];
					$issue=$mybooks['issue'];
		$end=$mybooks['end'];
		
					$data=getBooksbyID($bid);
					
					foreach($data as $book){
					
		$author=$book['author'];
		$bid=$book['bookId'];
		$bname=$book['bookTitle'];
		
		
		
	 ?>
	
	 <tr>
	 <td>
	 <form action="assignbook.php" method="POST" onsubmit="return confirm('You are about to sell this book?')">
	 <input type="hidden" name="bid" value="<?php echo $bid;?>">
	 
	 
	 <a href="<?php echo $home."/bookdetails.php?bid=".$bid;?>"><?php echo $bname;?></a>
	 </td><td>
	 <?php echo $author;?>
	 </td>
	 <td>
	 <?php echo $issue;?>
	 </td>

	 
	 <td><input type="submit" name="return" value="Sell Book" class="btn-danger"></td>
	 
	 </form>
	 
	 </tr>
	<?php
				
				
				
				
				
			}
			}
			}
			
			?>
			
			
	</tbody>
	</table>
			
			
			</div>
			
			
     </div>
</main>	 