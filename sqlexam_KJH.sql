-- 1.
SELECT 
    job 직무, TRUNCATE(AVG(sal), - 2) "급여 평균"
FROM
    emp
WHERE
    deptno = 30
GROUP BY job;

-- 2.
SELECT 
    d.dname 부서명, COUNT(e.deptno) "직원 수"
FROM
    emp e
        JOIN
    dept d USING (deptno)
GROUP BY deptno
HAVING COUNT(deptno) >= 4;

-- 3.
SELECT 
    IFNULL(job, 'TOTAL') 직무명,
    FORMAT(SUM(sal), 0) "급여의 합"
FROM
    emp
GROUP BY job WITH ROLLUP;

-- 4.
SELECT 
    e.ename 직원명, e.sal 급여, s.grade "급여 등급"
FROM
    emp e
        JOIN
    salgrade s ON e.sal BETWEEN s.losal AND s.hisal
ORDER BY e.sal DESC
LIMIT 1;

-- 5.
SELECT 
    ename 직원명,
    CONCAT(FORMAT(sal + IFNULL(comm, 0), 0), '원') 급여
FROM
    emp
WHERE
    YEAR(hiredate) = 1981
ORDER BY sal + IFNULL(comm, 0) DESC;

-- 6. 
SELECT 
    ename 직원명,
    DATE_FORMAT(hiredate, "%Y년 %m월 %d일") 입사년월일,
    CASE YEAR(hiredate)
        WHEN 1980 THEN 'A'
        WHEN 1981 THEN 'B'
        WHEN 1982 THEN 'C'
        WHEN 1983 THEN 'D'
    END 그룹
FROM
    emp;

-- 7.
SELECT 
    e.empno "사원 사번",
    e.ename "사원 이름",
    m.empno "관리자 사번",
    m.ename "관리자 이름"
FROM
    emp e
        JOIN
    emp m ON e.mgr = m.empno;

-- 8-1.
SELECT 
    e.empno, e.ename, e.deptno
FROM
    emp e
        JOIN
    dept d USING (deptno)
        JOIN
    locations l USING (loc_code)
WHERE
    l.CITY = 'CHICAGO';

-- 8-2.
SELECT 
    e.empno, e.ename, e.deptno
FROM
    emp e
WHERE
    e.deptno = (SELECT 
            d.deptno
        FROM
            dept d
        WHERE
            d.loc_code = (SELECT 
                    l.loc_code
                FROM
                    locations l
                WHERE
                    l.city = 'CHICAGO'));

-- 9.
SELECT 
    ename, sal
FROM
    emp
WHERE
    sal > ALL (SELECT 
            sal
        FROM
            emp
        WHERE
            deptno = 30);
