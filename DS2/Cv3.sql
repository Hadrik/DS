CREATE OR REPLACE PROCEDURE PPrint(p_text IN VARCHAR)
IS
BEGIN
    dbms_output.put_line(p_text);
END;


EXECUTE PPrint('ahojda');

SET SERVEROUTPUT ON;


CREATE OR REPLACE PROCEDURE PAddStudent
(
    p_login IN Student.login%type,
    p_fname IN Student.fname%type,
    p_lname IN Student.lname%type,
    p_email IN Student.email%type,
    p_grade IN Student.grade%type,
    p_date_of_birth IN Student.date_of_birth%type
)
IS
BEGIN
    INSERT INTO student
    (
        login,
        fname,
        lname,
        email,
        grade,
        date_of_birth
    ) VALUES ( 
        p_login,
        p_fname,
        p_lname,
        p_email,
        p_grade,
        p_date_of_birth
    );
END;

EXEC paddstudent('asd123', 'pepa', 'hnusny', 'abc@def.cz', 1, TO_DATE('2000-01-01', 'yyyy-mm-dd'));




CREATE OR REPLACE PROCEDURE PAddStudent2
(
    p_fname IN Student.fname%type,
    p_lname IN Student.lname%type,
    p_email IN Student.email%type,
    p_grade IN Student.grade%type,
    p_date_of_birth IN Student.date_of_birth%type
)
IS
    v_login Student.login%type;
BEGIN
    v_login := LOWER(SUBSTR(p_lname, 1, 3)) || '000';
    
    INSERT INTO student
    (
        login,
        fname,
        lname,
        email,
        grade,
        date_of_birth
    ) VALUES ( 
        v_login,
        p_fname,
        p_lname,
        p_email,
        p_grade,
        p_date_of_birth
    );
END;

EXEC paddstudent2('standa', 'jitrnice', 'imejl', 5, TO_DATE('1234-12-12', 'yyyy-mm-dd'))



CREATE OR REPLACE PROCEDURE PAddStudent3
(
    p_fname IN Student.fname%type,
    p_lname IN Student.lname%type,
    p_email IN Student.email%type,
    p_grade IN Student.grade%type,
    p_date_of_birth IN Student.date_of_birth%type
)
IS
    v_login Student.login%type;
BEGIN

    SELECT LOWER(SUBSTR(p_lname, 1, 3)) || LPAD((COUNT(1)+1), 3, '0')
    INTO v_login
    FROM Students;
    
    INSERT INTO student
    (
        login,
        fname,
        lname,
        email,
        grade,
        date_of_birth
    ) VALUES ( 
        v_login,
        p_fname,
        p_lname,
        p_email,
        p_grade,
        p_date_of_birth
    );
END;

EXEC paddstudent2('standa', 'jitrnice', 'imejl', 5, TO_DATE('1234-12-12', 'yyyy-mm-dd'))    



CREATE OR REPLACE FUNCTION FAddStudent2
(
    p_fname IN Student.fname%type,
    p_lname IN Student.lname%type,
    p_email IN Student.email%type,
    p_grade IN Student.grade%type,
    p_date_of_birth IN Student.date_of_birth%type
)
RETURN VARCHAR2
IS
    v_login Student.login%type;
BEGIN

    v_login := LOWER(SUBSTR(p_lname, 1, 3)) || '000';
    
    INSERT INTO student
    (
        login,
        fname,
        lname,
        email,
        grade,
        date_of_birth
    ) VALUES ( 
        v_login,
        p_fname,
        p_lname,
        p_email,
        p_grade,
        p_date_of_birth
    );
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'error';
RETURN 'ok';
END;




CREATE OR REPLACE FUNCTION FGetLogin
(
    p_fname IN Student.fname%type,
    p_lname IN Student.lname%type
)
RETURN Student.login%type
IS
    v_login Student.login%type;
BEGIN
    SELECT LOWER(SUBSTR(p_lname, 1, 3)) || LPAD((COUNT(1)+1), 3, '0')
    INTO v_login
    FROM Student;
RETURN v_login;
END FGetLogin;

SELECT FGetLogin(fname, lname)
FROM Student;



CREATE OR REPLACE TRIGGER TStudentAfterInsert
AFTER INSERT
ON Student
FOR EACH ROW
BEGIN
    PPrint('Novy student: ' || :NEW.login || ' jmenem: ' || :NEW.fname || ' ' || :NEW.lname);
END;

