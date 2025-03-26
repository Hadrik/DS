CREATE OR REPLACE PROCEDURE PPrepareTableReward
AS
v_count NUMBER;
v_sql VARCHAR2(1000);
BEGIN

  SELECT COUNT(1)
  INTO v_count
  FROM User_Tables
  WHERE TABLE_NAME = 'REWARD';

  IF v_count = 1 THEN
    EXECUTE IMMEDIATE 'DROP TABLE Reward';
  END IF;

  v_sql := '
  CREATE TABLE REWARD(
    id INTEGER PRIMARY KEY,
    student_login CHAR(6) REFERENCES STUDENT,
    winter_reward INTEGER NULL,
    summer_reward INTEGER NULL,
    thesis_reward INTEGER NULL
  )
  ';
  EXECUTE IMMEDIATE v_sql;

END;

EXECUTE PPREPARETABLEREWARD();



CREATE OR REPLACE PROCEDURE PSetStudentReward(
  p_login IN STUDENT.LOGIN%TYPE,
  p_reward_type IN VARCHAR2,
  p_reward IN INTEGER
)
AS
v_id INTEGER;
v_sql VARCHAR2(1000);
BEGIN

  SELECT COALESCE(MAX(ID), 0) + 1
  INTO v_id
  FROM REWARD;

  v_sql := '
  INSERT INTO REWARD(
    ID,
    STUDENT_LOGIN,
    ' || p_reward_type || '_REWARD
  ) VALUES (
    :v1,
    :v2,
    :v3
  )
  ';

  PPRINT(v_sql);
  EXECUTE IMMEDIATE v_sql USING v_id, p_login, p_reward;

END;

EXECUTE PSETSTUDENTREWARD('smi324', 'summer', 1000)


CREATE OR REPLACE PROCEDURE PUpdateGradeStatic(
  p_grade IN Student.grade%TYPE,
  p_fname IN Student.fname%TYPE,
  p_lname IN Student.lname%TYPE
)
AS
BEGIN
  UPDATE STUDENT
  SET GRADE = p_grade
  WHERE
    FNAME = p_fname AND
    LNAME = p_lname;
END;

EXECUTE PUPDATEGRADESTATIC(3, 'Mary', 'Smith')



CREATE OR REPLACE PROCEDURE PUpdateGradeDynamic(
  p_grade IN Student.grade%TYPE,
  p_fname IN Student.fname%TYPE,
  p_lname IN Student.lname%TYPE
)
AS
v_sql VARCHAR2(1000);
BEGIN
  v_sql := '
  UPDATE STUDENT
  SET GRADE = :1
  WHERE 1=1 ';

  IF NOT p_fname IS NULL THEN
    v_sql := v_sql || 'AND FNAME = ''' || p_fname || '''';
  END IF;

  IF NOT p_lname IS NULL THEN
    v_sql := v_sql || 'AND LNAME = ''' || p_lname || '''';
  END IF;

  EXECUTE IMMEDIATE v_sql USING p_grade;

END;



CREATE OR REPLACE PROCEDURE PUpdateGrade(
  p_grade IN Student.grade%TYPE,
  p_fname IN Student.fname%TYPE,
  p_lname IN Student.lname%TYPE,
  p_type IN VARCHAR2
)
AS
v_sql VARCHAR2(100);
BEGIN
  v_sql := '
  BEGIN
  PUpdateGrade' || p_type || '(:1, :2, :3);
  END;
  ';
  EXECUTE IMMEDIATE v_sql USING p_grade, p_fname, p_lname;
END;



CREATE OR REPLACE FUNCTION FRowCount(
  p_tableName IN VARCHAR
)
RETURN INTEGER
AS
v_sql VARCHAR2(1000);
v_count INTEGER;
BEGIN

  v_sql := 'SELECT COUNT(1) FROM ' || p_tableName;
  EXECUTE IMMEDIATE v_sql INTO v_count;
  RETURN v_count;

END;
