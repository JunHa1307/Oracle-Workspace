/*
    <PL/SQL>
    PROCEDURE LANGUAGE EXTENSION TO SQL
    
    오라클 자체에 내장되어있는 절차적 언어
    SQL문장 내에서 변수의 정의, 조건처리(IF), 반복문처리(LOOP, FOR, WHILE), 예외처리 등을 지원하여 SQL문 단점을 보완
    다수의 SQL문을 한번에 실행 가능
    
    PL/SQL문의 구조
    -   [선언부(DELACRE SECTION)] : DECLARE로 시작, 변수나 상수를 선언 및 초기화 하는 부분
    -   실행부 (EXECUTABLE SECTION) : BEGIN으로 시작, SQL문 또는 제어문 등의 로직을 기술하는 부분
    -   [예외처리부 (EXCEOPTION SECTION)] : EXCEPTION으로 시작, 예외 발생시 해결하기 위한 구문을 미리 기술하는 부분
*/

--  화면에 HELLO ORACLE 출력해보기
--  1) 서버 아웃풋 옵션을 켜줌
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/ 
--< 마침표로 구분해줘야함

/*
    1. DECLARE 선언부
    변수나 상수를 선언하는 공간(선언과 동시에 초기화도 가능함)
    일반타입 변수, 래퍼런스 변수, ROW타입 변수
    
    1_1) 일반타입변수 선언 및 초기화
    [표현식] 변수명 [CONSTANT(상수인지 아닌지)]자료형 ["=값("= : 오라클식 대입연산자)];
*/
DECLARE 
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    EID := &번호;
    ENAME := '&이름';
    DBMS_OUTPUT.PUT_LINE('EID = ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME = ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI = ' || PI);
END;
/
-- 이게 있어야 블록의 종결로 간주됨. 종결처리 블록 뒤에 주석이 있으면 종결처리가 안됨.

--  1_2) 래퍼런스 타입 변수 선언 및 초기화(어떤 테이블의 어떤 컬럼의 데이터타입을 참조해서 그 타입으로 지정)
--  [표현법]
--  변수명 테이블명.컬럼명%TYPE;
DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    EID := 300;
    ENAME := '경민';
    SAL := 3000000;
    
    --  사원의 사번이 200번인 각 사원의 사번, 사원명, 연봉을 대입
    SELECT EMP_ID, EMP_NAME, SALARY
        INTO EID, ENAME, SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('EID = ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME = ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL = ' || SAL);
END;
/

--------------------------------------------------------------------------------
/*
    래퍼런스타입 변수로 EID, ENAME, JCODE, SAL , DTITLE을 선언하고
    각 자료형 EMPLOYEE(EMP_ID, EMP_NAME, JOB_CODE, SALARY)
    DEPARTMENT(DEPT_TITLE)을 참조하도록
    
    사용자가 입력한 사번인 사원의 사번, 사원명, 직급코드 ,급여, 부서명 조회후 
    변수에 담아서 출력
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
        INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('EID = ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME = ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('JCODE = ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('SAL = ' || SAL);
    DBMS_OUTPUT.PUT_LINE('DTITLE = ' || DTITLE);
END;
/
--------------------------------------------------------------------------------
--  1_3) ROW타입 변수선언
--       테이블의 한 행에 대한 모든 컬럼값을 한꺼번에 담을 수 있는 변수
--  [표현법]
--  변수명 테이블명%ROWTYTPE
DECLARE 
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT * 
    INTO E 
    FROM EMPLOYEE 
    WHERE EMP_ID = &사번;
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('보너스 : ' || NVL(E.BONUS,0)); -- 보너스가 NULL일 경우 빈 값으로 표시됨
    --  NVL함수를 이용해서 0으로 표시해주기
END;
/
--------------------------------------------------------------------------------
--  2. BEGIN 실행부
/*
    <조건문>
    
    1) IF 조건식 THEN 실행내용
    
    사번 입력받은 후 해당 사원의 사원, 이름, 급여, 보너스율(%)를 출력
    단, 보너스를 받지 않는 사원은 보너스를 출력 전 '보너스를 지급받지 않는 사원입니다'를 출력
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
        INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : '||EID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||SALARY);
    
    IF BONUS = 0 
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('보너스율 : ' || BONUS * 100 || '%');
    
END;
/
--  2) IF조건식 THEN 실행내용 ELSE 실행내용 
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
        INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : '||EID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||SALARY);
    
    IF BONUS = 0 
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('보너스율 : ' || BONUS * 100 || '%');
    END IF;

END;
/
--------------------------------------------------------------------------------
--  래퍼런스타입변수 (EID, ENAME, DTITLE, NCODE) , 일반타입변수 TEAM VARCHAR2(10)
--  참조할 칼럼 (EMP_ID, EMP_NAME, DEPT_TITLE, NATIONALCODE)

--  사용자가 입력한 사원의 사번, 이름, 부서명, 근무국가코드 조회 후, 각 변수에 대입

--  NCODE의 값이 KO일 경우 TEAM에 한국팀 대입, 그게 아닐경우 해외팀 대입

--  사번, 이름, 부서, 소속(TEAM) 출력
DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(20);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
        INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = &사번;
    
    IF NCODE = 'KO'
        THEN TEAM := '한국팀';
    ELSE TEAM := '해외팀';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : '|| EID);
    DBMS_OUTPUT.PUT_LINE('이름 : '|| ENAME);
    DBMS_OUTPUT.PUT_LINE('부서 : '|| DTITLE);
    DBMS_OUTPUT.PUT_LINE('소속 : '|| TEAM);
END;
/

--  3) IF 조건식 1 THEN ELSIF 조건식 2 THEN 실행내용
--  급여가 500만원 이상이면 고급
--  급여가 300만원 이상이면 중급
--  그외는 초급
--  출력문 : 해당 사원의 급여등급은 XX입니다.

DECLARE
    SAL EMPLOYEE.SALARY%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    GRADE VARCHAR2(10);
BEGIN
    SELECT SALARY , EMP_NAME
        INTO SAL, ENAME
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    IF SAL >= 5000000
        THEN GRADE := '고급';
    ELSIF SAL >= 3000000
        THEN GRADE := '중급';
    ELSE GRADE := '초급';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(ENAME || '사원의 급여 등급은 ' || GRADE || ' 입니다.');
END;
/