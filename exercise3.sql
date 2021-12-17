-- 제출파일명 : exercise3.sql
-- 메일제목 : SQL 실습 3 - 김준호
-- QUESTION

-- 1. 모든 직원들 월급의 평균을 구하시오. (소수점 이하 둘째자리까지만 나타내고 셋째자리 부터는 절삭하시오)
-- 			전직원 월급 평균
--           -------------
--           2073.21
SELECT TRUNCATE(AVG(sal), 2) '전직원 월급 평균' FROM emp;
       
-- 2. 모든 직원들이 받는 커미션의 합을 구하시오.
-- 				커미션 합
--             -----------
-- 				  x
SELECT SUM(comm) "커미션 합" FROM emp;


-- 3. 모든 직원들의 인원수를 구하시오.
-- 					직원수
--               -----------
-- 					  14
SELECT count(*) "직원수" FROM emp;


-- 5. 다음과 같이 커미션이 정해진 직원수와 부서가 정해진 직원수를 출력하시오.
-- 	커미션이 정해진 직원수 	부서가 정해진 직원수
-- 	---------------------------------------
-- 	 6명                    		 13명
SELECT 
    CONCAT(COUNT(comm), '명') '커미션이 정해진 직원수',
    CONCAT(COUNT(deptno), '명') '부서가 정해진 직원수'
FROM
    emp; 


-- 6. 각 직무별로 총월급을 출력하되 총월급이 낮은 순으로 출력하시오.
-- 	직무명	총월급
-- 	----------------------------
-- 	4150        CLERK
-- 	5000	PRESIDENT

SELECT 
    job '직무명', SUM(sal) '총월급'
FROM
    emp
GROUP BY job
ORDER BY SUM(sal);


-- 7. 각 부서에서 근무하는 직원들의 명수를 알고싶다. 다음 형식으로 출력하는 SQL을 작성하시오 .
-- 	부서정보	   직원명수
-- 	----------------------------
-- 	미정             1명
-- 	10번 부서      3명
-- 	20번 부서     4명
-- 	30번 부서     6명

SELECT 
    IFNULL(CONCAT(deptno, '번 부서'), '미정') '부서정보',
    CONCAT(COUNT(*), '명')  '직원명수'
FROM
    emp
GROUP BY deptno;


-- 8. 년도별로 몇명이 입사했는지 알고싶다. 다음 형식으로 출력하는 SQL을 작성하시오 . (많이 입사한 순으로 출력)
-- 	입사년도 	   입사직원수
-- 	----------------------------
-- 	1981년	   10명
-- 	1982년	   2명
-- 	1980년	   1명
-- 	1983년	   1명
SELECT 
    CONCAT(YEAR(hiredate), '년') '입사년도',
    CONCAT(COUNT(*), '명') '입사직원수'
FROM
    emp
GROUP BY YEAR(hiredate)
ORDER BY COUNT(*) DESC;		-- 입사직원수 로 sort 시 문자열 비교로 넘어가서 제대로 나오지 않음을 확인

-- 9. 직무별 월급 총액을 출력하되, 직급이 'MANAGER'인 직원들은 제외하시오. 
--   그리고 월급총액이 5000보다 큰 직급과 총월급만 출력하시오.
-- 	직급명		총액
-- 	----------------------------
-- 	SALESMAN          	5,600
-- 	 ANAYST	  	6,000
SELECT 
    job '직급명', FORMAT(SUM(sal), 0) '총액'
FROM
    emp
WHERE
    job != 'MANAGER'
GROUP BY job
HAVING SUM(sal) > 5000;


-- 10. 30번 부서의 직무별 년봉의 평균을 검색한다.
-- 연봉계산은 월급+커미션(null이면 0으로 계산)이며 
-- 출력 양식은 소수점 이하 두 자리(반올림)까지 통일된 양식으로 출력한다.
--    직무       평균월급
-- ---------------------------
--    SALESMAN	1600.00
-- 	  MANAGER	2850.00
-- 	  CLERK		950.00
SELECT 
    job '직무',
    ROUND(AVG(sal + IFNULL(comm, 0)), 2) '평균월급'
FROM
    emp
WHERE
    deptno = 30
GROUP BY job;



-- 11. 월별 입사인원을 다음 형식으로 출력하는 SQL 을 작성하시오 . 
--     입사월별로 오름차순이며 입사인원이 2명 이상인 경우에만 출력한다.
-- 	입사월	인원
-- 	--------------
-- 	1	2명
-- 	2 	2명
-- 	4	2명
-- 	9	2명
-- 	10	3명
SELECT 
    MONTH(hiredate) '입사월', CONCAT(COUNT(hiredate), '명') '인원'
FROM
    emp
GROUP BY MONTH(hiredate)
HAVING COUNT(*) >= 2
ORDER BY MONTH(hiredate);

-- 12. 직무별 그리고 입사년도별 직원들 수를 출력하는데 직무별 직원수(소합계)와 전체 직원수(전체 합계)도 
--      함께 출력한다.
-- 직무      	입사년도 	직원수
-- -----------------------
-- ANALYST       	1981      1
-- ANALYST       	1982      1
-- ANALYST       	NULL      2
-- CLERK         	1980      1
-- CLERK         	1981      1
-- CLERK         	1982      1
-- CLERK         	1983      1
-- CLERK         	NULL      4
-- MANAGER       	1981      3
-- MANAGER       	NULL      3
-- PRESIDENT     	1981      1
-- PRESIDENT     	NULL      1
-- SALESMAN      	1981      4
-- SALESMAN      	NULL      4
-- NULL         	 NULL     14

SELECT 
    job '직무',
    YEAR(hiredate) '입사년도',
    COUNT(*) '직원수'
FROM
    emp
GROUP BY job , YEAR(hiredate) WITH ROLLUP;
