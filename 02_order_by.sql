-- order by(정렬)
 
-- 오름차순(Ascending, ASC): 1 -> 2 -> 3 -> ..., a -> b -> c
-- 내림차순(Descending, DESC)
 
SELECT
       menu_code
     , menu_name
     , menu_price
  FROM tbl_menu
--  ORDER BY menu_code DESC;		-- Order by절은 해석할 때 가장 마지막에 하자.
--  ORDER BY menu_name ASC;
--  ORDER BY menu_name;				-- ASC는 생략 가능(기본이 오름차순)
--  ORDER BY 2;						   -- 주의! select 절에 적힌 컬럼 순서를 기반으로 작성
 ORDER BY menu_price, menu_name DESC; -- 1차 정렬 기준, 2차 정렬 기준, ...
                                      -- 앞의 기준에 해당하는 컬럼값이 같을 경우 뒤의 기준 적용
 
-- ---------------------------------------
-- 1. 반드시 코드는 아끼지말고 변형해 볼 것!
-- 2. 에러를 되려 띄워볼 것!
 
-- ---------------------------------------
-- 주문 불가능한 메뉴부터 보기
SELECT * FROM tbl_menu;			-- 테이블의 데이터를 토대로 확인
DESC tbl_menu;					   -- DESC라는 명령어로 빠르게 인사이트 얻기
-- DESCRIBE tbl_menu;

SELECT 
       menu_name
	  , orderable_status 
  FROM tbl_menu
 ORDER BY 2;
 
-- 별칭을 써서 할 수 도 있다.
SELECT 
       menu_name AS '메뉴명'
	  , orderable_status AS '주문가능상태'
  FROM tbl_menu
 ORDER BY 주문가능상태;		    -- 별칭이 인지되고 나서 order by 되기 때문
 
-- -----------------------------------------
-- null값(비어있는 컬럼값)에 대한 정렬
SELECT * FROM tbl_category;

-- 1) 오름차순 시: null이 먼저 나옴
SELECT
       *
  FROM tbl_category
 ORDER BY ref_category_code ASC;
  
-- 2) 내림차순 시: null이 나중에 나옴
SELECT
       *
  FROM tbl_category
 ORDER BY ref_category_code DESC;
 
-- 3) 오름차순 시: null이 나중에 나옴
SELECT
       *
  FROM tbl_category
 ORDER BY -ref_category_code DESC;    -- '-'는 반대의 의미이고 DESC를 썼지만 Null이 뒤에 나오는
                                      -- 오름차순이 된다.
 
-- ----------------------------------------------
-- field 함수를 활용한 order by
SELECT
       orderable_status
     , FIELD(orderable_status, 'Y', 'N') AS '가능여부'  
     , menu_name
  FROM tbl_menu
--  ORDER BY FIELD(orderable_status, 'Y', 'N') DESC;
 ORDER BY 가능여부 DESC;

 
 