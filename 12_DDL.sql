-- DDL(Data Definition Language)
-- DB의 오브젝트들을 만들고(create), 수정하고(alter), 삭제하는(drop) 것을 DDL이라고 함
-- DB의 오브젝트: 데이터를 저장하기 위한 데이터 구조(user, table, view, procedure, ...)

CREATE TABLE tb1 (
    pk INT PRIMARY KEY,
    fk INT,
    col1 VARCHAR(255),
    CHECK(col1 IN ('Y', 'N'))
);

DESC tb1;

INSERT
  INTO tb1
VALUES
(
  1, 2, 'Y'
);

SELECT * FROM tb1;

-- auto_increment
DROP TABLE if exists tb2;				
CREATE TABLE if not exists tb2 (
  pk INT PRIMARY KEY AUTO_INCREMENT,
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN ('Y', 'N'))
);

DESC tb2;

INSERT
  INTO tb2
VALUES
(
  NULL, 2, 'N'
);

SELECT * FROM tb2;

-- ------------------------------------------------------------
-- alter
-- 1) 컬럼 추가
ALTER TABLE tb2 ADD col2 INT NOT NULL;
DESC tb2;

-- 2) 컬럼 삭제
ALTER TABLE tb2 DROP col2;
DESC tb2;

-- 3) 컬럼 이름 및 컬럼 정의 변경
ALTER TABLE tb2 CHANGE COLUMN fk change_fk INT NOT NULL;
DESC tb2;

-- auto_increment 제거
ALTER TABLE tb2 MODIFY pk INT;

-- primary key 제거
ALTER TABLE tb2 DROP PRIMARY KEY;

-- primary key 추가
ALTER TABLE tb2 ADD PRIMARY KEY(pk);

DESC tb2;

-- ----------------------------------------------------
-- truncate
-- 테이블의 상태를 초기화
-- delete보다 훨씬 빠르고 깔끔하게 초기화

CREATE TABLE if NOT EXISTS tb3 (
    pk INT AUTO_INCREMENT,
    fk INT,
    col1 VARCHAR(255) CHECK(col1 IN ('Y', 'N')),
    PRIMARY KEY(pk)
);

INSERT
  INTO tb3
VALUES
(
  NULL, 1, 'N'
);

SELECT * FROM tb3;

-- 단순 데이터 제거 + auto_increment 초기화 등 데이터 관련 모든 것을 초기화
TRUNCATE TABLE tb3;

