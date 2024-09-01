USE practice_sql;
-- 거래내역 테이블 
-- 거래번호 정수
-- 거래일자 날짜
-- 거래구분 가변문자열 10
-- 내역 장문의 문자열
-- 금액 정수
-- 세금 정수
-- 비고 장문의 문자열
 CREATE TABLE transaction(
	transaction_number INT,
    transaction_date DATE,
    transaction_type VARCHAR(10),
    breakdown TEXT,
    amount INT,
    tax INT,
    note TEXT
 );
 
INSERT INTO transaction 
VALUES (1, '2024-07-10', '구매', '기타자재', 100000, 0, null);
INSERT INTO transaction 
VALUES (2, '2024-07-10', '판매', '영양제', 700000, 70000, '종합 비타민');
INSERT INTO transaction 
VALUES (3, '2024-07-12', '판매', '영양제', 1200000, 120000, '종합 비타민');
INSERT INTO transaction 
VALUES (4, '2024-07-13', '구매', '책상', 4000000, 0, '4개 구매');
INSERT INTO transaction 
VALUES (5, '2024-07-13', '구매', '노트북', 10000000, 0, '4대 구매');
INSERT INTO transaction 
VALUES (6, '2024-07-17', '판매', '의약외품', 2000000, 200000, '소염진통제');
INSERT INTO transaction 
VALUES (7, '2024-07-18', '구매', '기타자재', 100000, 0, '볼펜 및 노트');
INSERT INTO transaction 
VALUES (8, '2024-07-19', '판매', '의약외품', 1500000, 150000, '소염진통제');
INSERT INTO transaction 
VALUES (9, '2024-07-20', '판매', '의료기구', 8000000, 800000, '휠체어');
INSERT INTO transaction 
VALUES (10, '2024-07-21', '판매', '영양제', 400000, 40000, '오메가3');

-- 연산자

-- 산술 연산자
-- +, -, *, /, % 
SELECT amount + tax , breakdown FROM transaction;

-- 비교연산자 ( WHERE 절에서 자주사용
-- 원하는 레코드를 정확히 조회하는데 중용한 역할을 함
-- = : 좌항이 우항과 같으면 True 반환
SELECT * FROM transaction WHERE transaction_type ='구매';

-- <>, != : 좌항이 우항과 다르면 true 반환
SELECT * FROM transaction WHERE transaction_type <> '구매';
SELECT * FROM transaction WHERE transaction_type !='구매';

-- < : 좌항이 우항보다 작으면 true
-- <= : 좌항이 우항보다 작거나 같으면 true
 SELECT * FROM transaction WHERE amount < 1200000;
 SELECT * FROM transaction WHERE amount <=1200000;
 
 -- > : 좌항이 우항보다 크면 true
 -- >= : 좌항이 우항보다 같으면 true
SELECT * FROM transaction WHERE amount > 1200000;
SELECT * FROM transaction WHERE amount >= 1200000;

ALTER TABLE transaction 
ADD complete BOOLEAN;
UPDATE transaction SET complete = true
WHERE (transaction_number%3) = 1;

UPDATE transaction SET complete = false
WHERE (transaction_Number%3) = 2;

SELECT * FROM transaction;
 
UPDATE transaction SET note = NULL
WHERE transaction_number = 6;
 -- <=> : 좌항과 우항이 모두 null 이면 true 반환
 SELECT * FROM transaction  
 WHERE note <=> complete;
 
 -- IS : 좌항이 우항과 같으면 true (키워드)
 -- IS NOT : 좌항이 우항과 다르면 true (키워드)
 
 SELECT * FROM transaction
 WHERE complete IS TRUE;
 
  SELECT * FROM transaction
 WHERE complete IS NULL;
 
  SELECT * FROM transaction
 WHERE complete IS NOT NULL;
 
 -- BETWEEN a AND b : 좌항이 a보다 크거나 같으면서 b보다 작거나 같으면 true
 -- NOT BETWEEN a AND b : 좌항이 a보다 작거나 b보다 크면 true
 
  SELECT * FROM transaction
 WHERE transaction_date BETWEEN '2024-07-15' AND '2024-07-20';
 
   SELECT * FROM transaction
 WHERE transaction_date NOT BETWEEN '2024-07-15' AND '2024-07-20';
 
 
-- IN() : 주어진 리스트 중에 하나라도 일치하면 true
-- NOT IN() : 주어진 리스트 중에 하나도 일치하지 않으면 true

SELECT * FROM transaction
WHERE breakdown IN('노트북', '책상');

 -- AND (&&) : 좌항과 우항이 모두 같으면 true이면 true
SELECT * FROM transaction
WHERE transaction_type = '판매' AND amount >= 1500000;

-- OR(||) : 좌항과 우항중 하나라도 true이면 true
SELECT * FROM transaction
WHERE transaction_date >= '2024-07-15' OR transaction_type = '판매';

-- XOR : 좌항과 우항이 서로 다르면 true
SELECT * FROM transaction
WHERE transaction_date >= '2024-07-15' XOR transaction_type = '판매';
-- transaction_date >= '2024-07-15' AND transaction_type = '판매'
-- OR
-- transaction_date < '2024-07-15' AND transaction_type = '판매'

-- LIKE : 문자열을 패턴을 기준으로 비교하고자 할때 사용-
-- % : 임의의 개수(0~무한대)의 문자 표현
-- _ : 임의의 한 개 문자 표현
SELECT * FROM transaction
WHERE transaction_date LIKE '2024-07-%';
SELECT * FROM transaction
WHERE transaction_date LIKE '2024-07-_';
SELECT * FROM transaction
WHERE breakdown LIKE '의%';
SELECT * FROM transaction
WHERE transaction_date LIKE '%-10';
SELECT * FROM transaction
WHERE transaction_date LIKE '2024-__-13';

-- 정렬
-- ORDER BY : 조회 결과를 특정 컬럼 기준으로 정렬
-- ASC : 오름차순 정렬
-- DESC : 내림차순 정렬
SELECT * FROM transaction
ORDER BY amount ASC;
SELECT * FROM transaction
ORDER BY amount DESC;

SELECT * FROM transaction
ORDER BY tax, amount DESC;

SELECT * FROM transaction
ORDER BY amount DESC, tax;

-- 중복제거
-- DISTINCT : SELECT 결과 테이블에서 컬럼의 조합의 중복을 제거하여 출력
SELECT DISTINCT breakdown FROM transaction;
SELECT DISTINCT breakdown, amount FROM transaction;

