-- transaction
-- 논리적 일의 단위
-- 예) 주문 -> 배송, 결제, 재고

SELECT @@autocommit;		-- autocommit 상태 확인(1: on, 0: off)

START TRANSACTION;		-- autocommit이라는 기능이 꺼짐
                        -- insert, update, delete 각각 마다 commit하지 않음

INSERT
  INTO tbl_menu
VALUES
(
  NULL, '바나나해장국', 8500
, 4, 'Y'
);

SAVEPOINT sp1;		-- 중간 저장지점을 지정할 수 있다.

UPDATE tbl_menu
   SET menu_name = '수정된 메뉴'
 WHERE menu_code = 5;
 
DELETE FROM tbl_menu WHERE menu_code = 10; 

-- ROLLBACK;   -- 아직 적용되지 않은 원본 데이터 상태로 돌아감(취소, 뒤로가기)
-- COMMIT;     -- 원본 데이터에 영향을 줌(더이상 rollback이 되지 않음)

ROLLBACK TO sp1;  -- 중간 저장지점까지 rollback할 수도 있다.

SELECT * FROM tbl_menu;

-- start transaction부터 rollback/commit까지의 묶음이 끝나고 나면 다시 autocommit 상태가 된다.
DELETE
  FROM tbl_menu
 WHERE menu_code = 11;
-- commit;				-- 자동으로 이 시점에 update, insert, delete 쿼리 각각 마다 commit됨
ROLLBACK;
SELECT * FROM tbl_menu;
 
-- autocommit을 꺼주려면...
SET autocommit = 0;
-- SET autocommit = FALSE;
DELETE
  FROM tbl_menu
 WHERE menu_code = 13;
ROLLBACK;
SELECT * FROM tbl_menu;

-- 번호가 중간이 뜬다면?
-- 번호발생기인 auto_increment를 다시 원하는 숫자로 초기화
ALTER TABLE tbl_menu AUTO_INCREMENT = 23;  -- 다음 번호 발생을 23번으로 하고 싶다면

