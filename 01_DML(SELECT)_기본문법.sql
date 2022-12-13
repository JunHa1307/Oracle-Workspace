-- DML : 데이터 조작, SELECT(DQL), INSERT, UPDATE, DELETE
-- DDL : 데이터 정의, CRATE, ALTER, DROP 
-- TCL : 트랜젝션 제어, COMMIT, ROLLBACK
-- DCL : 권한 부여, GRANT, REVOKE

/*
    <SELECT>
    데이터 를 조회하거나 검색할 때 사용하는 명령어
    -RESULT SET : SELECT 구문을 통해 조회된 데이터의 결과물을 의미
                    즉, 조회된 행들의 모임
                    
    [표현법]
    SELECT 조회하고자 하는 컬럼명, 컬럼명2, 컬럼명3, ...
    FROM 테이블명;
    
*/
-- EMPLOYEE 테이블의 전체 사원들의 사번, 이름, 급여 컬럼만을 조회

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE; -- 모두 대문자로 작성하기

SELECT * 
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 전체 사원들의 이름, 이메일, 휴대폰번호를 조회

SELECT 
    EMP_NAME,
    EMAIL,
    PHONE
FROM EMPLOYEE;

----------------------실습문제---------------------------
----1. JOB 테이블의 모든 컬럼 조회
SELECT *
FROM JOB;
----2. JOB 테이블의 직급명만 조회
SELECT JOB_NAME
FROM JOB;
----3. DEPARTMENT 테이블의 모든 칼럼 조회
SELECT *
FROM DEPARTMENT;
----4. EMPLOY 테이블의 직원명, 이메일, 전화번호, 입사일 칼럼만 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;
----5. EMPLOYEE 테이블의 입사일, 직원명, 급여칼럼만 조회
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

/*
    <컬럼값을 통한 산술연산>
    조회하고자 하는 컬럼들을 나열하는 SELECT절에서 산술연산(+-/*)를 기술해서 결과를 조회할 수 있다.
*/

-- EMPLOYEE 테이블로부터 직원명, 월급, 연봉

SELECT EMP_NAME, SALARY, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE 테이블로부터 직원명과 월급 보너스, 보너스가 포함된 연봉((SALARY + SALARY * BONUS) * 12)
