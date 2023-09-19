-- ��� ���� ��Ű��
DROP TABLE grade CASCADE CONSTRAINTS;
drop sequence grade_seq;

CREATE TABLE grade(
    gradeNo NUMBER(2) PRIMARY KEY,
    gradeName VARCHAR2(21) not null
);



--ȸ�� ���� ��Ű��

drop table member CASCADE CONSTRAINTS;
drop sequence member_seq;

create table member(
    id VARCHAR2(20) PRIMARY KEY,
    pw VARCHAR2(20) not null,
    name VARCHAR2(30) not null,
    gender CHAR(6) CHECK (gender = '����' or gender = '����') not null,
    birth DATE not null,
    tel VARCHAR2(13),
    email VARCHAR2(50) not null,
    regDate DATE DEFAULT sysdate,
    conDate DATE DEFAULT sysdate,
    status CHAR(6) DEFAULT '����' CHECK(status in('����', 'Ż��', '�޸�')),
    gradeNo number(2) DEFAULT 1 REFERENCES grade(gradeNo)
);

-- ���� ī�װ� ��Ű��

drop table category CASCADE CONSTRAINTS;

create table category(
    categoryNo number(2) primary key,
    categoryName varchar2(300) not null
);



-- �����Խ��� ��Ű��

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



-- �������� ��Ű��
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



-- ����� ���� �亯 ��Ű��
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



-- ǰ�� ī�װ� ��Ű��

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


-- ǰ���� Ư�� ��Ű��

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



-- ǰ���� ���� ������ ��Ű��

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
