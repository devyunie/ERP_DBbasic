-- 카타르 아이안컵 데이터베이스

-- 참가팀(국) (국가명, 조 ,감독, 피파랭킹)
-- 선수 (이름, 나이 ,포지션, 등번호, 국가)
-- 경기장 (경기장명, 수용인원, 주소)
-- 심판 (이름, 나이, 국적, 포지션, 

-- 1. 카타르 아시안컵 데이터베이스 생성
-- qatar_asian_cup
CREATE DATABASE qatar_asian_cup;
-- 2. 개발자 계정 생성
-- user: qatar_developer / 접근위치 ip: 모든 곳에서 접근 가능 / pw: qatar123 
CREATE USER "qatar_developer"@"%" IDENTIFIED BY "qatar12";

USE qatar_asian_cup;
-- 3.  테이블 생성
-- 3. 참가국 : country (name[가변문자열 30],group_name[가변문자열 5], manager[가면문자열 30], lanking[정수] ) 
CREATE TABLE country (
	name VARCHAR(30),
    group_name VARCHAR(5),
    manager VARCHAR(30),
    lanking INT
);
-- 3.2 선슈:  player(name[가변문자열 30], age[정수] position[가변문자열 10], uniform_number[정수], country [가변문자열 30])
CREATE TABLE player (
	name VARCHAR(30),
    age INT,
    position VARCHAR(10),
    uniform_number INT,
    country VARCHAR(30)
);
-- 3.3 경기장 : stadium (name[가변문자열 50], volume[정수],address[text]
CREATE TABLE stadium(
	name VARCHAR(50),
    volume INT,
    address TEXT
);
-- 3.4 심판 : referee ( name[가변문자열 30], age(정수),country[가변문자열 30], position[가변문자열10)
CREATE TABLE referee (
	name VARCHAR(30),
    age INT,
    country VARCHAR(30),
    position VARCHAR(10)
);

