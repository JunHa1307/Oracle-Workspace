CREATE TABLE SNS_LOGIN (
	USER_NO	NUMBER	NOT NULL REFERENCES MEMBER(USER_NO),
	SNS_ID	VARCHAR2(30)	NOT NULL UNIQUE,
    SNS_NAME VARCHAR2(30) NULL,
	SNS_TYPE	VARCHAR2(1)	NOT NULL,
	PROFILE_IMAGE_NAME	VARCHAR2(300)	NULL,
	FILE_PATH	VARCHAR2(1000)	NULL,
	SNS_ENROLL_DATE	DATE    DEFAULT SYSDATE NOT NULL,
	STATUS	VARCHAR2(1) DEFAULT 'Y' CONSTRAINT STATUS_CHECK55 CHECK(STATUS IN ('Y','N')) NOT NULL
);

ALTER TABLE SNS_LOGIN ADD CONSTRAINT PK_SNS_LOGIN PRIMARY KEY (USER_NO);

COMMENT ON TABLE SNS_LOGIN IS '소셜로그인';
COMMENT ON COLUMN SNS_LOGIN.USER_NO IS '회원번호';
COMMENT ON COLUMN SNS_LOGIN.SNS_ID IS '회원아이디';
COMMENT ON COLUMN SNS_LOGIN.SNS_NAME IS '회원이름';
COMMENT ON COLUMN SNS_LOGIN.SNS_TYPE IS 'SNS타입(1:kakao,2:naver,3:google)';
COMMENT ON COLUMN SNS_LOGIN.PROFILE_IMAGE_NAME IS '프로필사진명';
COMMENT ON COLUMN SNS_LOGIN.FILE_PATH IS '저장폴더경로';
COMMENT ON COLUMN SNS_LOGIN.SNS_ENROLL_DATE IS '가입날짜';
COMMENT ON COLUMN SNS_LOGIN.STATUS IS '상태값(Y/N)';