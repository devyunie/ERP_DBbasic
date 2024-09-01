-- 데이터베이스 생성
-- officetel
CREATE DATABASE officetel;
USE officetel;

-- 이메일 인증 테이블
CREATE TABLE email_auth (
    email VARCHAR(100) PRIMARY KEY CHECK(email REGEXP '^[a-zA-Z0-9]*@([-.]?[a-zA-Z0-9])*\.[a-zA-Z]{2,4}$'),
    auth_number VARCHAR(4) NOT NULL CHECK(auth_number REGEXP '^[0-9]{4}$')
);

-- 회원 테이블
CREATE TABLE user (
    id VARCHAR(20) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    join_path VARCHAR(5) NOT NULL DEFAULT 'HOME',
    role VARCHAR(6) NOT NULL DEFAULT 'NORMAL',
    CONSTRAINT user_email_fk FOREIGN KEY (email) REFERENCES email_auth (email)
);

-- 게시물 테이블
CREATE TABLE board (
    receipt_number INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    status BOOLEAN NOT NULL DEFAULT false,
    writer_id VARCHAR(20) NOT NULL,
    write_date DATETIME NOT NULL DEFAULT now(),
    view_count INT NOT NULL DEFAULT 0,
    contents VARCHAR(1000) NOT NULL,
    reply TEXT,
    CONSTRAINT writer_fk FOREIGN KEY (writer_id) REFERENCES user (id)
);

-- 로그인 
SELECT * FROM user 
WHERE id = :id AND password = :password;

SELECT * FROM user WHERE id = :id;

-- 아이디 중복확인
SELECT * FROM user WHERE id = :id;

-- 이메일 인증
INSERT INTO email_auth VALUES (:email, :auth_number);

-- 이메일 인증 확인
SELECT * FROM email_auth 
WHERE email = :email AND auth_number = :auth_number;

-- 회원가입
INSERT INTO user(id, password, email) VALUES (:id, :password, :email);

-- 게시물 리스트
SELECT 
    receipt_number, 
    status, 
    title, 
    writer_id, 
    write_date, 
    view_count
FROM board
WHERE title LIKE '%:title%'
ORDER BY receipt_number DESC
LIMIT 10;