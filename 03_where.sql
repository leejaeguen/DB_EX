-- where 절
-- 테이블에 들어있는 행마다 조건을 확인(필터링)하는 절

-- 주문 가능한 메뉴만 조회(메뉴명만 조회)
SELECT * FROM tbl_menu;

SELECT
       *
  FROM tbl_menu
--  WHERE orderable_status = 'Y';		-- 모든 행에 대해 조건 확인 -> true만 통과
--  WHERE orderable_status != 'N';		-- !=와 <>는 '같지 않다'를 의미
 WHERE orderable_status <> 'N';
 
-- ----------------------------------------------------
-- Q)'기타' 카테고리에 해당하지 않는 메뉴를 조회하시오.

-- H1)카테고리 테이블을 통해 메뉴에도 있는 카테고리 코드 번호 파악
SELECT 
        
  FROM tbl_category
 WHERE category_name = '기타'; -- 10번이 '기타' 카테고리
 
-- H2)메뉴 조회
-- SELECT * FROM tbl_menu;
SELECT
       *
  FROM tbl_menu
 WHERE category_code = 10;
 

SELECT 
       category_code
  FROM tbl_category
 WHERE category_name = '기타';

-- 나중에 배울 서브쿼리로 하나의 쿼리로도 풀 수 있다.
SELECT
       *
  FROM tbl_menu
 WHERE category_code = (
                        SELECT category_code
                          FROM tbl_category
                        WHERE category_name = '기타'
                       );
                       
                       
-- 5000원 이상이면서 7000원 미만인 메뉴 조회(AND)
SELECT
       *
  FROM tbl_menu
 WHERE menu_price >= 5000 
   AND menu_price < 7000;

-- 10000원보다 초과하거나 5000원 이하인 메뉴 조회(OR)
SELECT
       *
  FROM tbl_menu
 WHERE menu_price > 10000 
    OR menu_price <= 5000;

-- ------------------------------------------------------
-- BETWEEN 연산자 활용하기
-- 가격이 5000원 이상이면서 9000원 이하인 메뉴 전체 컬럼 조회
DESC tbl_menu;		-- 컬럼명 확인 후
SELECT
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu
--  WHERE menu_price >= 5000
--    AND menu_price <= 9000;
 WHERE menu_price BETWEEN 5000 AND 9000; -- and이면서 이상 또는 이하로 구성되면 
                                         -- between 연산자로 수정 가능
                                         
-- 만약 반대로 하고 싶다면
SELECT
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu
 WHERE menu_price NOT BETWEEN 5000 AND 9000;   

-- ----------------------------------------------------
-- Like문
-- 제목, 작성자 등을 검색할 때 주로 사용
SELECT
       *
  FROM tbl_menu
--  WHERE menu_name LIKE '%밥%';	-- % 와일드카드를 써서 Like문 작성 가능
--  WHERE menu_name LIKE '%밥';   -- '밥'으로 끝나는 메뉴
 WHERE menu_name LIKE '밥%';      -- '밥'으로 시작하는 메뉴
 
-- ------------------------------------------------------
-- IN 연산자
-- 카테고리가 '중식', '커피', '기타'인 메뉴 조회하기
SELECT * FROM tbl_category; -- 중식: 5, 커피: 8, 기타: 10

SELECT
       *
  FROM tbl_menu
--  WHERE category_code = 5
--     OR category_code = 8
-- 	 OR category_code = 10;
 WHERE category_code IN (5, 8, 10);		-- =와 or이 반복될 경우
 
-- -------------------------------------------------------
-- is null  연산자 활용(= null 하면 안됨)
SELECT
       *
  FROM tbl_category;

-- 상위 카테고리를 조회
SELECT
       *
  FROM tbl_category
 WHERE ref_category_code IS NULL;

-- 하위 카테고리를 조회
SELECT
       *
  FROM tbl_category
 WHERE ref_category_code IS NOT NULL;





