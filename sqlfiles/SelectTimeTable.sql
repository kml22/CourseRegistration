CREATE OR REPLACE PROCEDURE SelectTimeTable
(sStudentId IN NUMBER,
nYear IN NUMBER,
nSemester IN NUMBER,
tCourse OUT NUMBER,
tUnit OUT NUMBER)
IS
	CURSOR timeTable IS
		select c.c_id, c.c_name, c.c_class, c.c_classroom, c.c_day, c.c_credit, c.c_time, p.p_name 
		from course c, professor p 
		where c.p_id = p.p_id 
		and (c.c_id, c.c_class) in (select c_id, c_class from enroll where s_id=sStudentId and e_year = nYear and e_semester = nSemester );

BEGIN
	tCourse := 0;
	tUnit := 0;
	FOR course_list IN timeTable LOOP
		tCourse := tCourse + 1;
		tUnit := tUnit + course_list.c_credit;

	END LOOP;
END;
/