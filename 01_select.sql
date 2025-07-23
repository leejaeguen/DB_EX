-- 주석

SELECT * FROM tbl_menu;	     -- 메뉴 조회
SELECT * FROM tbl_category;

SELECT category_code, category_name FROM tbl_category;
SELECT category_name, category_code  FROM tbl_category;

-- *(asterisk) 쓰면 감리사한테 혼난다.
SELECT
       category_code
     , category_name				-- 코딩컨벤션에 따라 콤마는 다음줄에...
     , ref_category_code
  FROM tbl_category;
  
-- ------------------------------------------------------
-- from절 없는 select 해보기
SELECT 7 + 3;
SELECT 10 * 2;
SELECT 6 % 3, 6 % 4;		-- mod, modulus: 나누고 나머지
SELECT NOW();			   -- 컴퓨터의 시스템 시간(데이터 베이스 서버 시스템 시간)
SELECT CONCAT('유', ' ', '관순');  -- concat은 하나의 문자열로 변환

-- 문자 -> 아스키 코드(영어, 숫자, 특수기호), 유니코드(영어, 숫자, 특수기호, 그 외)
-- 문자열('): 문자 0개 이상

SELECT * FROM tbl_menu;
SELECT 
	    concat(menu_price, '원') 
  FROM tbl_menu;


-- 별칭(alias)
SELECT 7 + 3 AS '합';  	-- 가독성이 좋게 하려면 as 및 '를 붙인다.
SELECT 7 + 3 '합';
SELECT 7 + 3 합;

-- 별칭에 띄어쓰기를 포함한 특수기호가 있다면 ' 생략 불가
SELECT 7 + 1 '합 계';
-- SELECT 7 + 1 합 계;		-- 에러 발생

SELECT
       menu_name AS '메뉴명'
     , menu_price AS '메뉴가격'
  FROM tbl_menu;



