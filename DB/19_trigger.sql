-- trigger
-- 특정 테이블 또는 데이터에 변화가 생기면 실행할 내용을 저장하는 DB의 오브젝트
delimiter //

CREATE OR REPLACE TRIGGER after_order_menu_insert
    AFTER insert
    ON tbl_order_menu
    FOR EACH ROW 
BEGIN
    UPDATE tbl_order
       SET total_order_price = total_order_price + NEW.order_amount *
   (SELECT menu_price FROM tbl_menu WHERE menu_code = NEW.menu_code)
     WHERE order_code = NEW.order_code;
END //

delimiter ;

-- 주문 테이블(tbl_order)에 insert 후 주문 메뉴 테이블(tbl_order_menu)에
-- 주문한 메뉴마다 insert 후 주문 테이블의 총 금액(total_order_price)을 업데이트
-- 되는지 확인하자.

-- 1) 부모 테이블인 tbl_order부터 insert
INSERT
  INTO tbl_order
(
  order_code, order_date
, order_time, total_order_price
)
VALUES
(
  NULL
, CONCAT(CAST(YEAR(NOW()) AS VARCHAR(4))
       , CAST(LPAD(MONTH(NOW()), 2, 0) AS VARCHAR(2))
       , CAST(LPAD(DAYOFMONTH(NOW()), 2, 0) AS VARCHAR(2)))
, CONCAT(CAST(LPAD(HOUR(NOW()), 2, 0) AS VARCHAR(2))
       , CAST(LPAD(MINUTE(NOW()), 2, 0) AS VARCHAR(2))
       , CAST(LPAD(SECOND(NOW()), 2, 0) AS VARCHAR(2)))
, 0
);

DESC tbl_order;

SELECT MONTH(NOW());
SELECT DAYOFMONTH(NOW());

SELECT CONCAT(CAST(LPAD(HOUR(NOW()), 2, 0) AS VARCHAR(2)), ':'
       , CAST(LPAD(MINUTE(NOW()), 2, 0) AS VARCHAR(2)), ':'
       , CAST(LPAD(SECOND(NOW()), 2, 0) AS VARCHAR(2)));

SELECT * FROM tbl_order;

-- 2) 자식 테이블인 tbl_order_menu에 메뉴 추가
SELECT * FROM tbl_menu;
-- 갈릭미역파르페 3개 추가
INSERT
  INTO tbl_order_menu
(order_code, menu_code, order_amount)
VALUES
(1, 4, 3);
DESC tbl_order_menu;

SELECT * FROM tbl_order_menu;
SELECT * FROM tbl_order;

-- 우럭스무디 2개 추가
INSERT
  INTO tbl_order_menu
(order_code, menu_code, order_amount)
VALUES
(1, 2, 2);

SELECT * FROM tbl_order_menu;
SELECT * FROM tbl_order;

-- insert만 해도 자동으로 문제없이 유도속성이 update 됨(업무 무결성 만족)
-- 입출고용 트리거 생성
-- 1) 이력 테이블(update)
CREATE TABLE if NOT EXISTS product(
    pcode INT PRIMARY KEY AUTO_INCREMENT,
    pname VARCHAR(30),
    brand VARCHAR(30),
    price INT,
    stock INT DEFAULT 0,
    CHECK(stock >= 0)
);

-- 2) 내역 테이블(insert)
CREATE TABLE if NOT EXISTS pro_detail(
    dcode INT PRIMARY KEY AUTO_INCREMENT,
    pcode INT,
    pdate DATE,
    amount INT,
    STATUS VARCHAR(10) CHECK(STATUS IN ('입고', '출고')),
    FOREIGN KEY(pcode) REFERENCES product
);

delimiter //

CREATE OR REPLACE TRIGGER trg_productafter
    AFTER insert
    ON pro_detail
    FOR EACH row
BEGIN
    if NEW.status = '입고' then
        UPDATE product
           SET stock = stock + NEW.amount
         WHERE pcode = NEW.pcode;
    ELSEIF NEW.status = '출고' then
        UPDATE product
           SET stock = stock - NEW.amount
         WHERE pcode = NEW.pcode;
    END if;
END //

delimiter ;

-- 1) 상품 등록(초기 수량 부여)
INSERT
  INTO product
(
  pcode, pname, brand
, price, stock
)
VALUES
(
  NULL, '갤럭시플립', '삼송'
, 900000, 5
),
(
  NULL, '아이펀17', '사과'
, 1100000, 3
),
(
  NULL, '투명폰', '삼송'
, 2100000, 4
);

SELECT * FROM product;

-- 2) 입고 및 출고 진행
INSERT
  INTO pro_detail
(
  dcode, pcode, pdate
, amount, status
)
VALUES
(
  NULL, 3, CURDATE()
, 3, '출고'
);
SELECT * FROM product;
SELECT * FROM pro_detail;

INSERT
  INTO pro_detail
(
  dcode, pcode, pdate
, amount, status
)
VALUES
(
  NULL, 1, CURDATE()
, 10, '입고'
);
SELECT * FROM product;
SELECT * FROM pro_detail;

-- insert 시 동작할 trigger -> NEW.컬럼명
-- update 시 동작할 trigger -> NEW.컬럼명, OLD.컬럼명
-- delete 시 동작할 trigger -> OLD.컬럼명


