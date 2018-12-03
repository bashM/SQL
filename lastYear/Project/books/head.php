<style type="text/css">
body{
    margin:3%;
    
}
th {
    background-color: #20B2AA;
    color: white;
} 
select option:disabled { color: blue; font-weight: solid;]] }
.circular {
	width: 80px;
	height: 80px;
	border-radius: 150px;
	-webkit-border-radius: 150px;
	-moz-border-radius: 250px;
	background: url(http://link-to-your/image.jpg) no-repeat;
	box-shadow: 0 0 8px rgba(0, 0, 0, .8);
	-webkit-box-shadow: 0 0 8px rgba(0, 0, 0, .8);
	-moz-box-shadow: 0 0 8px rgba(0, 0, 0, .8);
	}
#header-cont {
    background: black;
	color:white;
    width:100%;
    position:fixed;
    top:0px;
	
}
#header-cont:nth-child(n){ clear:both;}
.header {
    height:50px;
    
    border:1px solid #CCC;
   
    margin:0px auto;
}

.content {
    width:100%;
    background: white;
    border: 1px solid #CCC;
    height: 2000px;
    margin: auto;
}
.title, .user{ width:50%; float:left;}
</style>
<?php
session_start();


if (isset($_SESSION['auth'])) {
    $name = $_SESSION['auth'];
    include('bs.txt');
    require('config.php');
?>
</head>
<body>

<div id="header-cont">
<center>

    <div class="title"><a title="Homepage" href='<?php
    echo $home;
?>'><img src='<?php
    echo $home;
?>/img/icons/back.jpg' height=20px></a><?php
    echo $title;
?></div> 
	<div class="user">Welcome <?php
    echo "<b>" . $name . "</b>";
?>&nbsp;&nbsp;&nbsp;
	
	
	
	
	
	
	<a title="Logout" href='logout'><span class="btn-danger">Logout</span></a>
	
	
	
	</div> 
	
	</center>
	
</div>

<?php
} else {
    header("Location: login?location=" . $_SERVER['REQUEST_URI']);
}



?>
 
