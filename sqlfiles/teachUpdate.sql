CREATE OR REPLACE TRIGGER teachUpdate AFTER
INSERT ON course
FOR EACH ROW
DECLARE
	nYear NUMBER(10);
    nSemester NUMBER(10);
BEGIN
	nYear := Date2EnrollYear(SYSDATE);
    nSemester := Date2EnrollSemester(SYSDATE);

	INSERT INTO teach VALUES(:new.p_id ,:new.c_id, :new.c_class, nYear, nSemester);
END;
/