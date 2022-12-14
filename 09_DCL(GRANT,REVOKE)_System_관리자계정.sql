/*
    DCL : DATE CONTROL LANGUAGE
    데이터를 제어 언어, DB에 대한 보안, 무결성, 복구 등 DBMS를 제어하기 위한 언어
    권한부여 (GRANT , REVOKE_
    
    GRANT : 사용자에게 권한|ROLE권한을 부여하는 명령어
    
    [표현법]
    GRANT 권한|ROLE권한 TO 사용자 계정
*/
DROP USER SAMPLE CASCADE;

CREATE USER SAMPLE2 IDENTIFIED BY SAMPLE2;

--  1. CONNECT => CREATE SESSION
GRANT CONNECT TO SAMPLE2;

--  2. SAMPLE 계정에게 CREATE TABLE 권한 부여
GRANT CREATE TABLE TO SAMPLE2;

--  3. SAMPLE 계정에게 테이블 스페이스 할당
ALTER USER SAMPLE2 QUOTA/*<-테이블 스페이스*/ 2M/*<-2MB*/ ON SYSTEM;
ALTER USER SAMPLE2 QUOTA 2M ON USERS;

--  4. SAMPLE 계정에게 VIEW를 만들 수 있는 권한 부여
GRANT CREATE VIEW TO SAMPLE2;

--  5. SAMPLE 계정에게 KH계정의 테이블중 EMPLOYEE테이블을 조회할 수 있는 권한 추가
GRANT SELECT/*조회권한*/ ON KH.EMPLOYEE TO SAMPLE2;

GRANT SELECT ON KH.DEPARTMENT TO SAMPLE2;

GRANT INSERT ON KH.DEPARTMENT TO SAMPLE2;

--  6. ROLE 권한부여
--  CONNECT : CREATE SESSION
--  RESOURCE : CREATE TABLE, CREATE SEQUENCE, SELECT, INSERT ...

--------------------------------------------------------------------------------

--  REVOKE 권한회수
--  [표현법]
--  REVOKE 권한1,권한2,... FROM 계정명;
--  7. SAMPLE2 계정으로부터 CREATE TABLE 권한을 회수
REVOKE CREATE TABLE FROM SAMPLE2;

