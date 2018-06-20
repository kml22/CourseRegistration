CREATE OR REPLACE FUNCTION Date2EnrollSemester(dDate IN DATE)
RETURN NUMBER
IS
	eMonth CHAR(2);
	nSemester NUMBER;
BEGIN 
SELECT TO_CHAR(dDate, 'MM')
	INTO eMonth
	FROM DUAL;
	IF (eMonth >= '01' and eMonth <= '06') THEN
		nSemester := 1;
	ELSE
		nSemester := 2;
	END IF;
	RETURN nSemester;
END; 
/