select billingAddress, address, totalDuration
 from Customer Natural Join Phone, (select areaCode, Pnumber, sum(duration) as totalDuration 
                                                    from Phone natural join Call 
                                                    where (areaCode= fromArea and Pnumber=fromNumber)
                                                   GROUP BY areaCode, Pnumber) 
                                                   where (Pnumber = '7771001' AND areaCode= '250'); 
                                                
                                                    
                                                    
                                                    
                                                    


select billingAddress, address, sum(duration) from Customer natural join Phone natural join( select areaCode, Pnumber, sum(duration) as totalDuration from Phone p natural join Call c ON p.areaCode = c.formArea AND p.Pnumber = c.fromNumner group by areaCode, Pnumber);
  

select billingAddress, address, sum(duration) AS "total" from Customer natural join Phone natural join Call 
where (select Pnumber from Phone where Pnumber = 7771001)
GROUP BY billingAddress, address; 




select cid, name, billingAddress, count(rid)
from Customer Natural join Call 
where StartDate = '07-MAY-15'
group by cid,name,billingAddress; 




"select billingAddress,address, total(Duration) from Customer Natural JION Phone Natural JION (select areaCode, Pnumber, sum(duration) as total(duration) from phone p JION call c on p.areaCode = c.fromNumber and p.pnumber = c.fromNumber) group by areaCode, pnumber where areaCode=:1 AND Pnumber=:2";
