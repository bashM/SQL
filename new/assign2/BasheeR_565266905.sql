The Assignment

Part One:

1	List all the information about each teacher.
Solution:
Query:
SELECT * FROM Teachers;

Relational Algebra:
Teachers;

Datalog:
Result (ti,tn,as,em,pn) <- Teachers (ti,tn,as,em,pn)
 
 
2	List the name of each teacher who can teach either the subject with the subjectID "Math 10", or the subject with the subjectID "Science 10" or both.
Solution:
             Query:
 SELECT t.tname FROM teachers t JOIN qualifications q ON t.teacherID = q.teacherID WHERE (q.subjectID ='Math10' OR q.subjectID ='Science10');

Relational Algebra:
Pi_{teachers_names}(teachers join_ (qualifications q ON t.teacherID =
q.teacherID)Delta_( q.subjectID ='Math10' OR q.subjectID ='Science10')

Datalog:
result (techers_name) <- treachers (-,tn,-,-,-) and q.subjectID ='Math10'
OR q.subjectID ='Science10'


3	List the name of each school which offers the subject with the subjectID "Math 10", but not the subject with the subjectID "Science 10".
Solution:
             Query:
SELECT s.sname FROM offerings o JOIN schools s ON o.schoolID = s.schoolID WHERE o.schoolID != 'Math 10' AND o.schoolID!= 'Science 10';

Relational Algebra:
Pi_{school_name} (oferrings join_( o.schoolID = s.schoolID) Delta_(
o.schoolID != 'Math 10' AND o.schoolID!= 'Science 10';)

Datalog:
	Result (Sn) <- offerings (si,-,-) and subject(si,-) and o.schoolID != 'Math

                   10' AND o.schoolID!= 'Science 10';)


4	For each teacher, list the teacher's name and the subjectID of each subject he/she is qualified to teach.
Solution:
             Query:
SELECT t.tname,s.subjectID FROM teachers t
  JOIN qualifications q ON t.teacherID = q.teacherID
 JOIN subjects s ON q.subjectID = s.subjectID;
	
Relational Algebra:
           Pi_{teacher_names, subjectID} (teachers t
                       JOIN qualifications q(t.teacherID = q.teacherID) join_( subjects s ON 
           q.subjectID = s.subjectID;

	
Datalog:
Result(tn,si) <- teachers (tid,tn,-,-,-) and qualifications (tid,-) and subject (
Id,-) 


5	For a school named "Denbridge Secondary School", list the teacherID and the name of each teacher who had at least one assignment in this school in the month of January 2008. The result should not show any duplicates.
Solution:
             Query:
SELECT a.teacherID,t.tname FROM assignments a JOIN teachers t ON a.teacherID=t.teacherID JOIN schools s
 ON a.schoolID=s.schoolID WHERE s.sname=" Denbridge Secondary School " AND 
 MONTH(a.assignmentDate) = 1 AND YEAR(a.assignmentDate) = 2008;

Relational Algebra:
Pi_{teacherID,teacher_name} (assigments join_( assigments. teacherID
=  teachers. teacherID) (school join_( assignments.schoolID=
schools.schoolID) Delta_(school.sname=" Denbridge Secondary School "
) join_(year 2008) school and assignment))

 Datalog:
result ( tn,tid) <- teachers( tid,tn,-,-,-) and assignment (-,tid,sid,-,-,-,-,-)
and schools(sid,-,-,-,-) and s.sname=" Denbridge Secondary School "
and a.assignmentDate = 2008.



6	List the subjectID of each subject the school named "Denbridge Secondary School" does not offer.
Solution:
             Query:
SELECT DISTINCT o.subjectID FROM offerings o JOIN schools s ON 
 o.schoolID = s.schoolID WHERE s.sname!= 'Denbridge Secondary School';

Relational Algebra:
Pi_{subjectID} (offerings join_( offerings.schoolID = schools.schoolID)
Delta_(schools.name != 'Denbridge Secondary School')

	Datalog:
	result(sid) <- offerings(sid,sid,-) and schools(sid,-,-,-,-) and 
            s.sname!= 'Denbridge Secondary School'

7	List the teacherID and the name of each teacher who, so far, has never had an assignment in the school named "Denbridge Secondary School".
Solution:
             Query:

SELECT DISTINCT a.teacherID,t.tname FROM assignments a JOIN teachers t ON a.teacherID=t.teacherID JOIN schools s
 ON a.schoolID=s.schoolID WHERE s.sname!=" Denbridge Secondary School ";

	Relational Algebra:
	Pi_{teacherID, teacher_name} (assignments join_( teachers.teacherID =
            assignments. teacherID) schools_join(assignments.schoolID=
            school.schoolID) Delta_( s.sname!=" Denbridge Secondary School ")

	Datalog:
	Result (tid,tn) <- assignments(-,tid,-,-,-,-) and schools(sid,-,-,-,-) 
           And sname!=" Denbridge Secondary School "

8	For each assignment done for the subject with the subjectID "Science 10", list the name of the teacher, the name of the school, the date the assignment happened and the number of hours the assignment lasted.
Solution:
             Query:
SELECT DISTINCT t.tname,s.sname,a.assignmentDate,a.hours FROM assignments a JOIN teachers t ON a.teacherID=t.teacherID JOIN schools s
ON a.schoolID=s.schoolID JOIN subjects sb ON a.subjectID=sb.subjectID WHERE sb.subjectID='Science 10';

		Relational Algebra:
		Pi_{teacher_name, school_name, a.assignmentDate, a.hours}
		(assignments_join(assignment.teacherID=teacher.teacherID) school join_(     
                        assignment.schoolID=schools.schoolID) subject join_(assignment .
                        subjectID=subject.subjectID) Delta_( subject.subjectID='Science 10')
		
Datalog:
Result (tn,sn,ad,ah) <- assignments(-,tid,-,-,sid,-) and school( sid,-,-,-,-) 
and Subject (sid,-)
		






Part Two:

1	List the highest hourly wage offered by any school for any subject.
Solution:
             Query:
SELECT s.sname,sb.subjectID FROM offerings o JOIN  schools s ON s.schoolID=o.schoolID JOIN subjects sb ON o.subjectID=sb.subjectID WHERE o.hourlyWage=(SELECT MAX(hourlyWage) FROM offerings);   

2	A school named "Denbridge Secondary School" wants to find someone to teach a subject with the subjectID "Math 11". List the name, phone number and email of each teacher who is qualified to teach this subject, and the preference of this teacher gives to this school. Order the display according to the preference descending.
Solution:
             Query:

SELECT t.tname, t.email, t.phoneNo FROM teachers t JOIN qualifications q ON 
 t.teacherID = q.teacherID JOIN preferences p ON q.teacherID = p.teacherID WHERE subjectID = 'Math 10' ORDER BY preference DESC;


For each teacher, list his/her name, and the number of subjects he/she is qualified to teach. If a teacher is not qualified to teach any subject yet, his/her name should still be on the list and the number of subjects should be shown as 0.
Solution:
             Query:
(SELECT t.tname, COUNT(*)
  FROM teachers t JOIN qualifications q ON q.teacherID=t.teacherID  GROUP BY t.tname
 ORDER BY COUNT(*) DESC) UNION ALL (SELECT t.tname,'0' FROM  teachers t WHERE t.teacherID NOT IN (SELECT teacherID FROM qualifications)  GROUP BY t.tname
 ORDER BY COUNT(*) DESC);




List the name of each school that offers ALL the subjects.
Solution:
             Query:

SELECT s.sname
FROM schools s JOIN offerings o ON s.schoolID = o.schoolID
GROUP BY s.sname 
HAVING COUNT(*) = (SELECT COUNT(*) FROM subjects);

For each teacher, count the total number of hours he/she teached in January 2013.
Solution:
             Query:
SELECT t.tname,SUM(a.hours)AS total_hours_worked FROM teachers t JOIN assignments a ON a.teacherID=t.teacherID
WHERE MONTH(a.assignmentDate)=1 AND YEAR(a.assignmentDate)=2013 GROUP BY t.tname ;

List the name of the school that offers the most subjects.
Solution:
             Query:


  FROM schools s JOIN offerings o ON o.schoolID=s.schoolID
 GROUP BY s.sname
 ORDER BY COUNT(*) DESC  LIMIT 1;

List the name of each teacher who teached more than 300 hours in the year 2013. Order the display according to the teacher's total working hours in 2013 descending.
Solution:
             Query:


SELECT t.tname,SUM(a.hours)AS total_hours_worked FROM teachers t JOIN assignments a ON a.teacherID=t.teacherID
WHERE YEAR(a.assignmentDate)=2013 GROUP BY a.hours DESC HAVING SUM(a.hours)> 300;

























