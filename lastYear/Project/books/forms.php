<?php

function categories()
{?>
	
			<!--<a href='Add-Product'> Add new Product</a><br>-->
			<a href='Category'>Manage Product</a><br>
			<a href='New-Invoice'> Generate Invoice</a><br>
			<a href='Search-Invoice'>Search Invoices</a><br>
			<a href='Sales'>Sales</a><br>
			
        <?php
}
function Loginform(){
    ?> <h3>Login</h3>
        <table><form method="POST" action="login.php">

            <tr><td><input type="text" value="name@example.com" placeholder="username" name="uname"></td></tr>
            <tr><td><input type="password" value="passwd" placeholder="password" name="passwd"></td></tr>
            <tr><td><input type="submit" class="btn-primary" value="login" name="login"</td></tr>
                <td><a href="register.php">Register New Account</a></td>
        </form></table>

<?php

}

?>