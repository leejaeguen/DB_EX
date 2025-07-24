-- Limit
SELECT
       menu_code
     , menu_name
     , menu_price
  FROM tbl_menu
 ORDER BY menu_price DESC, menu_code DESC
 LIMIT 6, 6;	-- 7번째 행부터 이후 6개의 행을 추출
 
SELECT
       *
  FROM tbl_menu
 ORDER BY menu_code
 LIMIT 5;		-- 첫 행부터 작성된 숫자 길이만큼 추출