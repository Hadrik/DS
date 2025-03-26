CREATE OR REPLACE PROCEDURE PAddStudentToCourse
(
  p_student_login Student.Login%TYPE,
  p_course_code Course.Code%TYPE,
  p_year StudentCourse.Year%TYPE
)
IS
v_capacity NUMBER;
v_count NUMBER;
BEGIN
  SELECT c.CAPACITY
  INTO v_capacity
  FROM Course c
  WHERE c.CODE = p_course_code;

  SELECT COUNT(1)
  INTO v_count
  FROM StudentCourse sc
  WHERE sc.COURSE_CODE = p_course_code
  AND sc.YEAR = p_year;

  IF v_capacity <= v_count THEN
    PPRINT('Kurz je jiz plne obsazen');
  ELSE
    INSERT INTO STUDENTCOURSE
    (
      STUDENT_LOGIN,
      COURSE_CODE,
      YEAR
    ) VALUES (
      p_student_login,
      p_course_code,
      p_year
    );
  END IF;
END;

EXECUTE PADDSTUDENTTOCOURSE('wil1986', '460-ds1-011', 2020);


CREATE OR REPLACE TRIGGER TInsertStudentCourse BEFORE INSERT
ON StudentCourse
FOR EACH ROW
DECLARE
  v_count NUMBER;
  v_capacity NUMBER;
  e_full_capacity EXCEPTION;
BEGIN
  SELECT c.CAPACITY
  INTO v_capacity
  FROM Course c
  WHERE c.CODE = :NEW.COURSE_CODE;

  SELECT COUNT(1)
  INTO v_count
  FROM StudentCourse sc
  WHERE sc.COURSE_CODE = :NEW.COURSE_CODE
  AND sc.YEAR = :NEW.YEAR;

  IF v_capacity <= v_count THEN
    PPRINT('Kapacita kurzu byla prekrocena');
    RAISE e_full_capacity;
  END IF;
END;


CREATE OR REPLACE FUNCTION FAddStudent4
(
  p_fname Student.fname%TYPE,
  p_lname Student.lname%TYPE,
  p_email Student.email%TYPE,
  p_grade Student.grade%TYPE,
  p_dateOfBirth Student.date_of_birth%TYPE
)
RETURN VARCHAR AS
  v_login Student.login%TYPE;
  v_limit NUMBER;
  v_count NUMBER;
BEGIN
  v_login := FGetLogin(p_lname);
  
  IF p_grade = 1 THEN
    v_limit := 20;
  ELSIF p_grade = 2 THEN
    v_limit := 15;
  ELSE
    v_limit := 10;
  END IF;

  SELECT COUNT(1)
  INTO V_count
  FROM Student
  WHERE GRADE = p_grade;

  IF v_count >= v_limit THEN
    RETURN 'FULL';
  END IF;
  
  INSERT INTO Student (login, fname, lname, email, grade, date_of_birth)
  VALUES (v_login, p_fname, p_lname, p_email, p_grade, p_dateOfBirth);

  RETURN v_login;
    
EXCEPTION
  WHEN OTHERS THEN
    RETURN 'error';
END;


CREATE OR REPLACE PROCEDURE PDeleteTeacher
(
  p_login IN Teacher.login%TYPE
)
AS
  v_course_count NUMBER;
  v_target_teacher Teacher.LOGIN%TYPE;
BEGIN
  SELECT COUNT(1)
  INTO v_course_count
  FROM COURSE
  WHERE TEACHER_LOGIN = p_login;

  IF v_course_count > 0 THEN
    SELECT T.LOGIN
    INTO v_target_teacher
    FROM TEACHER T
    LEFT OUTER JOIN COURSE C ON C.TEACHER_LOGIN = T.LOGIN
    WHERE T.LOGIN <> p_login
    GROUP BY T.LOGIN
    ORDER BY COUNT(C.CODE)
    FETCH FIRST 1 ROWS ONLY;

    UPDATE COURSE
    SET TEACHER_LOGIN = v_target_teacher
    WHERE TEACHER_LOGIN = p_login;
  END IF;

  DELETE FROM TEACHER
  WHERE LOGIN = p_login;
END;


CREATE OR REPLACE FUNCTION FLoginExists
(
  p_login IN Student.login%Type
)
RETURN BOOLEAN
AS
  v_count NUMBER;
BEGIN
  SELECT COUNT(1)
  INTO v_count
  FROM STUDENT
  WHERE LOGIN = p_login;

  IF v_count = 0 THEN
    RETURN FALSE;
  ELSE 
    RETURN TRUE;
  END IF;
END;
