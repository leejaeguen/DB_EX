-- group by절
-- from 또는 where절 이후 그룹핑을 하고자 할 때 사용하는 절
-- 그룹 함수(sum, avg, count, min, max): 그룹별로 하나의 결과가 나오게 하는 함수
-- 그룹 함수를 적용할 그룹을 선정

-- 주의사항: 그룹함수에서 select 시에는 그룹을 형성할 때 쓴 컬럼 또는 그룹함수만 작성할 것!
SELECT
       category_code
     , COUNT(*)
--      , menu_name			-- 결과는 나오지만 잘못된 결과
  FROM tbl_menu
 GROUP BY category_code;

SELECT
       DISTINCT category_code
  FROM tbl_menu;
  
-- -----------------------------------------------
-- count 함수
-- count(컬럼명 또는 *)
-- 1) *일 경우: 결과로 나온 모든 행의 갯수를 카운팅
SELECT
       COUNT(*)
     , COUNT(ref_category_code)
  FROM tbl_category;

-- 2) 컬럼명일 경우: 해당 컬럼의 컬럼값이 존재하는 경우만 카운팅
SELECT
       COUNT(ref_category_code)
  FROM tbl_category;
  
-- -----------------------------------------------
-- avg 함수
SELECT
       category_code
     , FLOOR(AVG(menu_price))		-- 함수는 중첩해서 쓸 수 있다.
                                 -- avg는 평균, floor는 버림
  FROM tbl_menu
 GROUP BY category_code;

-- -----------------------------------------------
-- having절
-- group에 대한 조건을 작성하는 절
-- having절에도 group을 나눌 때 쓴 컬럼 기준 또는 그룹함수를 작성해야 한다.
SELECT
       SUM(menu_price)
     , category_code
  FROM tbl_menu
 GROUP BY category_code
-- HAVING SUM(menu_price) >= 20000;
HAVING category_code BETWEEN 5 AND 9;

-- -----------------------------------------------
-- 6가지 절을 모두 확인
SELECT									-- 5
       category_code
     , AVG(menu_price)
  FROM tbl_menu						-- 1
 WHERE menu_price > 10000			-- 2
 GROUP BY category_code				-- 3
HAVING AVG(menu_price) > 12000	-- 4
 ORDER BY 1 DESC;						-- 6

-- ------------------------------------------------
-- rollup
-- group을 묶을 때 기준(하나의 컬럼 또는 여러 컬럼)별로 중간 합계 및 최종 합계를 
-- 산출 하는 키워드
SELECT
       SUM(menu_price) AS '합계'
     , category_code AS '카테고리코드'
  FROM tbl_menu
 GROUP BY category_code
  WITH ROLLUP;

-- 두 개 이상의 컬럼으로도 그룹을 나눌 수 있고, rollup을 할 수도 있다.
SELECT
       SUM(menu_price)
     , menu_price
     , category_code
  FROM tbl_menu
 GROUP BY menu_price, category_code
  WITH ROLLUP;



