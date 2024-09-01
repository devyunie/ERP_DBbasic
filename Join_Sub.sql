USE practice_sql;

CREATE TABLE employee(
	employee_number INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20),
    age INT,
    department_code VARCHAR(2)
);

CREATE TABLE department (
	department_code VARCHAR(2) PRIMARY KEY,
    name VARCHAR(30),
    tel_number VARCHAR(15)
    
);

ALTER TABLE employee
ADD CONSTRAINT department_code_fk
FOREIGN KEY (department_code)
REFERENCES department(department_code);

ALTER TABLE employee
DROP CONSTRAINT department_code_fk;

INSERT INTO department VALUES ('A','영업부', '123456');
INSERT INTO department VALUES ('B','재무부', '123457');
INSERT INTO department VALUES ('C','행정부', '123458');

INSERT INTO employee (name,age,department_code) VALUES ('홍길동',23,'A');
INSERT INTO employee (name,age,department_code) VALUES ('이영희',15,'A');
INSERT INTO employee (name,age,department_code) VALUES ('고길동',34,'C');
INSERT INTO employee (name,age,department_code) VALUES ('김둘리',20,'D');
INSERT INTO employee (name,age,department_code) VALUES ('이도',17,'D');

SELECT * FROM employee;
SELECT * FROM department;


-- Alias : 쿼리문에서 사용되는 별칭
-- 컬럼 및 테이블에서 사용가능
-- 사용하는 이름을 변경하고 싶을 때 사용;
SELECT department_code AS '부서코드', name AS '부서명', tel_number AS '부서 전화번호' FROM department AS dpt;

-- AS 키워드 생략 가능
SELECT dpt.department_code '부서코드', dpt.name '부서명', dpt.tel_number '부서 전화번호' FROM department dpt;

-- JOIN : 두개 이상의 테이블을 특정 조건에 따라 조합하여 결과를 조회 하고자 할때 사용하는 명령어

-- INNER JOIN : 두 테이블에서 조건이 일치하는 레코드만 반환
-- SELECT column1 , column2 ... FROM 기준테이블 INNER JOIN 조합할 테이블 ON 조인조건
SELECT E.employee_number '사번', E.name '사원이름', E.age '나이', D.department_code '부서코드', D.name '부서명', D.tel_number '부서전화번호' 
FROM employee E INNER JOIN department D ON E.department_code = D.department_code;
-- employee, employee연결할껀데 E.department_code 와 D.department_code 서로 같게 출력해

-- LEFT OUTER JOIN (LEFT JOIN) : 기준 테이블의 모든 레코드와 조합할 테이블 중 조건에 일치하는 레코드만 반환
-- 만약에 조합할 테이블에 조건에 일치하는 레코드가 존재하지 않으면 null로 표현

SELECT E.employee_number '사번', E.name '사원이름', E.age '나이', E.department_code '부서코드', D.name '부서명', D.tel_number '부서전화번호' 
FROM employee E LEFT JOIN department D ON E.department_code = D.department_code;


-- RIGHT OUTER JOIN (RIGHT JOIN) : 조합할 테이블의 모든 레코드와 기존 테이블 중 조건에 일치하는 레코드만 반환
-- 만약에 기준 테이블에 조건에 일치하는 레코드가 존재하지 않으면 null로 표현
SELECT E.employee_number '사번', E.name '사원이름', E.age '나이', D.department_code '부서코드', D.name '부서명', D.tel_number '부서전화번호' 
FROM employee E RIGHT JOIN department D ON E.department_code = D.department_code;

-- FULL OUTER JOIN (FULL JOIN) : 기준 테이블의 모든 레코드와 조합할 모든 레코드를 반환
-- 만약 기준테이블 혹은 조합할 테이블에 조건에 일치하지 않으면 null로 반환
-- MySQL에서는 Full OUTER JOIN을 문법상 제공 X
-- FULL JOIN - LEFT JOIN + RIGHT JOIN
SELECT E.employee_number '사번', E.name '사원이름', E.age '나이', E.department_code '부서코드', D.name '부서명', D.tel_number '부서전화번호' 
FROM employee E LEFT JOIN department D ON E.department_code = D.department_code 
UNION 
SELECT E.employee_number '사번', E.name '사원이름', E.age '나이', D.department_code '부서코드', D.name '부서명', D.tel_number '부서전화번호' 
FROM employee E RIGHT JOIN department D ON E.department_code = D.department_code;

-- CROSS JOIN : 기준 테이블의 각 레코드를 조합할 테이블의 모든 레코드에 조합하여 반환
-- CROSS JOIN 결과 레코드 수 = 기준 테이블 레코드 수 * 조합할 테이블 레코드
SELECT * FROM employee E CROSS JOIN department D ;
-- MySQL에서 기본 조인이 CROSS JOIN형태임
SELECT * FROM employee E JOIN department D;
-- join을 생략하여 크로 조
SELECT * FROM employee E , department D;

-- 부서코드가 A인 사원에 대해
-- 사번, 이름, 부서명을 조회
SELECT E.employee_number '사번', E.name '이름', D.name '부서명'
FROM employee E INNER JOIN department D
ON E.department_code = D.department_code 
WHERE D.department_code='A';

-- 부서명이 '영업부'인 사원에 대해 사번, 이름, 나이를 조회하시오
SELECT E.employee_number, E.name, E.age 
FROM employee E 
INNER JOIN department D
ON E.department_code = D.department_code 
WHERE D.name IN ("영업부");

-- 서브쿼리 : 쿼리 내부에 존재하는 또 다른 쿼리, 쿼리 결과를 조건이나 테이블로 사용할 수 있도록 함
-- WHERE 절에서 서브 쿼리 : 조회 결과를 조건으로 사용하여 조건을 동적으로 지정할 수 있도록 함
-- WHERE 절에서 비교연산 등으로 사용할 때 조회하는 컬럼의 개수 및 레코드의 개수를 주의 해줘야한다.

SELECT employee_number, name ,age FROM employee
WHERE department_code = (SELECT department_code FROM department WHERE name = '영업부');
-- 컬럼 수가 3개니깐 난 뭘 받아야 할지 모르겠다 이말이다.하나만
SELECT employee_number, name ,age FROM employee
WHERE department_code = (SELECT * FROM department WHERE name = '영업부');
-- = 연산이기에 하나의 필드만 존재 해야한다 다수의 필드가 있다면 받아들이지를 못한
SELECT employee_number, name ,age FROM employee
WHERE department_code = (SELECT department_code FROM department);
-- 요건 가능 
SELECT employee_number, name ,age FROM employee
WHERE department_code IN (SELECT department_code FROM department);
-- 대신 요건 불가능 * 전체를 받아들여오니 난 몰라 시
SELECT employee_number, name ,age FROM employee
WHERE department_code IN (SELECT * FROM department);

-- 순서
-- 1번 
SELECT * FROM department;
-- 2번 
SELECT department_code FROM department WHERE name = '영업부';
-- 3
SELECT * FROM employee WHERE department_code = (SELECT department_code FROM department WHERE name = '영업부');
-- 4번 
SELECT employee_number, name, age FROM employee WHERE department_code = (SELECT department_code FROM department WHERE name = '영업부');


-- FROM절에서 서브쿼리 : 조회 결과 테이블에서 다시 FROM을 적어서 재사용
SELECT * FROM department d
WHERE name = '영업부';

-- -------------------------------
SELECT E.employee_number, E.name, E.age 
FROM employee E 
INNER JOIN (
	SELECT * FROM department 
	WHERE name = '영업부'
) D
ON E.department_code = D.department_code;

-- 무조건 별칭을 해줘야 한다 FROM절에서 서브쿼리 사용시 무조건 별칭을 지정해줘야함
SELECT * FROM (SELECT * FROM department ) D
WHERE name = '영업부';



