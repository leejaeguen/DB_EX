-- distinct
-- 중복을 제거해 종류를 알고자 할 때(그룹핑)
-- distinct를 쓸 때는 추출할 컬럼을 잘 고려해야 한다.
-- (일반적으로 하나의 컬럼을 쓸 것)

-- 메뉴가 할당된 카테고리를 조회해줘
SELECT * FROM tbl_menu;
SELECT * FROM tbl_category;

SELECT
       distinct category_code
  FROM tbl_menu;		
-- 메뉴로 할당된 카테고리의 번호는 4, 5, 6, 8, 9, 10, 11, 12
  
-- 해당 카테고리들의 이름을 조회(IN 연산자를 활용할 수 있다.)
SELECT
       category_name
  FROM tbl_category
 WHERE category_code IN (4, 5, 6, 8, 9, 10, 11, 12);
 
-- ------------------------------------------
-- 다중열 distinct
-- 컬럼이 두개 이상일 경우 한데 묶어 하나의 개념으로 보고 중복체크함

-- 같은 카테고리와 주문가능 상태를 가지는 메뉴들의 종류(그룹)
SELECT
       distinct 
		 category_code
     , orderable_status
  FROM tbl_menu;
 