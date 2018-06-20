CREATE OR REPLACE TRIGGER BeforeUpdateProfessor BEFORE
UPDATE ON professor
FOR EACH ROW
DECLARE
	underflow_length EXCEPTION;
	invalid_value EXCEPTION;
	nLength NUMBER;
	nBlank NUMBER;
BEGIN
nLength := Length(:new.p_pwd);
	nBlank := INSTR(:new.p_pwd, ' ', 1, 1);

	IF nLength < 4 THEN
		RAISE underflow_length;
	END IF;

	IF nBlank != 0 THEN
		RAISE invalid_value;
	END IF;

	EXCEPTION
		WHEN underflow_length THEN
			RAISE_APPLICATION_ERROR(-20002, '암호는 4자리 이상이어야 합니다');
		WHEN invalid_value THEN
			RAISE_APPLICATION_ERROR(-20003, '암호에 공란은 입력되지 않습니다.');
END;
/