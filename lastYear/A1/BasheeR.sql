/********************************************************************************
******************** BasheeR. ***************************************************
******************** 565266905. *************************************************
******************** A 1. *******************************************************
*********************************************************************************/ 

Part A:

RL:
 σ -------> Delta_
 ^ -------> Not Exists (Division). 
 DataLog:
 [something]--------> means not Exists.
 
 -------------------------------------------------------------------------------------------------------------------------------------
1) 
SQL:

Select *
From Customer; 

RL: 

Pi_{cid, name, address, email} (Customer)
 
DATALOG: 

Result( cid, name, address, email) <- Customer(C,n,a,e)

-----------------------------------------------------------------------------------------------------------------------------------
2) 
SQL: 

Select bid, title, category, status
From Book B natural JOIN BookCopy  BC
Where B.bookid = BC.bookid;

RL:

A #1:
Pi_{bid,title, category, Status} (Book JOIN_(BookCopy ON B.bookid=BC.bookid) 

A #2:
Pi_{bid,title, category, Status} (Delta_(book.bookid = BookCopy.bookid)(Book JOIN BookCopy))

DATALOG:  

Result(bid,title, catagory,status) <- BookCopy(b,_,s) and Book(_,t,c)
-------------------------------------------------------------------------------------------------------------------------------------------------
3) 
SQL: 

Select	bid,title, status
From	Book B JOIN BookCopy BC ON B.bookid = BC.Bookid
		and BorrowLog BL Right JOIN BookCopy BC ON BL.bid = BC.bid:
Where	checkOutDate > '2016-01-01' OR  checkOutDate = '2016-01-01';

RL: 

Pi_{bid,title,status} (Delta_(checkOutDate >= 2016-01-01)(BorrowLog)(BorrowLog JOIN BookCopy(BookCopy.bid=BorrowLog.bid)(Book JOIN BookCopy (Book.bookid = BookCopy.bookid))


DATALOG:

Result(bid,title,status) <- book(_,t,_) AND BookCopy(b,_,s) AND BorrowLog(_,b,c,_) AND checkOutDate  >= '2016-01-01'

--------------------------------------------------------------------------------------------------------------------------------------------------------------
4)
SQL: 

Select	title, catagory
From	Book B Natural JOIN BookCopy BC ON B.bookid = BC.bookid
		AND Customer C JOIN BorrowLog BL ON C.cid = BL.checkOutDate
Where	coustmer name like %Mary Poppins%;

RL: 

Pi_{title, catagroy} (Delta_ (custmoer name=Mary Poppins)(Customer JOIN orrowLog) AND (BookCopy JOIN Book))


DATALOG: 

Result(Title, catagory) <- Book(b,t,c) AND BookCopy(_,b,_) AND Customer (c,n,_,_) AND BorrowLog (c,b,c,_)

------------------------------------------------------------------------------------------------------------------------------------------------
5)

SQL: 

Select	title
From	Book
Where	Book catagory like %Junior non-fiction% or %Adult non-fiction%;

RL:

Pi_{title} (Delta_(catagory= Junior non-fiction or Adult non-fiction)(Book))

DATALOG: 

Result(title)-> book(_,t,_) AND title = "Junior non-fiction" or "Adult non-fiction"

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
6) 

SQL: 

Select	name,title,CheckOut,CheckIn, 
From	Book B JOIN Customer C JOIN BorrowLog BL
Where	C.cid = BL.cid

RL:
Pi_{name,title,CheckOut,CheckIn} ( Delta_(Customer.cid = BorrowLog.cid)(BorrowLog JOIN Customer) (Book JOIN bookCopy (Book.bookid = BookCopy.bookid) BorrowLog JOIN BookCopy(BookCopy.bid =BorrowLog.bid ))


DATALOG: 

Result(name,title,ChechOut,CheckIn)<-  Book(_,t,_) AND Customer(c,n,_,_) AND BorrowLog(c,_,c,c)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
7)

SQL: 

Select	title, name,CheckOut,CheckIn
From	Coustmer C Right JOIN BorrowLog BL ON C.cid = BL.cid
		AND Book B JOIN BookCopy BC ON B.bookid=BC.bookid 
		AND BC NATURAL JOIN BL ON BL.Bid = CB.bid
Where	Book status = "MISSING" / NULL; 

RL: 

Pi_{title,CheckOut,CheckIn} (Delta_(status= "MISSING"/ or NULL)(Book)) (Customer JOIN BorrowLog (Customer.cid = BorrowLog.cid) ( Book JOIN BookCopy (Book.bookid = BookCopy.bookid) 


Result(title, name, checkOut,checkIn) <- Book (b,_t,_) AND BookCopy(b,b,s) AND Coustmer(c,n,_,_,_) AND BookCopy Stauts= "MISSING"

--------------------------------------------------------------------------------------------------------------------------------------
8) 


SQL: 

Select	name,address, CheckOut
From	Customer C JOIN BorrowLog BL ON C.cid = BL.cid
		AND Book B NATURAL JOIN BookCopy BC ON B,bookid = BC.bookid 
		AND BC RIGHT JOIN BL ON BC.bid = BL.bid
Where	Book title Like %The History of Computer Science%;


RL: 

Pi_{name, address, CheckOut} (Delta_(title = The History of Computer Science)(book))(Customer JOIN BorrowLog (BorrowLog.cid =Customer.cid )(Book JOIN BookCopy (BookCopy.bookid = Book.bookid))(BookCopy JOIN BorrowLog)(BookCopy.bid= BorrowLog.bid))


DATALOG: 

Result( name,address,checkOut) <- Coustmer(c,n,a,_) AND BorrowLog (c,b,c,_) AND BookCopy(b,b,_) AND Book(b,t,_) AND Book title = "The History of Computer Science"

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
9)

SQL: 

Select	name,address,email
From	Customer C, BorrowLog BL
Where	NOT EXISTS ( Select	*
					From BorrowLog
					Where BL.cid = C.cid);
					
RL: 

Pi_{name,address,email} Delat_( BorrowLog.cid ^ Customer.cid)(Customer JOIN BorrowLog) 


DATALOG: 

Result(name,address,email) <- [BorrowLog(c,_,_,_), And Customer(c,_,_,_,_)] 

--------------------------------------------------------------------------------------------------------------------------------------------------------
10) 

SQL: 


Select	bookid, title, catagory
From	Book B, BorrowLog BL 
Where	NOT EXISTS ( Select	*
					 From	Book B, BookCopy BC, BorrowLog
					 Where	BL.bid = CB.bid 
					 		AND B.bookid = CB.bookid);
					 		
RL:

Pi_{bookid,title,catagory} (Delta_( BorrowLog.bid ^ BookCopy.bid)( BookCopy JOIN BorrowLog) ( Book.bookid ^ BookCopy.bid)(Book JOIN BookCopy))


DATALOG: 

Result(Bookbid,title,catagory)<- [BorrowLog(_,b,_,_,), and BookCopy(b,_,_)],[Book(b,_,_,_), and BookCopy(_,b,_)]
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


PART B: 

1) 

SQL: 

Select	name,adress,email
From	coustomer
Where	address like %Main Street%;

--------------------------------------------------------------------------------------------------------------------------------------------------
2)

SQL: 

Select	bid,title,checkOutDate
From	BookCopy NATURAL JOIN BorrowLog On BC.bid = BL.bid
Where	NOT EXISTS(	Select	*
					From BorrowLog	
					Where Checkout = NULL);
					
-------------------------------------------------------------------------------------------------------------------------------------------------
3) 
SQL: 

Select	COUNT(*)
From	BookCopy
Group By	Numbers
ORDER BY	COUNT(*) DESC LIMIT 1;

----------------------------------------------------------------------------------------------------------------------------------------------
4)
SQL: 


Select	title, COUNT(*)
From	Book JOIN BookCopy ON B.bookid = BC,bookid
Group BY	title
Order By	COUNT(*)DESC) UNION ALL( select	title,'0'
									 From	Book
									 where B.bookid NOT IN (Select	bookid
									 						From BookCopy
									 						Group BY title);
									 						
-------------------------------------------------------------------------------------------------------------------------------------
5)
SQL: 

Select	title,category
From	Book NATURAL JOIN BorrowLog ON B.CheckOut
Where	EXISTS(select	*
				From	Customer Right JOIN BorrowLog
				Where	C.cid = BL.cid);

A#2:
select  title, catagory
From    Book B NATURAL JOIN BookCopy BC ON BC.bookid = B.bookid
        AND BorrowLog BL RIGHT JOIN BookCopy BC ON BC.bid = BL.bid
Where   EXISTS( Select  *
                From    Customer C NATURAL JOIN BorrowLog BL
                where   C.cid = B.cid);				
------------------------------------------------------------------------------------------------------------------------------------------------
6)
SQL: 

Select	title
From	book
where	(select	MAX(bookid)
		From	Book);
		
------------------------------------------------------------------------------------------------------------------------------------------
7)
SQL; 


Select	title, catagory, COUNT(*)
From	BorrowLog BL JOIN Book B
Where	BL.ckeckOut = B.bookid
Having COUNT (*) > 100; 

A2:
Select  title, catagory, COUNT(*)
From    Book B, JOIN BookCopy BC ON B.bookid = BC.bookid
        AND BookCopy BC, JOIN BorrowLog BL ON BL.bid = BC.bid
Where   BorrowLog. CheckOut = Book.Bookid
Having COUNT (*) > 100;
 



