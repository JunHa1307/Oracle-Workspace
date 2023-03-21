-- 선언순서 : 시퀀스는 DROP 순서대로 , 테이블은 DROP 역순
DROP SEQUENCE SEQ_INO; -- CHOICE_OPTION 테이블 ITEM_NO
DROP SEQUENCE SEQ_MNO; -- MEMBER 테이블 USER_NO
DROP SEQUENCE SEQ_CNO; -- CLASS 테이블 CLASS_NO
DROP SEQUENCE SEQ_BNO; -- BOARD 테이블 BOARD_NO
DROP SEQUENCE SEQ_ANO; -- ATTACHMENT 테이블 FILE_NO
DROP SEQUENCE SEQ_RNO; -- REPLY 테이블 REPLY_NO
DROP SEQUENCE SEQ_SNO; -- SERVEY 테이블 SERVEY_NO
DROP SEQUENCE SEQ_QNO; -- QUESTION 테이블 QUES_NO
DROP SEQUENCE SEQ_TNO; -- TIME_TABLE 테이블 TIME_TABLE_NO

DROP TABLE ANSWER; -- 답안
DROP TABLE CHOICE_OPTION; -- 객관식 항목
DROP TABLE QUESTION; -- 질문
DROP TABLE SURVEY; -- 설문 *
DROP TABLE BOOKMARK; -- 스크랩
DROP TABLE NOTICE; -- 알림장
DROP TABLE REPLY; -- 댓글
DROP TABLE ATTACHMENT; -- 첨부파일
DROP TABLE BOARD; -- 게시판 *
DROP TABLE ATTAND_CHECK; -- 출석체크
DROP TABLE CLASS_MEMBER; -- 클래스 회원
DROP TABLE MEMBER; -- 회원 *
DROP TABLE SCHEDULE; -- 일정표
DROP TABLE TIME_TABLE_ITEM; -- 시간표항목
DROP TABLE TIME_TABLE; --학급시간표
DROP TABLE LUNCH; -- 급식표
DROP TABLE CLASS; -- 클래스 *

CREATE SEQUENCE SEQ_INO
START WITH 1
INCREMENT BY 1
MAXVALUE 999999999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_MNO
START WITH 1
INCREMENT BY 1
MAXVALUE 999999999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_CNO
START WITH 1
INCREMENT BY 1
MAXVALUE 999999999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_BNO
START WITH 1
INCREMENT BY 1
MAXVALUE 999999999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_ANO
START WITH 1
INCREMENT BY 1
MAXVALUE 999999999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_RNO
START WITH 1
INCREMENT BY 1
MAXVALUE 999999999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_SNO
START WITH 1
INCREMENT BY 1
MAXVALUE 999999999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_QNO
START WITH 1
INCREMENT BY 1
MAXVALUE 999999999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_TNO
START WITH 1
INCREMENT BY 1
MAXVALUE 999999999999999
NOCACHE
NOCYCLE;

CREATE TABLE CLASS (
	CLASS_NO	NUMBER	NOT NULL CONSTRAINT PK_CLASS PRIMARY KEY,
	CLASS_GRADE	NUMBER	NOT NULL,
	CLASS_CODE	NUMBER  UNIQUE	NULL,
	CLASS_NAME	VARCHAR2(60)	DEFAULT '클래스 이름이 없습니다.'	NOT NULL,
	CLASS_TYPE_NAME	VARCHAR2(60)	DEFAULT '학급 이름이 없습니다.'	NOT NULL
);

COMMENT ON TABLE CLASS IS '클래스';
COMMENT ON COLUMN CLASS.CLASS_NO IS '클래스번호';
COMMENT ON COLUMN CLASS.CLASS_GRADE IS '학년';
COMMENT ON COLUMN CLASS.CLASS_CODE IS '초대코드';
COMMENT ON COLUMN CLASS.CLASS_NAME IS '클래스 이름';
COMMENT ON COLUMN CLASS.CLASS_TYPE_NAME IS '학교/학원 이름';

CREATE TABLE LUNCH (
	LUNCH_NO	NUMBER	NOT NULL CONSTRAINT PK_LUNCH PRIMARY KEY,
	L_DATE	DATE	NOT NULL,
	L_MENU	VARCHAR2(600)	NOT NULL,
	REF_CNO	NUMBER	NOT NULL,
    CONSTRAINT FK_CLASS_TO_LUNCH_1 FOREIGN KEY (REF_CNO) REFERENCES CLASS (CLASS_NO)
);

COMMENT ON TABLE LUNCH IS '급식표';
COMMENT ON COLUMN LUNCH.LUNCH_NO IS '급식번호';
COMMENT ON COLUMN LUNCH.L_DATE IS '날짜';
COMMENT ON COLUMN LUNCH.L_MENU IS '메뉴';
COMMENT ON COLUMN LUNCH.REF_CNO IS '클래스번호';

CREATE TABLE TIME_TABLE (
	TIME_TABLE_NO	NUMBER	NOT NULL CONSTRAINT PK_TIME_TABLE PRIMARY KEY,
	REF_CNO	NUMBER	NOT NULL,
    CONSTRAINT FK_CLASS_TO_TIME_TABLE_1 FOREIGN KEY (REF_CNO) REFERENCES CLASS (CLASS_NO)
);

COMMENT ON TABLE TIME_TABLE IS '시간표';
COMMENT ON COLUMN TIME_TABLE.TIME_TABLE_NO IS '시간표번호';
COMMENT ON COLUMN TIME_TABLE.REF_CNO IS '클래스번호';

CREATE TABLE TIME_TABLE_ITEM (
	REF_TNO	NUMBER	NOT NULL,
	ITEM_NO	NUMBER	NOT NULL,
	ITEM_TITLE	VARCHAR2(60)	NULL,
	ITEM_CONTENT	VARCHAR2(60)	NULL,
	ITEM_TIME	VARCHAR2(100)	NULL,
    CONSTRAINT FK_TIME_TABLE_TO_ITEM_1 FOREIGN KEY (REF_TNO) REFERENCES TIME_TABLE (TIME_TABLE_NO)
);

COMMENT ON TABLE TIME_TABLE_ITEM IS '시간표항목';
COMMENT ON COLUMN TIME_TABLE_ITEM.REF_TNO IS '시간표번호';
COMMENT ON COLUMN TIME_TABLE_ITEM.ITEM_NO IS '항목번호';
COMMENT ON COLUMN TIME_TABLE_ITEM.ITEM_TITLE IS '제목';
COMMENT ON COLUMN TIME_TABLE_ITEM.ITEM_CONTENT IS '내용';
COMMENT ON COLUMN TIME_TABLE_ITEM.ITEM_TIME IS '시간';


CREATE TABLE SCHEDULE (
	SCHEDULE_NO	NUMBER	NOT NULL CONSTRAINT PK_SCHEDULE PRIMARY KEY,
	S_DATE	DATE	NOT NULL,
	S_CONTENT	VARCHAR2(300)	NOT NULL,
	REF_CNO	NUMBER	NOT NULL,
    CONSTRAINT FK_CLASS_TO_SCHEDULE_1 FOREIGN KEY (REF_CNO) REFERENCES CLASS (CLASS_NO)
);

COMMENT ON TABLE SCHEDULE IS '학급일정표';
COMMENT ON COLUMN SCHEDULE.SCHEDULE_NO IS '일정번호';
COMMENT ON COLUMN SCHEDULE.S_DATE IS '날짜';
COMMENT ON COLUMN SCHEDULE.S_CONTENT IS '내용';
COMMENT ON COLUMN SCHEDULE.REF_CNO IS '클래스번호';

CREATE TABLE MEMBER (
	USER_NO	NUMBER	NOT NULL CONSTRAINT PK_MEMBER PRIMARY KEY,
	USER_ID	VARCHAR2(30)    UNIQUE	NOT NULL,
	USER_PWD	VARCHAR2(300)	NOT NULL,
	USER_NAME	VARCHAR2(30)	NOT NULL,
	PHONE	VARCHAR2(20)	NULL,
	ADDRESS	VARCHAR2(100)	NULL,
	ENROLL_DATE	DATE	DEFAULT SYSDATE	NOT NULL,
	MODIFY_DATE	DATE	DEFAULT SYSDATE	NOT NULL,
	STATUS	VARCHAR2(1) DEFAULT 'Y' CONSTRAINT STATUS_CHECK1 CHECK(STATUS IN ('Y','N')) NOT NULL,
	CHILDREN_NAME	VARCHAR2(30)	NULL,
	USER_LEVEL	NUMBER  CONSTRAINT USER_LEVEL_CHECK1 CHECK(USER_LEVEL IN (1,2,3))	NOT NULL
);

COMMENT ON TABLE MEMBER IS '회원';
COMMENT ON COLUMN MEMBER.USER_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.USER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.USER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.USER_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.ADDRESS IS '주소';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '가입날짜';
COMMENT ON COLUMN MEMBER.MODIFY_DATE IS '정보수정일';
COMMENT ON COLUMN MEMBER.STATUS IS '상태값(Y/N)';
COMMENT ON COLUMN MEMBER.CHILDREN_NAME IS '자녀이름';
COMMENT ON COLUMN MEMBER.USER_LEVEL IS '레벨(1:선,2:부,3:학)';

CREATE TABLE CLASS_MEMBER (
	REF_CNO	NUMBER	NOT NULL,
	REF_UNO	NUMBER	NOT NULL,
	STUDENT_NO	NUMBER	NULL,
    CONSTRAINT FK_CLASS_TO_CLASS_MEMBER_1 FOREIGN KEY (REF_CNO) REFERENCES CLASS (CLASS_NO),
    CONSTRAINT FK_MEMBER_TO_CLASS_MEMBER_1 FOREIGN KEY (REF_UNO) REFERENCES MEMBER (USER_NO)
);

COMMENT ON TABLE CLASS_MEMBER IS '클래스회원';
COMMENT ON COLUMN CLASS_MEMBER.REF_CNO IS '클래스번호';
COMMENT ON COLUMN CLASS_MEMBER.REF_UNO IS '회원번호';
COMMENT ON COLUMN CLASS_MEMBER.STUDENT_NO IS '학생 반 번호';

CREATE TABLE ATTAND_CHECK (
	REF_UNO	NUMBER	NOT NULL,
	STATUS	NUMBER  CONSTRAINT ATTAND_STATUS_CHECK1 CHECK(STATUS IN (1,2,3))	NULL,
	A_DATE	DATE	NULL,
	REF_CNO	NUMBER	NOT NULL,
    CONSTRAINT FK_MEMBER_TO_ATTAND_CHECK_1 FOREIGN KEY (REF_UNO) REFERENCES MEMBER (USER_NO),
    CONSTRAINT FK_CLASS_TO_ATTAND_CHECK_1 FOREIGN KEY (REF_CNO) REFERENCES CLASS (CLASS_NO)
);

COMMENT ON TABLE ATTAND_CHECK IS '출석체크';
COMMENT ON COLUMN ATTAND_CHECK.REF_UNO IS '회원번호';
COMMENT ON COLUMN ATTAND_CHECK.STATUS IS '출석 상태(1:출석, 2:결석, 3:지각)';
COMMENT ON COLUMN ATTAND_CHECK.A_DATE IS '날짜';
COMMENT ON COLUMN ATTAND_CHECK.REF_CNO IS '클래스번호';

CREATE TABLE BOARD (
	BOARD_NO	NUMBER 	NOT NULL CONSTRAINT PK_BOARD PRIMARY KEY,
	BOARD_TYPE	NUMBER	NOT NULL CONSTRAINT BOARD_TYPE_CHECK1 CHECK(BOARD_TYPE IN (1,2,3,4,5)),
	REF_UNO	NUMBER	NOT NULL,
	BOARD_TITLE	VARCHAR2(60)	NOT NULL,
	BOARD_CONTENT	VARCHAR2(3000)	NOT NULL,
	BOARD_COUNT	NUMBER	NULL,
	LIKES	NUMBER	DEFAULT 0	NULL,
	CREATE_DATE	DATE	DEFAULT SYSDATE	NOT NULL,
	STATUS	VARCHAR2(1)	DEFAULT 'Y' CONSTRAINT STATUS_CHECK3 CHECK(STATUS IN ('Y','N'))	NOT NULL,
	SECRET_STATUS	VARCHAR2(1)	DEFAULT 'N' CONSTRAINT SECRET_STATUS_CHECK1 CHECK(SECRET_STATUS IN ('Y','N'))	NOT NULL,
	REF_CNO	NUMBER	NOT NULL,
    CONSTRAINT FK_MEMBER_TO_BOARD_1 FOREIGN KEY (REF_UNO) REFERENCES MEMBER (USER_NO),
    CONSTRAINT FK_CLASS_TO_BOARD_1 FOREIGN KEY (REF_CNO) REFERENCES CLASS (CLASS_NO)
);

COMMENT ON TABLE BOARD IS '게시판';
COMMENT ON COLUMN BOARD.BOARD_NO IS '게시글번호';
COMMENT ON COLUMN BOARD.BOARD_TYPE IS '게시글타입(1~5)';
COMMENT ON COLUMN BOARD.REF_UNO IS '회원번호';
COMMENT ON COLUMN BOARD.BOARD_TITLE IS '게시글제목';
COMMENT ON COLUMN BOARD.BOARD_CONTENT IS '게시글내용';
COMMENT ON COLUMN BOARD.BOARD_COUNT IS '조회수';
COMMENT ON COLUMN BOARD.LIKES IS '좋아요수';
COMMENT ON COLUMN BOARD.CREATE_DATE IS '작성일';
COMMENT ON COLUMN BOARD.STATUS IS '상태값(Y/N)삭제';
COMMENT ON COLUMN BOARD.SECRET_STATUS IS '비밀글상태(Y/N)(선생님만)';
COMMENT ON COLUMN BOARD.REF_CNO IS '클래스번호';


CREATE TABLE ATTACHMENT (
	FILE_NO	NUMBER	NOT NULL CONSTRAINT PK_ATTACHMENT PRIMARY KEY,
	REF_BNO	NUMBER	NOT NULL,
	ORIGIN_NAME	VARCHAR2(300)	NOT NULL,
	CHANGE_NAME	VARCHAR2(300)   UNIQUE	NOT NULL,
	FILE_PATH	VARCHAR2(1000)	NOT NULL,
	UPLOAD_DATE	DATE	DEFAULT SYSDATE	NOT NULL,
	FILE_LEVEL	NUMBER  CONSTRAINT FILE_LEVEL_CHECK1 CHECK(FILE_LEVEL IN (1,2))	NULL,
    CONSTRAINT FK_BOARD_TO_ATTACHMENT_1 FOREIGN KEY (REF_BNO) REFERENCES BOARD (BOARD_NO)
);

COMMENT ON TABLE ATTACHMENT IS '파일';
COMMENT ON COLUMN ATTACHMENT.FILE_NO IS '파일번호';
COMMENT ON COLUMN ATTACHMENT.REF_BNO IS '게시글번호';
COMMENT ON COLUMN ATTACHMENT.ORIGIN_NAME IS '파일원본명';
COMMENT ON COLUMN ATTACHMENT.CHANGE_NAME IS '파일수정명';
COMMENT ON COLUMN ATTACHMENT.FILE_PATH IS '저장폴더경로';
COMMENT ON COLUMN ATTACHMENT.UPLOAD_DATE IS '업로드일';
COMMENT ON COLUMN ATTACHMENT.FILE_LEVEL IS '파일레벨(1:메인사진/2:사이드사진)';

CREATE TABLE REPLY (
	REPLY_NO	NUMBER	NOT NULL CONSTRAINT PK_REPLY PRIMARY KEY,
	REF_BNO	NUMBER	NOT NULL,
	REPLY_WRITER	NUMBER	NOT NULL,
	REPLY_CONTENT	VARCHAR2(500)	NOT NULL,
	CREATE_DATE	DATE	DEFAULT SYSDATE	NOT NULL,
	STATUS	VARCHAR2(1)	DEFAULT 'Y' CONSTRAINT STATUS_CHECK4 CHECK(STATUS IN ('Y','N'))	NULL,
	REPLY_SECRET	VARCHAR2(1)	DEFAULT 'N' CONSTRAINT REPLY_SECRET_CHECK1 CHECK(REPLY_SECRET IN ('Y','N'))	NULL,
    CONSTRAINT FK_BOARD_TO_REPLY_1 FOREIGN KEY (REF_BNO) REFERENCES BOARD (BOARD_NO)
);

COMMENT ON TABLE REPLY IS '댓글';
COMMENT ON COLUMN REPLY.REPLY_NO IS '댓글번호';
COMMENT ON COLUMN REPLY.REF_BNO IS '참조게시글번호';
COMMENT ON COLUMN REPLY.REPLY_WRITER IS '작성자회원번호';
COMMENT ON COLUMN REPLY.REPLY_CONTENT IS '댓글내용';
COMMENT ON COLUMN REPLY.CREATE_DATE IS '작성일';
COMMENT ON COLUMN REPLY.STATUS IS '삭제여부(Y/N)';
COMMENT ON COLUMN REPLY.REPLY_SECRET IS '비밀댓글여부(Y/N)';

CREATE TABLE NOTICE (
	REF_BNO	NUMBER	NOT NULL,
	REF_UNO	NUMBER	NOT NULL,
	READ_STATUS	VARCHAR2(1)	DEFAULT 'N' CONSTRAINT READ_STATUS_CHECK1 CHECK(READ_STATUS IN ('Y','N'))	NOT NULL,
    CONSTRAINT FK_BOARD_TO_NOTICE_1 FOREIGN KEY (REF_BNO) REFERENCES BOARD (BOARD_NO),
    CONSTRAINT FK_MEMBER_TO_NOTICE_1 FOREIGN KEY (REF_UNO) REFERENCES MEMBER (USER_NO)
);

COMMENT ON TABLE NOTICE IS '알림장';
COMMENT ON COLUMN NOTICE.REF_BNO IS '게시글번호';
COMMENT ON COLUMN NOTICE.REF_UNO IS '회원번호';
COMMENT ON COLUMN NOTICE.READ_STATUS IS '읽음상태(읽음:Y/N)';

CREATE TABLE BOOKMARK (
	REF_UNO	NUMBER	NOT NULL,
	REF_BNO	NUMBER	NOT NULL,
	BOARD_TYPE	NUMBER  CONSTRAINT BOARD_TYPE_CHECK2 CHECK(BOARD_TYPE IN (1,2,3,4,5))	NOT NULL,
    CONSTRAINT FK_BOARD_TO_BOOKMARK_1 FOREIGN KEY (REF_BNO) REFERENCES BOARD (BOARD_NO),
    CONSTRAINT FK_MEMBER_TO_BOOKMARK_1 FOREIGN KEY (REF_UNO) REFERENCES MEMBER (USER_NO)
);

COMMENT ON TABLE BOOKMARK IS '스크랩';
COMMENT ON COLUMN BOOKMARK.REF_UNO IS '회원번호';
COMMENT ON COLUMN BOOKMARK.REF_BNO IS '게시글번호';
COMMENT ON COLUMN BOOKMARK.BOARD_TYPE IS '게시글타입(1~5)';

CREATE TABLE SURVEY (
	SURVEY_NO	NUMBER	NOT NULL CONSTRAINT PK_SURVEY PRIMARY KEY,
	TITLE	VARCHAR2(60)	NOT NULL,
	SURVEY_COUNT	NUMBER	DEFAULT 0   CONSTRAINT SURVEY_COUNT_CHECK1 CHECK(SURVEY_COUNT IN (1,2))	NULL,
	FIRST_DATE	DATE	NULL,
	LAST_DATE	DATE	NULL,
	STATUS	VARCHAR2(1)	DEFAULT 'Y' CONSTRAINT STATUS_CHECK2 CHECK(STATUS IN ('Y','N'))	NOT NULL,
	REF_CNO	NUMBER	NOT NULL,
    CONSTRAINT FK_CLASS_TO_SURVEY_1 FOREIGN KEY (REF_CNO) REFERENCES CLASS (CLASS_NO)
);

COMMENT ON TABLE SURVEY IS '설문';
COMMENT ON COLUMN SURVEY.SURVEY_NO IS '설문조사번호';
COMMENT ON COLUMN SURVEY.TITLE IS '제목';
COMMENT ON COLUMN SURVEY.SURVEY_COUNT IS '응답 인원수';
COMMENT ON COLUMN SURVEY.FIRST_DATE IS '시작일';
COMMENT ON COLUMN SURVEY.LAST_DATE IS '종료일';
COMMENT ON COLUMN SURVEY.STATUS IS '종료여부("Y"/"N")';
COMMENT ON COLUMN SURVEY.REF_CNO IS '클래스번호';

CREATE TABLE QUESTION (
	QUES_NO	NUMBER	NOT NULL CONSTRAINT PK_QUESTION PRIMARY KEY,
	REF_SNO	NUMBER	NOT NULL,
	QUES_TYPE	NUMBER	DEFAULT 1   CONSTRAINT QUES_TYPE_CHECK1 CHECK(QUES_TYPE IN (1,2))	NOT NULL,
    QUES_TITLE VARCHAR2(60) NULL,
    QUES_CONTENT VARCHAR2(500) NULL,
    CONSTRAINT FK_SURVEY_TO_QUESTION_1 FOREIGN KEY (REF_SNO) REFERENCES SURVEY (SURVEY_NO)
);

COMMENT ON TABLE QUESTION IS '질문';
COMMENT ON COLUMN QUESTION.QUES_NO IS '질문번호';
COMMENT ON COLUMN QUESTION.REF_SNO IS '설문조사번호';
COMMENT ON COLUMN QUESTION.QUES_TYPE IS '질문타입(1:객/2:주)';
COMMENT ON COLUMN QUESTION.QUES_TITLE IS '질문제목';
COMMENT ON COLUMN QUESTION.QUES_CONTENT IS '질문내용';

CREATE TABLE CHOICE_OPTION (
	ITEM_NO	NUMBER	NOT NULL CONSTRAINT PK_CHOICE_OPTION PRIMARY KEY,
	REF_QNO	NUMBER	NOT NULL,
	ITEM_CONTENT	VARCHAR2(100)	NOT NULL,
    CONSTRAINT FK_QUESTION_TO_OPTION_1 FOREIGN KEY (REF_QNO) REFERENCES QUESTION (QUES_NO)
);

COMMENT ON TABLE CHOICE_OPTION IS '객관식항목';
COMMENT ON COLUMN CHOICE_OPTION.ITEM_NO IS '항목번호';
COMMENT ON COLUMN CHOICE_OPTION.REF_QNO IS '질문번호';
COMMENT ON COLUMN CHOICE_OPTION.ITEM_CONTENT IS '항목내용';

CREATE TABLE ANSWER (
	REF_QNO	NUMBER	NOT NULL,
	REF_UNO	NUMBER	NOT NULL,
	SUBMIT_DATE	DATE	DEFAULT SYSDATE	NOT NULL,
	WRITE_ANS	VARCHAR2(1000)	NULL,
    REF_INO NUMBER NULL,
    ITEM_ANS NUMBER NULL,
    CONSTRAINT FK_QUESTION_TO_ANSWER_1 FOREIGN KEY (REF_QNO) REFERENCES QUESTION (QUES_NO),
    CONSTRAINT FK_CHOICE_TO_ANSWER_1 FOREIGN KEY (REF_INO) REFERENCES CHOICE_OPTION (ITEM_NO),
    CONSTRAINT FK_MEMBER_TO_ANSWER_1 FOREIGN KEY (REF_UNO) REFERENCES MEMBER (USER_NO)
);

COMMENT ON TABLE ANSWER IS '답안';
COMMENT ON COLUMN ANSWER.REF_QNO IS '질문번호';
COMMENT ON COLUMN ANSWER.REF_UNO IS '회원번호';
COMMENT ON COLUMN ANSWER.SUBMIT_DATE IS '제출일시';
COMMENT ON COLUMN ANSWER.WRITE_ANS IS '주관식답안';
COMMENT ON COLUMN ANSWER.REF_INO IS '항목번호';
COMMENT ON COLUMN ANSWER.ITEM_ANS IS '항목답안';