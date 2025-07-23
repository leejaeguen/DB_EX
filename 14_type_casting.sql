-- type catsting
-- 명시적 형변환

-- 1) 숫자 -> 숫자
SELECT 
       AVG(menu_price)
     , CAST(AVG(menu_price) AS UNSIGNED INTEGER) AS '가격 평균'
     , CONVERT(AVG(menu_price), DOUBLE) AS '가격 평균2'
  FROM tbl_menu
 GROUP BY category_code;

DESC tbl_menu;

-- 2) 문자 -> 날짜
SELECT CAST('2025%07%23' AS DATE);
SELECT CAST('2025/07/23' AS DATE);
SELECT CAST('2025?07?23' AS DATE);

-- 3) 숫자 -> 문자
SELECT CAST(1000 AS CHAR);   -- 1000 -> '1000'

SELECT CONCAT(CAST(1000 AS CHAR), '원');

-- 암시적 형변환
-- practice 계정의 employeedb로 확인
SELECT
       *
  FROM employee
 WHERE emp_id = 200;  -- 200 -> '200'
 
DESC employee;

SELECT 1 + '2';  -- '2' -> 2
SELECT 5 > '반가워';

-- '반가워'가 0이 되는 이유
-- true -> 1, false -> 0
-- '반가워' 문자열을 숫자로 바꿀 땐 0
