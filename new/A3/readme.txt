
basheeR
565266905. 
Assignment 3. 

In this assignment I have written all my program on one .cpp file . I have 5 main functions. 
The first function is about getting the all the phone calls that has done by the user. 
In here users can enter the 3 digits area code, then 7 string as the rest of the phone number. 
Then users can leave just on, and write the area code of the other phone line, 
flowed by the 7 digits phone number this can be done as [ 305 7771001 250 7770007].  After entering both numbers the user should be able to see the result.
If the phone number was wrong the program will return and empty tables, and users can see a “0” values given on the terminal as a result.  
However, users can re-enter the same choice “d” so they can enter a different phone number but it has to be done as the above example.  
IF the phone number was correct, the user should be to delete or keep the records by simply choosing [Y/N]. if Y the phone number will be deleted.  
And N, means nothing is deleted. Also, I have used the char row function to see if the user has data or not! 

Finally, this is the query that I sued to run this function: 

select * from Call where fromArea=:1 AND  fromNumber =:2 AND toArea =:3 AND toNumber=:4

this query to delete the unwanted phone records: 

delete from Call where rid = :1

The n choice is provided for users to see the result of the phone number that is entered to look put for the phone number’s billing address, 
the user’s address and the total duration of the phone calls. In this function users just need to enter both area code and phone number to see the result. 
The format for entering the number can be done as this area code, space, the phone number. For example [ 305 7771001].  
After entering the correct phone number the user should be able to see the above information, as well as the total sum of the duration itself. 
If the users entered the wrong number, then the program will take the user to the help menu and from there users can re-enter the correct phone number. 
This is the query I used for this case:

select billingAddress, address, totalDuration 
from Customer Natural Join Phone, (select areaCode, Pnumber, sum(duration) as totalDuration 
					from Phone natural join Call 
					where (areaCode= fromArea and Pnumber=fromNumber) 
					GROUP BY areaCode, Pnumber) 
				where (Phone.Pnumber=:1 and Phone.areaCode=:2)

The s selection is were users can see the monthly repot of each phone number that was done in the given date. 
The date is an input that users can enter to see all the result and phone calls that was done on the given period of time.
I designed the  database as [dd-mon-yy].  So when users want to enter the date that is wanted to view the summery report, 
they would have to be as the given formant. 
For example, lets say the user wants to view the name, address, and the number of calls that were done on march the 7th, 2015.  
So the users will enter this [07-MAR-15]. In this case users can view the report of the given date. If the date wasn’t matching the database’s date format,
 or the information wasn’t in the database then the users have to re-enter the right date to get out the summery reports. 

The query I used for this case: 

select cid, name, billingAddress, count(rid)
from customer Natural JOIN call Natural Join Phone 
where StartDate=:1 
GROUP BY cid,name,billingAddress.


Finally, the q selection. This used to terminate and exit the program. 
Note: to avoid the loop. You can use ‘q’ to kill the loop! 

In the end I would say I spent more than 30hrs to get this program running. 
Also, I did spent so much time trying to fix one of the query that wasn’t working. 
The issue was really simple! I actually had to delete a “:” form one of the query, which made the program not running in the correct way!  




