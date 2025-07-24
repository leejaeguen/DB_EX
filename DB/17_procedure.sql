-- procedure
-- 쿼리를 나열한 절차를 저장해서 쓰는 것
-- 기능을 정의한 것

delimiter //		-- 문장의 끝(한 프로시저의 끝)을 지금부터 //로 하겠다.
CREATE OR REPLACE PROCEDURE getAllEmployees()
BEGIN
    SELECT emp_id, emp_name, salary
      FROM employee;
END //

delimiter ;		   -- 다시 문장의 끝을 지금부터 ;로 돌려 놓겠다.

CALL getAllEmployees();

-- ---------------------------------------------------------
-- IN 매개변수
delimiter //

CREATE OR REPLACE PROCEDURE getEmployeesByDepartment (
    IN dept CHAR(2)
)
BEGIN
    SELECT emp_id, emp_name, salary, dept_code
      FROM employee
     WHERE dept_code = dept;
END //

delimiter ;

-- 편리함 + 재사용성 측면
CALL getEmployeesByDepartment('D5');
CALL getEmployeesByDepartment('D6');
CALL getEmployeesByDepartment('D2');

-- ------------------------------------------------
-- out 매개변수
delimiter //
CREATE OR REPLACE PROCEDURE getEmployeeSalary(
    IN id VARCHAR(3),
    OUT sal2 INTEGER
)
BEGIN
    SELECT salary INTO sal2
      FROM employee
     WHERE emp_id = id;
END //

delimiter ;

SET @sal1 = 0;
CALL getEmployeeSalary('210', @sal1);
SELECT @sal1;

-- ---------------------------------------------------
-- inout 매개변수
delimiter //

CREATE OR REPLACE PROCEDURE updateAndReturnSalary (
  IN id VARCHAR(3),
  INOUT sal INTEGER 
)
BEGIN
    UPDATE employee
       SET salary = sal
     WHERE emp_id = id;
     
    SELECT salary + (salary * IFNULL(bonus, 0)) INTO sal
      FROM employee
     WHERE emp_id = id;
END //

delimiter ;

SET @new_sal = 9000000;
CALL updateAndReturnSalary('200', @new_sal);
SELECT @new_sal;

-- @변수의 의미
-- '사용자 정의형 변수', '이름이 있는 저장 공간'
-- 전역변수의 의미를 가짐

-- ------------------------------------------------------------
-- if-else 활용
delimiter //

CREATE OR REPLACE PROCEDURE checkEmployeeSalary (
    IN id VARCHAR(3),
    IN threshold INTEGER,
    OUT result VARCHAR(50)
)
BEGIN
    DECLARE sal INTEGER; 
    
    SELECT salary INTO sal
      FROM employee
     WHERE emp_id = id;
     
    if sal > threshold then
        SET result = '기준치를 넘는 급여입니다.';
    else
        SET result = '기준치와 같거나 기준치 미만의 급여입니다.';
    END if;
END //

delimiter ;

SET @result = '';
CALL checkEmployeeSalary('200', 3000000, @result);
SELECT @result;

-- ----------------------------------------------------------------
-- case
delimiter //
CREATE OR REPLACE PROCEDURE getDepartmentMessage(
    IN id VARCHAR(3),
    OUT message VARCHAR(100)
)
BEGIN
    DECLARE dept VARCHAR(50);
    
    SELECT dept_code INTO dept
      FROM employee
     WHERE emp_id = id;
     
    case
        when dept = 'D1' then
            SET message = '인사관리부 직원이시군요!';
        when dept = 'D2' then
            SET message = '회계관리부 직원이시군요!';        
        when dept = 'D3' then
            SET message = '마케팅부부 직원이시군요!';        
        ELSE 
            SET message = '어떤 부서 직원이신지 모르겠어요!';        
    END case;
END //
delimiter ;

SET @message = '';
CALL getDepartmentMessage('217', @message);
SELECT @message;

-- -------------------------------------------------------------------
-- while 활용
delimiter //

CREATE OR REPLACE PROCEDURE calculateSumUpTo (
    IN max_num INT,
    OUT sum_result INT 
)
BEGIN
    DECLARE current_num INT DEFAULT 1;
    DECLARE total_sum INT DEFAULT 0;
    
    while current_num <= max_num DO
        SET total_sum = total_sum + current_num;
        SET current_num = current_num + 1;
    END while;
    
    SET sum_result = total_sum;
END //

delimiter ;

SET @result = 0;
CALL calculateSumUpTo(100, @result);
SELECT @result;

-- ----------------------------------------------------
-- 예외 처리
delimiter //
CREATE OR REPLACE PROCEDURE divideNumbers(
   IN numerator DOUBLE,
   IN denominator DOUBLE,
   OUT result DOUBLE 
)
BEGIN
    DECLARE division_by_zero CONDITION FOR SQLSTATE '45000';
    DECLARE exit handler FOR division_by_zero
    begin
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '0으로 나눌 수 없습니다.';
    END;
    
    if denominator = 0 then
        SIGNAL division_by_zero;
    ELSE 
        SET result = numerator / denominator;
    END if;
END //
delimiter ;

SET @result = 0;
CALL divideNumbers(10, 2, @result);
SELECT @result;
CALL divideNumbers(10, 0, @result);
SELECT @result;

-- ------------------------------------------------------------------
-- stored function
delimiter //
CREATE OR REPLACE FUNCTION getAnnualSalary(
    id VARCHAR(3)
)
RETURNS INTEGER
DETERMINISTIC
BEGIN
    DECLARE monthly_salary INTEGER;
    DECLARE annual_salary INTEGER;
    
    SELECT salary INTO monthly_salary
      FROM employee
     WHERE emp_id = id;
   
    SET annual_salary = monthly_salary * 12;
    
    RETURN annual_salary;
END //
delimiter ;

SELECT
       emp_name
     , getAnnualSalary(emp_id) AS '연봉'
  FROM employee;















