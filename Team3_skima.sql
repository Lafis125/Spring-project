-- 등급 관리 스키마
DROP TABLE grade CASCADE CONSTRAINTS;
drop sequence grade_seq;

CREATE TABLE grade(
    gradeNo NUMBER(2) PRIMARY KEY,
    gradeName VARCHAR2(21) not null
);



--회원 관리 스키마

drop table member CASCADE CONSTRAINTS;
drop sequence member_seq;

create table member(
    id VARCHAR2(20) PRIMARY KEY,
    pw VARCHAR2(20) not null,
    name VARCHAR2(30) not null,
    gender CHAR(6) CHECK (gender = '남자' or gender = '여자') not null,
    birth DATE not null,
    tel VARCHAR2(13),
    email VARCHAR2(50) not null,
    regDate DATE DEFAULT sysdate,
    conDate DATE DEFAULT sysdate,
    status CHAR(6) DEFAULT '정상' CHECK(status in('정상', '탈퇴', '휴면')),
    gradeNo number(2) DEFAULT 1 REFERENCES grade(gradeNo)
);

-- 동물 카테고리 스키마

drop table category CASCADE CONSTRAINTS;

create table category(
    categoryNo number(2) primary key,
    categoryName varchar2(300) not null
);



-- 설문게시판 스키마

drop table survey CASCADE CONSTRAINTS;
drop SEQUENCE survey_seq;

create table survey(
    surveyNo number primary key,
    categoryNo number null references category(categoryNo)
    on delete set null,
    question varchar2(3000) not null,
    writeDate date default sysdate
);
create sequence survey_seq;



-- 설문진행 스키마
drop table SurveyConduction CASCADE CONSTRAINTS;
drop SEQUENCE SurveyConduction_seq;



create table SurveyConduction(
 SurveyConduction_no number primary key,
 member_id varchar2(20) null REFERENCES member (id)on delete set null,
 Survey_Category_no number null REFERENCES category(categoryNo)on delete set null,
 petresult varchar2(300) default null,
 surveydate date default sysdate
);

create sequence surveyconduction_seq;

commit;



-- 사용자 설문 답변 스키마
drop table userselect CASCADE CONSTRAINTS;
drop SEQUENCE userselect_seq;

CREATE TABLE UserSelect (
    SurveyConduction_no NUMBER null,
    surveyNo NUMBER null,
    result_no NUMBER NOT NULL,
    CONSTRAINT UserSelect_fk_SurveyConduction FOREIGN KEY (SurveyConduction_no) 
    REFERENCES surveyconduction (SurveyConduction_no) on delete set null,
    CONSTRAINT UserSelect_fk_survey FOREIGN KEY (surveyNo)
    REFERENCES survey (surveyNo)on delete set null
);
create sequence userselect_seq;



-- 품종 카테고리 스키마

drop table cultivar CASCADE CONSTRAINTS;
drop SEQUENCE cultivar_seq;

CREATE TABLE cultivar (
    animalNo NUMBER PRIMARY KEY,
    categoryNo NUMBER(2) NOT NULL,
    cultivarName VARCHAR2(300) NOT NULL,
    CONSTRAINT unique_cultivarName UNIQUE (cultivarName),
    info varchar(3000) not null
);


CREATE SEQUENCE cultivar_seq;


-- 품종별 특성 스키마

drop table nature CASCADE CONSTRAINTS;
drop SEQUENCE nature_seq;


create table nature(
    characterNo number primary key,
    categoryNo number null REFERENCES category (categoryNo)
    on delete set null,
    cultivarName varchar2(300) null REFERENCES cultivar (cultivarName)
    on delete set null,
    cultivarChar varchar2(3000) not null,
    cultivarSize varchar2(300) not null,
    cultivarLife varchar2(300) not null,
    writeDate date default sysdate,
    updateDate date default sysdate
);

CREATE SEQUENCE nature_seq;



-- 품종에 따른 정답지 스키마

drop table Breadresult CASCADE CONSTRAINTS;
drop SEQUENCE breadresult_seq;


CREATE TABLE Breadresult (
    animal_no NUMBER PRIMARY KEY,
    animalcategori_no NUMBER null REFERENCES cultivar (animalNo)
    on delete set null,
    animalquestion_no Number null references survey(surveyNo) 
    on delete set null,
    animal_result_no NUMBER DEFAULT 2
);
create sequence breadresult_seq;
