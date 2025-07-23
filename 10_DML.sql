-- DML(Data Manipulation Language)
-- insert, update, delete

-- insert
-- 새로운 행을 추가하는 구문
-- insert 시에는 컬럼을 작성할 수도 안할 수도 있다.
-- 이때 무시해도 되는 컬럼은 auto_increment가 달려있는 컬럼이고
-- 알아서 다음 번호를 작성해 준다.
SELECT * FROM tbl_menu;
INSERT
  INTO tbl_menu
(
  menu_name
, menu_price
, category_code
, orderable_status
)
VALUES
(
  '초콜릿죽'
, 6500
, 7
, 'Y'
);

DESC tbl_menu;
SELECT * FROM tbl_menu ORDER by 1 DESC;

-- ------------------------------------------------
-- multi-insert 
-- 하나의 insert 구문으로 여러 데이터를 insert 할 수도 있다.
INSERT
  INTO tbl_menu
VALUES
(NULL, '참치맛아이스크림', 1700, 12, 'Y'),
(NULL, '멸치맛아이스크림', 1500, 11, 'Y'),
(NULL, '소시지맛커피', 2500, 8, 'Y');

SELECT * FROM tbl_menu ORDER by 1 DESC;

-- --------------------------------------------------
-- update
-- 컬럼에 있는 컬럼값을 원하는 컬럼값으로 바꾸는 것
-- 주의! 반드시 해당되는 행을 where 조건으로 잘 추릴 것
SELECT * FROM tbl_menu ORDER BY 1 desc;
UPDATE tbl_menu
   SET category_code = 7,
       menu_price = 3000
 WHERE menu_code = 30;
 
-- 서브쿼리도 활용 가능
-- '멸치맛아이스크림'의 가격을 2000원으로 수정
UPDATE tbl_menu
   SET menu_price = 2000
 WHERE menu_code = (SELECT menu_code
                      FROM tbl_menu
                     WHERE menu_name = '멸치맛아이스크림' 
                   );
SELECT * FROM tbl_menu ORDER BY 1 DESC;

-- --------------------------------------------------
-- delete
-- soft delete(update), hard delete(delete)
-- 주의! 지울 데이터를 where절로 조건 처리 잘 할 것
DELETE
  FROM tbl_menu
 WHERE menu_code = 20;
 
SELECT * FROM tbl_menu;

DELETE
  FROM tbl_menu
 WHERE 1 = 1;	-- where 1 = 0(항상 false), where 1 = 1(항상 true)

SELECT * FROM tbl_menu ORDER BY menu_price ASC;

-- order by 및 limit 활용도 가능하다.
DELETE
  FROM tbl_menu
 ORDER BY menu_price ASC
 LIMIT 2;
 
SELECT * FROM tbl_menu ORDER BY menu_price ASC;

-- ----------------------------------------------------------
-- replace(치환)
-- 덮어씌우기, pk 컬럼에 해당하는 값으로 기존과 새로움을 구분
-- 1) 기존에 있는 메뉴는 수정
REPLACE
   INTO tbl_menu
VALUES
(
  17
, '참기름소주'
, 5000
, 10
, 'Y'
);

SELECT * FROM tbl_menu;

-- 2) 기존에 없는 메뉴는 추가
REPLACE
   INTO tbl_menu
VALUES
(
  100
, '참기름소주'
, 5000
, 10
, 'Y'
);





