USE practice_sql;

CREATE TABLE sale (
	SEQUENCE_number INT PRIMARY KEY AUTO_INCREMENT,
	date DATE,
	amount int,
	employee_number INT
);


INSERT INTO sale (date, amount, employee_number) VALUES ('2024-07-01',100000,1);
INSERT INTO sale (date, amount, employee_number) VALUES ('2024-07-01',120000,2);
INSERT INTO sale (date, amount, employee_number) VALUES ('2024-07-01',60000,1);
INSERT INTO sale (date, amount, employee_number) VALUES ('2024-07-03',200000,1);
INSERT INTO sale (date, amount, employee_number) VALUES ('2024-07-03',170000,3);
INSERT INTO sale (date, amount, employee_number) VALUES ('2024-07-06',100000,3);
INSERT INTO sale (date, amount, employee_number) VALUES ('2024-07-06',160000,1);
INSERT INTO sale (date, amount, employee_number) VALUES ('2024-07-07',80000,1);
INSERT INTO sale (date, amount, employee_number) VALUES ('2024-07-08',90000,1);
INSERT INTO sale (date, amount, employee_number) VALUES ('2024-07-08',110000,3);

-- 집계 함수 : 여러 행의 레코드를 종합하여 하나의 결과값을 반환

-- count(): 특정 조건에 해당하는 레코드의 개수를 반환
SELECT  COUNT(*) FROM sale; 
SELECT COUNT(*) FROM sale WHERE amount <= 100000;
SELECT  COUNT(amount) FROM sale;
-- SUM() : 특정 조건에 해당하는 컬럼의 값을 모두 더한 결과를 반환
SELECT SUM(amount) FROM sale;
SELECT SUM(amount) FROM sale WHERE employee_number = 1;
-- AVG() : 특정 조건에 해당하는 컬럼의 값의 평균울 반환
SELECT AVG(amount) FROM sale;
SELECT AVG(amount) FROM sale WHERE employee_number = 1;

-- MAX, MIN : 특정 조건에 해당하는 컬럼 값의 최대 최소 값을 반환
SELECT MAX(amount), MIN(amount) FROM sale;

-- GROUP BY (그룹화) : 조회 결과에 대해 레코드를 하나 이상의 컬럼으로 그룹화하여 결과를 도출하는 것
-- 일반적으로 집계함수와 함께 사용됨
SELECT AVG(amount) FROM sale
GROUP BY employee_number ;
-- 집계함수가 포함되어 있는 쿼리 혹은 그룹화가 되어있는 쿼리에서는 
SELECT AVG(amount), date FROM sale
GROUP BY employee_number;


SELECT AVG(amount), employee_number, date FROM sale GROUP BY employee_number ,date ;

-- 필터링 (HAVING) : 그룹화된 결과에 필터 작업을 수행
-- 주의!!! WHERE 절과 사용방법이 비슷하지만 WHERE절은 조회할때 사용되고 HAVING절은 조회결과에 사용이 됩니다.

SELECT  AVG(amount) '평균', employee_number '사번' FROM sale 
GROUP BY employee_number
HAVING AVG(amount) <= 1000000;
-- HAVING 평균 <= 1000000;

-- 그룹 바이 절에 존재하지 않는 컬럼은 해빙 절에서 사용할수 없다
SELECT  AVG(amount) '평균', employee_number '사번' FROM sale 
WHERE date < '2024-07-05'
GROUP BY employee_number
HAVING AVG(amount) <= 1000000;


