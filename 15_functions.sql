-- functions
-- 1. 문자열 관련 함수
SELECT ASCII('a'), CHAR(97);

SELECT BIT_LENGTH('한글'), CHAR_LENGTH('한글'), LENGTH('한글');

SELECT CONCAT('nice', 'to', 'meet', 'you');
SELECT CONCAT_WS(' ', 'nice', 'to', 'meet', 'you!');
SELECT CONCAT(CAST(menu_price AS CHAR), '원') FROM tbl_menu;

SELECT
       ELT(2, '축구', '야구', '농구')
     , FIELD('축구', '야구', '농구', '축구')
     , FIND_IN_SET('축구', '야구,농구,축구')
     , INSTR('축구농구야구', '농구')
     , LOCATE('야구', '축구농구야구');
     
SELECT INSERT('나와라 피카츄!', 5, 3, '꼬부기');

SELECT LEFT('Hello World!', 5), RIGHT('Nice Shot!', 5);

SELECT LOWER('Hello World!'), UPPER('Hello World!');

SELECT LPAD('왼쪽', 10, '#'), RPAD('오른쪽', 10, '#');

SELECT LTRIM('        왼쪽'), RTRIM('오른쪽         '), '오른쪽         ';

SELECT TRIM('         MariaDB         ')
     , TRIM(BOTH '@' FROM '@@@@MariaDB@@@@')
     , TRIM(LEADING '@' FROM '@@@@MariaDB@@@@')		-- LTRIM과 동일
     , TRIM(TRAILING '@' FROM '@@@@MariaDB@@@@');  -- RTRIM과 동일

SELECT CONCAT('현재 잔액은 ', FORMAT(1234561234, 3), '입니다.');

SELECT BIN(65), OCT(65), HEX(59);

SELECT repeat('재미져', 5);

SELECT REVERSE('happiness');

SELECT REPLACE('마리아DB', '마리아', 'Maria');

SELECT SUBSTRING('열심히 db공부를 해 봅시다!', 5, 4)
     , SUBSTRING('열심히 db공부를 해 봅시다!', 11);

-- 2. 숫자 관련 함수
SELECT ABS(-123);

SELECT CEILING(1234.56), FLOOR(1234.56), ROUND(1234.56);

SELECT CONV('A', 16, 10), CONV('A', 16, 2);

SELECT MOD(10, 3), 10 % 3;

SELECT POW(3, 2), SQRT(81);

SELECT FLOOR(RAND() * 4 + 5), FLOOR(RAND() * 4) + 5;

SELECT SIGN(10.1), SIGN(0), SIGN(-1.1);

SELECT TRUNCATE(12345.12345, 2), TRUNCATE(1234.12345, -2);

-- 3.날짜 및 시간 관련 함수
SELECT ADDDATE('2020-02-01', INTERVAL 28 DAY), ADDDATE('2020-02-01', 28);
SELECT SUBDATE('2020-02-01', INTERVAL 1 DAY), SUBDATE('2020-02-01', 1);

SELECT ADDTIME('2020-02-21 12:02:00', '1:0:10')
     , SUBTIME('2020-02-21 12:02:00', '1:0:10');

SELECT CURDATE(), CURTIME(), NOW(), SYSDATE();

SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAY(CURDATE());
SELECT HOUR(CURTIME()), MINUTE(CURTIME()), SECOND(CURTIME()), MICROSECOND(CURTIME(6));






