SELECT DEPARTMENT_NO, STUDENT_NAME,ENTRANCE_DATE
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE;

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) ^= 3;

SELECT 
    PROFESSOR_NAME, 
    TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(19 ||SUBSTR(PROFESSOR_SSN,1,6),'RRMMDD'))/12) AS "나이",
    EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(19|| SUBSTR(PROFESSOR_SSN,1,2)) AS 연나이
FROM TB_PROFESSOR
WHERE PROFESSOR_SSN LIKE '_______1%'
ORDER BY 나이;

SELECT LPAD(SUBSTR(PROFESSOR_NAME,2),4,'*') AS "이름"
FROM TB_PROFESSOR;

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN,1,6))) > 19;

SELECT TO_CHAR(TO_DATE('20/12/25'),'DAY')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('99/10/11'),'YY/MM/DD'),
        TO_CHAR(TO_DATE('49/10/11'),'YY/MM/DD'),
        TO_CHAR(TO_DATE('99/10/11'),'RR/MM/DD'),
        TO_CHAR(TO_DATE('49/10/11'),'RR/MM/DD')
FROM DUAL;

SELECT STUDENT_NO,STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

SELECT ROUND(AVG(POINT),1) AS "평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

SELECT DEPARTMENT_NO ,COUNT(DEPARTMENT_NO) AS "학생수(명)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

SELECT (COUNT(*)-COUNT(COACH_PROFESSOR_NO)) AS "COUNT(*)"
FROM TB_STUDENT;

SELECT SUBSTR(TERM_NO,1,4) "년도", ROUND(AVG(POINT),1) AS "년도 별 평점"
FROM TB_GRADE 
WHERE STUDENT_NO = 'A112113'
group by SUBSTR(TERM_NO,1,4);

SELECT DEPARTMENT_NO AS "학과코드명", SUM(DECODE(ABSENCE_YN,'Y',1,'N',0)) AS "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

SELECT STUDENT_NAME "동일이름", COUNT(STUDENT_NAME) "동명인 수"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(STUDENT_NAME) > 1
ORDER BY STUDENT_NAME;

SELECT NVL(SUBSTR(TERM_NO,1,4),' ')"년도",NVL(SUBSTR(TERM_NO,5,6),' ')"학기", ROUND(AVG(POINT),1) AS "평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4),SUBSTR(TERM_NO,5,6));