-- constraints(제약조건)
-- 1. not null 제약조건
-- 반드시 데이터가 존재해야 함
-- 컬럼 레벨에서만 제약조건 부여가 가능
DROP TABLE if EXISTS user_notnull;
CREATE table if not EXISTS user_notnull (
    user_no INT NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255)
);

INSERT
  INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_notnull;

INSERT
  INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(null, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com');

-- 2. unique 제약조건
-- 중복된 데이터가 해당 컬럼에 들어가지 않아야 함
-- 컬럼레벨 + 테이블레벨
DROP TABLE if EXISTS user_unique;
CREATE table if not EXISTS user_unique (
    user_no INT NOT NULL UNIQUE,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    UNIQUE(phone)
--     UNIQUE(phone, email)  -- 컬럼을 두개이상 복수개로 unique 제약조건을 걸 때는 
                             -- 테이블 레벨만 가능
);

INSERT
  INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_unique;
DESC user_unique;

INSERT
  INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(3, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com');

-- ------------------------------------------------------------
-- 3. primary key 제약조건
-- 모든 테이블에 반드시 하나 존재해야 하는 제약조건(문법 에러가 안나도 필수)
-- not null + unique
-- 컬럼레벨 + 테이블레벨
DROP TABLE if EXISTS user_primarykey;
CREATE table if not EXISTS user_primarykey (
    user_no INT,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    UNIQUE(phone),
    PRIMARY KEY(user_no)
);

INSERT
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

INSERT
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(, 'user01', 'pass01', '홍길동', '남', '010-123-1234', 'hong123@gmail.com');

-- ------------------------------------------------------
-- 4. foreign key 제약조건
-- 테이블이 두개 이상이면서 한쪽 테이블(primary key)에서 
-- 다른쪽 테이블(일반컬럼)로 넘어간 컬럼에 작성됨
-- foreign key 제약조건은 부모 테이블의 pk값을 참조 + null 값이 들어갈 수 있다.

-- 테이블들을 지울 때는 자식 테이블들 부터 삭제하자.
DROP TABLE if EXISTS user_foreignkey;
DROP TABLE if EXISTS user_grade;

CREATE TABLE if NOT EXISTS user_grade (
    grade_code INT PRIMARY KEY,
    grade_name VARCHAR(255) NOT NULL
);

CREATE table if not EXISTS user_foreignkey (
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT,
--     FOREIGN KEY(grade_code) REFERENCES user_grade(grade_code)	
    FOREIGN KEY(grade_code) REFERENCES user_grade  -- 참조할 테이블의 컬럼명은 생략가능
                                                   -- 이유는, primary key인게 당연하기 때문
);

INSERT
  INTO user_grade
VALUES
(10, '일반회원'),
(20, '우수회원'),
(30, '특별회원');

SELECT * FROM user_grade;

INSERT
  INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', NULL);

SELECT * FROM user_foreignkey;

INSERT
  INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(3, 'user01', 'pass01', '홍길동', '남', '010-123-1234', 'hong123@gmail.com', 22);

-- -----------------------------------------------------------------------------
-- 삭제룰을 적용해서 부모테이블의 데이터를 삭제하게 해줄 수도 있다.
-- (추가로 이해할 것, 권장 X)
DROP TABLE if EXISTS user_foreignkey2;
DROP TABLE if EXISTS user_grade2;

CREATE TABLE if NOT EXISTS user_grade2 (
    grade_code INT PRIMARY KEY,
    grade_name VARCHAR(255) NOT NULL
);

CREATE table if not EXISTS user_foreignkey2 (
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT,
    FOREIGN KEY(grade_code) REFERENCES user_grade2 ON DELETE SET NULL
);

INSERT
  INTO user_grade2
VALUES
(10, '일반회원'),
(20, '우수회원'),
(30, '특별회원');

SELECT * FROM user_grade2;

INSERT
  INTO user_foreignkey2
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', NULL);

SELECT * FROM user_foreignkey2;

-- 부모 테이블의 10번 '일반회원' 등급 삭제 후 확인
DELETE
  FROM user_grade2
 WHERE grade_code = 10;

SELECT * FROM user_foreignkey2;

-- ----------------------------------------------------------
-- 5. check 제약조건(조건식을 활용한 상세한 제약사항)

DROP TABLE if EXISTS user_check;
CREATE TABLE if NOT EXISTS user_check (
    user_no INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3) CHECK(gender IN ('남', '여')),  -- check 제약조건은 컬럼레벨도 컬럼을 작성한다.
    age INT,
	 CHECK(age >= 19 AND age <= 30)
);

INSERT
  INTO user_check
VALUES
(NULL, '홍길동', '남', 25),
(NULL, '신사임당', '여', 23);

-- check 제약조건 위반
INSERT
  INTO user_check
VALUES
(NULL, '김개똥', '중', 27);

-- --------------------------------------------------------
-- default 제약조건
DROP TABLE if EXISTS tbl_country;
CREATE TABLE if NOT EXISTS tbl_country (
    country_code INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(255) DEFAULT '한국',
    population VARCHAR(255) DEFAULT '0명',
    add_day DATE DEFAULT (CURRENT_DATE),
    add_time DATETIME DEFAULT (CURRENT_TIME)
);

INSERT
  INTO tbl_country
VALUES
(NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

SELECT * FROM tbl_country;

-- ---------------------------------------------------------------
SELECT 
    TABLE_NAME as '테이블명',
    ENGINE as '엔진',
    TABLE_ROWS as '행수',
    ROUND(DATA_LENGTH/1024/1024, 2) as 'MB'
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_TYPE = 'BASE TABLE';


SELECT 
    tc.CONSTRAINT_NAME,
    CONSTRAINT_TYPE,
    COLUMN_NAME
FROM information_schema.TABLE_CONSTRAINTS tc
LEFT JOIN information_schema.KEY_COLUMN_USAGE kcu 
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME 
    AND tc.TABLE_SCHEMA = kcu.TABLE_SCHEMA 
    AND tc.TABLE_NAME = kcu.TABLE_NAME
WHERE tc.TABLE_SCHEMA = DATABASE() 
    AND tc.TABLE_NAME = 'user_check';




