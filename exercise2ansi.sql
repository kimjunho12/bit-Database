use sqldb;
-- �������ϸ� : exercise2.sql
-- �������� : SQL �ǽ� 2 - ����ȣ
-- QUESTION
-- 1. ��� ���̺��� ����̸��� �ҹ��ڷ� ����ϰ� �÷����� ����̸����� �����Ͻÿ�.
--  [���]       ����̸�
--           ---------------------
--                  smith
SELECT 
    LOWER(ename) '����̸�'
FROM
    emp;

-- 2. ������̺��� ����̸��� ��� �̸��� �ι�° ���ں��� �ټ���°����, �տ��� 2��, �ڿ��� 3����
-- ����Ͻÿ�.
-- [���]         ����̸�    2-5����   �տ��� 2��     �ڿ��� 3��
--                  ---------------------------------------
--                  SMITH        MIT         SM               ITH
--		:	:        :                   :
SELECT 
    ename '����̸�',
    MID(ename, 2, 5) '2-5����',
    LEFT(ename, 2),
    RIGHT(ename, 3)
FROM
    emp;

-- 3. ������̺��� ��� �̸��� ���� ������ ����Ͻÿ�. �÷����� '����� ���ڰ���'
--  [���]         ����� ���ڰ���
--                  ----------------
--                       5
--                       :		
SELECT 
    CHAR_LENGTH(ename) '����� ���ڰ���'
FROM
    emp;

-- 4. ������̺��� ��� �̸��� �� ���� �ϳ��� ������ ���� �ϳ��� ����ϵ� 
-- ��� �ҹ��ڷ� ���� ����Ͻÿ�.
--   [���]    �����  ���
--                     -----------------
--                     SMITH   sh   
--                     ALLEN   an   
SELECT 
    LOWER(CONCAT(LEFT(ename, 1), RIGHT(ename, 1))) '����� ���'
FROM
    emp;

-- 5. 3456.78�� �ݿø��Ͽ� �Ҽ��� �Ʒ� ù��° �ڸ� ������ ��Ÿ���ÿ�.
SELECT ROUND(3456.78, 1);

-- 6. ���޿� 50�� ���ϰ� �ʴ����� �����Ͽ� ����ϴµ� ���޵ڿ� '��'�� ���̰� 
--    õ�������� ','�� �ٿ��� ����Ѵ�.
-- [���]	��� ���
-- 		---------------
--          40,000��
-- 			80,000��
-- 			62,500��
-- 			148,700��

SELECT 
    CONCAT(FORMAT(TRUNCATE(sal * 50, - 2), 0),
            '��') '��� ���'
FROM
    emp;

-- 7. ���� �̸��� Ŀ�̼� ���� ���θ� ����ϴµ� �����Ǿ����� Ŀ�̼� ����
--    �������� �ʾ����� '����'�� ����Ͻÿ�.
-- [���]	�����	���	
-- 		---------------------------
-- 			SMITH	����	
-- 			ALLEN	300	
SELECT 
    ename '�����', IFNULL(comm, '����') '���'
FROM
    emp;

-- 8. ���� �̸��� Ŀ�̼� ���� ���θ� ����ϴµ� �����Ǿ����� '������'�� 
--    �������� �ʾ����� '�����ȵ�'�� ����Ͻÿ�.
--  [���] 	�����	���	
-- 		---------------------------
-- 			SMITH	�����ȵ�	
-- 			ALLEN	������	
SELECT 
    ename '�����', IF(comm is null, "�����ȵ�", "������" ) '���'
FROM
    emp;
    
-- 9. ���� �̸��� �μ���ȣ �׸��� �μ���ȣ�� ���� �μ����� ����Ͻÿ�.
--    �μ��� ���� ������ '����' �� ����Ͻÿ�.
--    (�μ��� : 10 �̸� 'A �μ�', 20 �̸� 'B �μ�', 30 �̸� 'C �μ�')
--  [���]  	�����	���	
-- 		---------------------------
-- 			SMITH	B�μ�	
-- 			ALLEN	C�μ�	
SELECT 
    ename '�����',
    deptno '�μ���ȣ',
    CASE deptno
        WHEN '10' THEN 'A �μ�'
        WHEN '20' THEN 'B �μ�'
        WHEN '30' THEN 'C �μ�'
        ELSE '����'
    END '���'
FROM
    emp;
 
-- 10. ���ó�¥�� ���ó�¥���� 10���� ���� ��¥�� ����Ͻÿ�.
SELECT CURDATE(), DATE_ADD(CURDATE(), INTERVAL 10 DAY);

-- 11. ���� �ð��� "....�� ..�� ..�� ..�� ..��" ���� ����Ͻÿ�. �÷����� '����ð�'���� �����Ѵ�.
SELECT DATE_FORMAT(NOW(), '%Y�� %m�� %d�� %H�� %i��') '����ð�';

-- 12. ������ �̸�, ���޿�, ������ ��ȸ�ϴ� ���Ǹ� �ۼ��Ͻÿ�.
-- (��, ������ ������ 200�� �� ���ʽ��� �����Ͽ� ����մϴ�.)
--  [���]   �̸�              ���޿�               ����
-- -------------------------------------------------
-- 	SMITH             800                 12000
-- 	ALLEN            1600                 21600
-- 	WARD             1250                 17400

SELECT 
    ename '�̸�', sal '���޿�', (sal + 200) * 12 '����'
FROM
    emp;

-- 13.  ������ ���� �޿��� 0~1000�̸� 'A', 1001~2000�̸� 'B', 2001~3000�̸� 'C', 
--           3001~4000�̸� 'D', 4001�̻��̸� 'E'�� '�ڵ�'��� ���� ����Ѵ�.
-- 	[��� ]  �̸�      ����   �ڵ� 
--       -----------------------
--          SMITH    800  A    
-- 			ALLEN   1600  B    
-- 		 	WARD    1250  B 
SELECT 
    ename '�̸�',
    sal '����',
    CASE
        WHEN 0 <= sal AND sal <= 1000 THEN 'A'
        WHEN 1000 < sal AND sal <= 2000 THEN 'B'
        WHEN 2000 < sal AND sal <= 3000 THEN 'C'
        WHEN 3000 < sal AND sal <= 4000 THEN 'D'
        WHEN 4000 < sal THEN 'E'
    END '�ڵ�'
FROM
    emp;

-- 14. �̸��� �ι�° ���ڰ� ��A���� ��� ������ �̸��� ��ȸ�ϴ� ���Ǹ� �ۼ��Ͻÿ�.
--          (�� ���� SELECT ����� �ۼ��ϴµ� �ϳ��� like �����ڸ� �ٸ� �ϳ��� �Լ��� �ذ��Ͻÿ�)
-- [��� ]  	ENAME
--       ----------
-- 			WARD 
-- 			MARTIN
-- 			JAMES

SELECT ENAME FROM emp WHERE ename LIKE '_A%';
SELECT ENAME FROM emp WHERE MID(ename, 2, 1) = 'A';

-- 15.   ��� ������ �̸��� ��������� �Ի�Ⱓ�� �������� ��ȸ�ϴ� ���Ǹ� �ۼ��Ͻÿ�
--   (�̶�, �Ի�Ⱓ�� �ش��ϴ� ����Ī�� ��MONTHS WORKED���� �ϰ�,   
--  �Ի�Ⱓ�� ���� ū ������(�Ի����� ������ ��)���� �����Ѵ�.)
-- ��¿�)
-- ENAME         MONTHS WORKED
-- ------------------------------
-- SMITH           491
-- ALLEN           489
SELECT 
    ENAME, TIMESTAMPDIFF(MONTH, hiredate, NOW()) 'MONTHS WORKED'
FROM
    emp
ORDER BY 'MONTHS WORKED' DESC;

-- 16. ������̺��� ����̸��� ������� ���� ��¥������ �ٹ��ϼ��� ���Ͻÿ�.
-- ����̸�   �ٹ��ϼ�
-- -----------------------
-- SMITH    14974��
-- ALLEN    14909��
SELECT 
    ename '����̸�',
    TIMESTAMPDIFF(DAY, hiredate, NOW()) '�ٹ��ϼ�'
FROM
    emp
ORDER BY '�ٹ��ϼ�' DESC;

-- 17. 1981�⵵�� �Ի��� �������� �̸�, ���� �׸��� �Ի����� �Ի��� ������ ����Ͻÿ�.
SELECT 
    ename, job, hiredate
FROM
    emp
WHERE
    YEAR(hiredate) = 1981
ORDER BY hiredate;

-- 18. �������� �������� ������ ����ϴ� SQL  ����� �ۼ��Ͻÿ�.(������ ���ڷ�)
SELECT WEEKDAY('1998-02-05');	-- 3 (��) : 0�� ������
SELECT DAYOFWEEK('1998-02-05'); -- 5 (��) : 1�� �Ͽ��� 

-- 19. �������� �������� ������ ����ϴ� SQL  ����� �ۼ��Ͻÿ�.(������ ���ϸ�����)
SELECT DAYNAME('1998-02-05');

-- 20. ���縦 �������� ���� �¾�� �� ���� �Ǿ����� �� �� �ִ�  SQL ����� �ۼ��Ͻÿ�.
SELECT TIMESTAMPDIFF(MONTH, '1998-02-05', NOW());

-- 21. ������̺��� �̸��� ù���ڰ� A�̰� ������ ���ڰ� N�� �ƴ� �����
-- �̸��� ����Ͻÿ�.
SELECT 
    ename
FROM
    emp
WHERE
    ename LIKE 'A%'
        AND RIGHT(ename, 1) != 'N';

-- 22. ��ձ޿����� ���� �޿��� �޴� �������� ������ȣ, �̸�, ������
-- ����ϵ�, ������ ���� ��� ������ ����Ѵ�.
--  EMPNO ENAME    SAL
-- -------- ------ ----------
-- 7839	KING	5,000��
-- 7788	SCOTT	3,000��
-- 7902	FORD	3,000��
-- 7566	JONES	2,975��
-- 7698	BLAKE	2,850��
-- 7782	CLARK	2,450��
SELECT 
    EMPNO, ENAME, CONCAT(FORMAT(sal, 0), '��')
FROM
    emp
WHERE
    sal > (SELECT 
            AVG(sal)
        FROM
            emp)
ORDER BY sal DESC;

-- 23. 30�� �μ��� ������� ������ �ؿ� �Ի��� �������� �̸�, ����, 
--   �μ���ȣ �׸��� �Ի�⵵�� ����Ѵ�.(30���μ� �����ϰ�)
--   ���� ������ ���� �޴� ������ ����Ѵ�.     
-- Ename        Sal            DeptNo         HireYear
-- -------- ---------- ---------- ----------
--  CLARK        2450      10      	1981 
-- JONES        2975         20      	1981 
-- FORD         3000         20      	1981 
--  KING          5000        10     	 1981
SELECT 
    Ename, Sal, DeptNo, YEAR(hiredate) 'HireYear'
FROM
    emp
WHERE
    YEAR(hiredate) = ANY (SELECT DISTINCT
            YEAR(hiredate)
        FROM
            emp
        WHERE
            deptno = 30)
        AND deptno != 30
ORDER BY sal;

-- 24. 'BLAKE'�� ���� �μ��� �ִ� �������� �̸��� �Ի����� �̴µ� 'BLAKE'�� ���� ����Ѵ�. 
-- ENAME      HIREDATE
-- -------- --------
-- ALLEN       1981-02-20 
-- WARD        1981-02-22 
-- MARTIN    1981-09-28 
-- TURNER     1981-09-08 
-- JAMES        1981-10-03
SELECT 
    ENAME, HIREDATE
FROM
    emp
WHERE
    deptno = (SELECT 
            deptno
        FROM
            emp
        WHERE
            ename = 'BLAKE')
        AND ename != 'BLAKE';

-- 25. �̸��� 'T'�� �����ϰ� �ִ� ������� ���� �μ����� �ٹ��ϰ�
--   �ִ� ������ ������ȣ�� �̸��� ����Ѵ�.(��� ���� ����)
-- EMPNO ENAME     
-- -------- ----------
-- 7902	FORD
-- 7566	JONES
-- 7369	SMITH
-- 7788	SCOTT
-- 7900	JAMES
-- 7844	TURNER
-- 7698	BLAKE
-- 7654	MARTIN
-- 7521	WARD
-- 7499	ALLEN
SELECT 
    EMPNO, ENAME
FROM
    emp
WHERE
    deptno IN (SELECT DISTINCT
            deptno
        FROM
            emp
        WHERE
            ename LIKE '%T%');

-- 26 �޿��� ��ձ޿����� ����,�̸��� S�ڰ� ���� ������ ������
--  �μ����� �ٹ��ϴ� ��� ������ ������ȣ,�̸� �� �޿��� ����Ͻÿ�.(��� ���� ����)
-- EMPNO      ENAME      SAL
-- --------  --------  -------
-- 7902	     FORD	      3000
-- 7566	     JONES      2975
-- 7788	     SCOTT      3000
-- 7698	     BLAKE      2850
SELECT 
    EMPNO, ENAME, SAL
FROM
    emp
WHERE
    sal > (SELECT 
            AVG(sal)
        FROM
            emp)
        AND deptno IN (SELECT DISTINCT
            deptno
        FROM
            emp
        WHERE
            ename LIKE '%S%');

-- 27. 30�� �μ��� �ִ� ������ �߿��� ���� ���� ������ �޴� ��������
--   ���� ������ �޴� �������� �̸�, �μ���ȣ, ������ ����Ѵ�. 
--   (��, ALL �Ǵ� ANY �����ڸ� ����� ��)
--  �̸�    �μ���ȣ   ����
-- ------------------------------
-- JONES	20	2975
-- SCOTT	20	3000
-- FORD	20	3000
-- KING	10	5000
SELECT 
    ename '�̸�', deptno '�μ���ȣ', sal '����'
FROM
    emp
WHERE
    sal > ALL (SELECT 
            sal
        FROM
            emp
        WHERE
            deptno = 30)
ORDER BY sal;

-- 28. SALES �μ����� ���ϴ� �������� �μ���ȣ, �̸�, ������ ����Ѵ�.
-- �μ� ����    ������       ����      
-- -------- ---------- ---------
-- 30�� �μ�  ALLEN	       SALESMAN
-- 30�� �μ�  WARD	       SALESMAN
-- 30�� �μ�  MARTIN      SALESMAN
-- 30�� �μ�  BLAKE	       MANAGER
-- 30�� �μ�  TURNER      SALESMAN
-- 30�� �μ�  JAMES	       CLERK
SELECT 
    CONCAT(emp.deptno, '�� �μ�') '�μ� ����',
    emp.ename '������',
    emp.job '����'
FROM
    emp
        JOIN
    dept ON emp.DEPTNO = dept.DEPTNO
WHERE
    dept.DNAME = 'SALES';
 
-- 29. 'KING'���� �����ϴ� ��� ������ �̸��� �Ի糯¥�� ����Ѵ�. 
--     (KING���� �����ϴ� �����̶� mgr�� KING�� ������ �ǹ���) 
-- �̸�         �Ի糯¥
-- -------- ----------
-- JONES	   1981�� 04�� 02��
-- BLAKE	   1981�� 05�� 01��
-- CLARK   1981�� 06�� 09��

SELECT 
    ename '�̸�', hiredate '�Ի糯¥'
FROM
    emp
WHERE
    mgr = (SELECT 
            empno
        FROM
            emp
        WHERE
            ename = 'KING');

-- 30. �̸��� ���� ������ 5 �ʰ��� �������� ������ ����Ѵ�.
--  EMPNO ENAME  JOB      MGR  HIREDATE   SAL  COMM DEPTNO 
-- --------------------------------------------------------------
--  7654 MARTIN SALESMAN 7698 1981-09-28 1250  300     30 
--  7844 TURNER SALESMAN 7698 1981-09-08 1500    0     30 
--  7934 MILLER CLERK    7782 1982-01-23 1300 NULL     10
SELECT 
    *
FROM
    emp
WHERE
    CHAR_LENGTH(ename) > 5;
