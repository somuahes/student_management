-- CREATE TABLE Student (student_id VARCHAR(8) PRIMARY KEY,
-- 					 first_name VARCHAR(50),
-- 					 last_name  VARCHAR(50),
-- 					 date_of_birth DATE,
-- 					 email VARCHAR (60),
-- 					 phone_number VARCHAR(10));
-- CREATE TABLE Course (course_id SERIAL PRIMARY KEY,
-- 					 course_name VARCHAR(50),
-- 					 course_code VARCHAR(7));
-- CREATE TABLE Fees_payments(payment_id SERIAL PRIMARY KEY,
-- 						   student_id VARCHAR REFERENCES Student(student_id),
-- 						  amount_paid NUMERIC(10,2),
-- 						  payment_date DATE,
-- 						  total_fees NUMERIC(10,2));
-- CREATE TABLE Course_enrollment(enrollment_id SERIAL PRIMARY KEY,
-- 							   student_id VARCHAR REFERENCES Student(student_id),
-- 							  course_id INT REFERENCES Course(course_id),
-- 							  enrollment_date DATE);
-- CREATE TABLE Lecturer(lecturer_id SERIAL PRIMARY KEY,
-- 					  first_name VARCHAR(50),
-- 					  last_name VARCHAR(50),
-- 					  email VARCHAR (100));
-- CREATE TABLE Lectures_course(assignment_id SERIAL PRIMARY KEY,
-- 							lecturer_id INT REFERENCES Lecturer(lecturer_id),
-- 							course_id INT REFERENCES Course(course_id));
-- CREATE TABLE ta(ta_id SERIAL PRIMARY KEY,
-- 			   first_name VARCHAR(50),
-- 			   last_name VARCHAR(50),
-- 			   email VARCHAR(100));
-- CREATE TABLE ta_course(assignment_id SERIAL PRIMARY KEY,
-- 					  lecturer_id INT REFERENCES Lecturer(lecturer_id),
-- 					  ta_id INT REFERENCES ta(ta_id));
-- INSERT INTO Student(student_id,first_name,last_name,date_of_birth,email,phone_number)
-- VALUES('11347946','Derrick','Ampongsah','2000-02-02','deamp@gmail.com','0234567920'),
--       ('11004272','Ishaan','Bhardwaj','2004-02-03','isbhardway@gmail.com','0854635472'),
-- 	  ('11049492','Asare', 'Marvin','2005-01-06','asmarv@gmail.com','0765432345'),
-- 	  ('11117318','Steven', 'Abokuah','2004-07-12','stvaboku@gmail,com','0765432345'),
-- 	  ('11238291','Ninson','Obed','2004-10-10','obninso@gmail,com','0234123893')
-- INSERT INTO Course(course_name,course_code)
-- VALUES('Differential Equation','SENG202'),
--       ('Computer Systems Design','CPEN202'),
-- 	  ('Data Structures and Algorithm','CPEN204'),
-- 	  ('Linear Ciruits','CPEN206'),
-- 	  ('Software Engineering','CPEN208'),
-- 	  ('Data Communications','CPEN212'),
-- 	  ('Academic Writing II','CBAS210');
-- INSERT INTO  Lecturer(first_name, last_name,email)
-- VALUES('John','Kutor','jkutor@gmail.com'),
--       ('Agyare','Debrah','agdeb@gmail.com'),
--       ('Margaret','Richardson','mrich@gmail.com'),
-- 	  ('Godfrey','Mills','godmill@gmail.com'),
-- 	  ('John','Assiamhah','johass@gmail.com'),
-- 	  ('Isaac','Aboagye','isagye@gmail.com'),
-- 	  ('Percy','Okae','perok@gmail.com');
-- INSERT INTO Fees_payments(student_id,amount_paid,payment_date,total_fees)
-- VALUES('11347946','1000.00','2024-01-02','3000.00'),
--        ('11004272','2500.00','2024-01-01','3000.00'),
-- 	   ('11049492','3000.00','2024-03-01','3000.00'),
-- 	   ('11117318','0.00','2024-05-03','3000.00'),
-- 	   ('11238291','500.00','2024-06-03','3000.00');
-- INSERT INTO Course_enrollment(student_id,course_id,enrollment_date)
-- VAlUES('11347946','1','2024-01-02'),
--        ('11347946','2','2024-01-02'),
-- 	   ('11004272','1','2024-01-01'),
-- 	   ('11049492','5','2024-03-01'),
-- 	   ('11238291','4','2024-06-03');
-- INSERT INTO Lectures_course(lecturer_id,course_id)
-- VALUES('1','1'),
--        ('2','2'),
-- 	    ('3','3'),
-- 		 ('4','4'),
-- 		 ('5','5'),
-- 		 ('6','6'),
-- 		 ('7','7');
-- INSERT INTO ta(first_name,last_name,email)
-- VALUES('Thaddeus','Ofori','tdofori@gmail.com'),
--      ('Bamzy','Agyei','badjei@gmail.com'),
-- 	 ('Foster','Anopansuo','fanu@gmail.com'),
-- 	 ('Hakeem','Nasser','haknass@gmail.com'),
-- 	 ('Foster','Anopansuo','fanu@gmail.com'),
-- 	 ('Samed','Mohammed','sameed@gmail.com');
-- INSERT INTO ta_course(lecturer_id,ta_id)
-- VALUES('1','1'),
--        ('2','2'),
-- 	   ('3','3'),
-- 	   ('4','2'),
-- 	   ('5','5');
CREATE OR REPLACE FUNCTION calculate_outstanding_fees()
RETURNS SETOF JSON AS $$
BEGIN
    RETURN QUERY
    SELECT 
        json_build_object(
            'student_id', s.student_id,
            'first_name', s.first_name,
            'last_name', s.last_name,
            'outstanding_fees', 3000 - COALESCE(SUM(fp.amount_paid), 0)
        )
    FROM 
        Student s
    LEFT JOIN 
        fees_payments fp ON s.student_id = fp.student_id
    GROUP BY 
        s.student_id, s.first_name, s.last_name;
END;
$$ LANGUAGE plpgsql;


	
	   
	   
	   