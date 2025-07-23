-- join
-- 관계를 맺은 두개 이상의 테이블을 한번에 조회하고 싶을 때

-- 메뉴명과 카테고리명을 한번에 보고싶다.
SELECT * FROM tbl_menu;
SELECT * FROM tbl_category; 

-- 1) '메뉴명'과 '카테고리명'이 각각 어떤 테이블에 존재하나?(두 개 이상이면)
-- 2) tbl_menu와 tbl_category에서 확인을 하고 서로 관계를 맺었는지 확인
-- 3) join으로 해결 가능함을 확인

-- 메뉴를 기준으로 카테고리도 함께 보는 개념
SELECT
       *
  FROM tbl_menu 
  JOIN tbl_category ON tbl_menu.category_code = tbl_category.category_code;
-- ON은 조인을 위한 조건절로 반드시 관계있는 컬럼을 토대로 조건을 작성할 것
  
-- 별칭을 활용한 조인 사용
-- 테이블에 별칭 추가 시에는 as를 붙여도 안붙여도 된다.(통일감 있게)
SELECT
       a.menu_name AS '메뉴명'
     , a.menu_price
     , b.category_name
     , a.category_code		-- 두 테이블에 같은 이름으로 존재하는 컬럼이 있어
                           -- ambiguous 에러가 발생하면 별칭으로 구분하자.
     , b.category_code
  FROM tbl_menu AS a			-- 싱글 쿼테이션(')은 적용 안됨
  JOIN tbl_category b ON a.category_code = b.category_code;

DESC tbl_menu;
DESC tbl_category;

-- 코딩 컨벤션을 신경쓰자
-- 별칭은 왠만하면 다 추가하자.

-- ---------------------------------------------------------------------
-- inner join
-- 각 테이블이 모두 매칭 될 경우만 join
-- 1) on을 활용
SELECT
       a.menu_name
     , b.category_name
  FROM tbl_menu a
 INNER JOIN tbl_category b ON (a.category_code = b.category_code);  -- inner는 생략 가능

-- 2) using을 활용(컬럼명이 같을 때는 using을 활용할 수 있고 별칭 쓰면 X)
SELECT
       a.menu_name
     , b.category_name
  FROM tbl_menu a
  JOIN tbl_category b USING (category_code);  -- using은 소괄호를 반드시 써야 한다.

-- ----------------------------------------------------------------------
-- outer join
-- join 시에 기준이 될 테이블의 모든 행을 보고자 하는 경우 사용
-- (매칭이 안되도 다 보고 싶을 때)

-- 1) left join
SELECT
       a.category_name
     , b.menu_name
--      , a.category_code
  FROM tbl_category a
  LEFT JOIN tbl_menu b ON a.category_code = b.category_code;
  
-- 2) right join
SELECT
       b.category_name
     , a.menu_name
  FROM tbl_menu a
 RIGHT JOIN tbl_category b ON a.category_code = b.category_code;

-- 만약에 다중 조인(여러 테이블이 많이 join될 경우)에서 outer join을 발생시키면
-- 끝까지 outer join을 유지해 주어야 의미가 있다.

-- 3) cross join
SELECT
       *
  FROM tbl_menu
 CROSS JOIN tbl_category;

-- cross join은 조건을 잘못 작성한 join일 경우 발생하게 되며 고의로
-- cross join을 일으키는 경우는 없다.

-- 4) self join
SELECT
       a.category_name AS '하위 카테고리'
     , b.category_name AS '상위 카테고리'
  FROM tbl_category a
  JOIN tbl_category b ON (a.ref_category_code = b.category_code);


SELECT * FROM tbl_category;








  