use sql_queries_practice;

-- Fresh Start
drop table if exists EMP;
drop table if exists DEPT;

-- Create Department Table
create table if not exists DEPT(
DEPTNO int not null,
DNAME varchar(255),
LOC varchar(255),
primary key (DEPTNO)
);
-- Populate Department Table
insert into DEPT 
(DEPTNO, DNAME, LOC) 
values
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

-- Create Employee Table
create table if not exists EMP(
EMPNO int not null, 
ENAME varchar(255),
JOB varchar(255), 
MGR int, 
HIREDATE date, 
SAL int,
COMM int, 
DEPTNO int,
primary key (EMPNO),
foreign key (DEPTNO) references DEPT(DEPTNO)
);
-- Populate Employee Table
insert into EMP 
(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) 
values
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1982-12-09', 3000, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1983-01-12', 1100, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);



-- Q1. Display all the information of the EMP table?
select * from EMP;

-- Q2. Display unique Jobs from EMP table?
select distinct JOB from EMP;
-- select unique JOB from EMP;

-- Q3. List the emps in the asc order of their Salaries?
select * from EMP order by SAL asc;

-- Q4. List the details of the emps in asc order of the Deptnos and desc of Jobs?
select * from EMP order by DEPTNO asc, JOB desc;

-- Q5. Display all the unique job groups in the descending order?
select distinct JOB from EMP order by JOB desc;

-- **Q6. Display all the details of all ‘Mgrs’
select * from EMP where EMPNO in (select MGR from EMP);

-- Q7. List the emps who joined before 1981.
select * from EMP where year(HIREDATE) < 1981; -- MySQL only
select * from EMP where HIREDATE < ('1981-01-01');

-- Q8. List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal.
select EMPNO, ENAME, SAL, (SAL / 30) as DAILYSAL, (SAL * 12) as ANNSAL from EMP order by ANNSAL asc;

-- Q9. Display the Empno, Ename, job, Hiredate, Exp of all Mgrs
select EMPNO, ENAME, JOB, HIREDATE, datediff(now(), HIREDATE) EXP from EMP where EMPNO in (select MGR from EMP);

-- Q10. List the Empno, Ename, Sal, Exp of all emps working for Mgr 7698.
select empno, ename, sal, datediff(now(), hiredate) exp from emp where mgr = 7698;

-- Q11. Display all the details of the emps whose Commission is more than their Salary
select * from emp where comm > sal;

-- Q12. List the emps in the asc order of Designations of those joined after the second half of 1981.
select * from emp where hiredate > ('1981-06-30') and year(hiredate) = 1981 order by job asc;

-- **Q13. List the emps along with their Exp and Daily Sal is more than Rs.100
select *, datediff(now(), hiredate) exp, (sal / 30) dailysal from emp having dailysal > 100;
-- select * from emp where (sal/30) > 100;
-- NOTE: MySQL doesn't allow aliases using WHERE, instead use HAVING

-- Q14. List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order.
select * from emp where job = 'CLERK' or job = 'ANALYST' order by job desc;

-- **Q15. List the emps who joined on 1-MAY-81, 3-DEC-81, 17-DEC-81, 19-JAN-80 in asc order of seniority.
select * from emp where hiredate in ('1981-05-01', '1981-12-03', '1981-12-17', '1980-01-19') order by datediff(now(), hiredate) asc;
-- NOTE: When refering to multiple values in WHERE, you can use WHERE value IN (value1, val2, val3) instead of WHERE value = value1 or ...

-- Q16. List the emp who are working for the Deptno 10 or 20.
select * from emp where deptno in (10, 20);
select * from emp where deptno = 10 or deptno = 20;

-- Q17. List the emps who are joined in the year 1981.
select * from emp where year(hiredate) = '1981'; -- MySQL only
select * from emp where hiredate between '1981-01-01' and '1981-12-31';

-- Q18. List the emps who are joined in the month of Aug 1980.
select * from emp where year(hiredate) = '1980' and month(hiredate) = '8'; -- MySQL only
select * from emp where hiredate between '1980-08-01' and '1980-08-31';

-- Q19. List the emps whose Annual sal is ranging from 22000 and 45000.
select * from emp where (sal * 12) between 22000 and 45000;

-- Q20. List the Enames those are having five characters in their Names.
select ename from emp where length(ename) = 5;

-- Q21. List the Enames those are starting with ‘S’ and with five characters.
select ename from emp where left(ename, 1) = 'S' and length(ename) = 5;
select ename from emp where ename like 'S%' and length (ename) = 5;
-- NOTE: '%' refers to arbitrary length of characters (REGEX)
-- NOTE: Use 'LIKE' for string comparison

-- Q22. List the emps those are having four chars and third character must be ‘R’.
select * from emp where length(ename) = 4 and mid(ename, 3, 1) = 'R';
select * from emp where length(ename) = 4 and ename like '__R%';
-- NOTE: '_' refers to any character (REGEX)

-- **Q23. List the Five character names starting with ‘S’ and ending with ‘H’.
select * from emp where length(ename) = 5 and left(ename, 1) = 'S' and right(ename, 1) = 'H'; -- Slower??
select * from emp where length(ename) = 5 and ename like 'S%' and ename like '%H';
select * from emp where length(ename) = 5 and ename like 'S%H';

-- **Q24. List the emps who joined in January.
select * from emp where month(hiredate) = 1; -- MySQL only
select * from emp where hiredate like '%-01-%';

-- Q25. List the emps who joined in the month of which second character is ‘a’. (jan, march, may)
select * from emp where month(hiredate) in ('01', '03', '05');
-- select * from emp where to_char(hiredate,’mon’)  like ‘_a_’;
-- select * from emp where to_char(hiredate,’mon’) like ‘_a%’;

-- Q26. List the emps whose Sal is four digit number ending with Zero.
select * from emp where length(sal) = 4 and sal like '%0';

-- Q27. List the emps whose names having a character set ‘ll’ together.
select * from emp where ename like '%ll%';

-- Q28. List the emps those who joined in 80’s.
select * from emp where year(hiredate) >= '1980' and year(hiredate) < '1990'; -- MySQL only
select * from emp where hiredate between '1980-01-01' and '1989-12-31';
select * from emp where hiredate like '__8%';

-- Q29. List the emps who does not belong to Deptno 20.
select * from emp where deptno != 20;
select * from emp where deptno <> 20;
select * from emp where deptno not in (20);
select * from emp where deptno not like (20);
-- NOTE: <> is the same as != 

-- Q30. List all the emps except ‘PRESIDENT’ & ‘MGR” in asc order of Salaries.
select * from emp where job not in ('PRESIDENT', 'MANAGER') order by sal asc;
select * from emp where job not like 'PRESIDENT' and job not like 'MANAGER' order by sal asc;
select * from emp where job != 'PRESIDENT' and job != 'MANAGER' order by sal asc;
select * from emp where job <> 'PRESIDENT' and job <> 'MANAGER' order by sal asc;

-- Q31. List all the emps who joined before or after 1981.
select * from emp where year(hiredate) < 1981 or year(hiredate) > 1981; -- MySQL only
select * from emp where hiredate not between '1981-01-01' and '1981-12-31';
select * from emp where hiredate not like '__81%';

-- Q32. List the emps whose Empno not starting with digit 78
select * from emp where left(empno, 2) != '78';
select * from emp where left(empno, 2) <> '78';
select * from emp where empno not like '78%';

-- **Q33. List the emps who are working under ‘MGR’.
select * from emp where mgr is not null;
select concat(e.ename, ' works for ', m.ename) as chain_of_command from emp e ,emp m where e.mgr = m.empno;
-- select e.ename || ' works for ' || m.ename  from emp e ,emp m where e.mgr = m.empno ; -- SQL specific
-- NOTE: || can be used to concatenate strings in SQL, but in MySQL use concat() function instead

-- Q34. List the emps who joined in any year but not belongs to the month of March.
select * from emp where month(hiredate) != 3;
select * from emp where month(hiredate) <> 3;
select * from emp where hiredate not like '%-03-%';

-- Q35. List all the Clerks of Deptno 20.
select * from emp where job = 'CLERK' and deptno = 20;

-- Q36. List the emps of Deptno 30 or 10 joined in the year 1981.
select * from emp where (deptno = 10 or deptno = 30) and year(hiredate) = 1981;
select * from emp where deptno in (10, 30) and year(hiredate) = 1981;
select * from emp where deptno in (10, 30) and hiredate like '1981%';
select * from emp where (deptno like '1%' or deptno like '3%') and hiredate like '%81%';

-- Q37. Display the details of SMITH.
select * from emp where ename = 'SMITH';
select * from emp where ename in ('SMITH');
select * from emp where ename like 'SMITH';

-- **Q38. Display the location of SMITH.
select loc from emp e, dept d where e.ename = 'SMITH' and e.deptno = d.deptno;

-- **Q39. List the total information of EMP table along with DNAME and Loc of all the emps Working Under ‘ACCOUNTING’ & ‘RESEARCH’ in the asc Deptno.
select e.*, d.DNAME, d.LOC from emp e, dept d where (d.dname = 'ACCOUNTING' or d.dname = 'RESEARCH') and e.deptno = d.deptno order by d.deptno asc;
select * from emp e ,dept d where d.dname in ('ACCOUNTING', 'RESEARCH') and e.deptno = d.deptno order by e.deptno asc;
-- NOTE: DON'T FORGET TO EQUATE KEYS! i.e. e.deptno = d.deptno

-- **Q40. List the Empno, Ename, Sal, Dname of all the ‘MGRS’ and ‘ANALYST’ working in New York, Dallas with an exp more than 7 years without receiving the Comm asc order of Loc.
select e.empno, e.ename, e.sal, d.dname 
	from emp e, dept d 
	where e.deptno = d.deptno 
    and e.job in ('MANAGER', 'ANALYST') 
    and d.loc in ('NEW YORK', 'DALLAS')
    and ((datediff(now(), e.hiredate) / 365) > 7)
    and (e.comm is null)
    order by d.loc asc;
select e.empno,e.ename,e.sal,d.dname 
	from emp e ,dept d 
	where  d.loc in ('NEW YORK','DALLAS') 
    and e.deptno = d.deptno
    and e.empno in (
		select e.empno from emp e 
			where e.job in ('MANAGER','ANALYST') 
			and ((datediff(now(), e.hiredate) / 365) > 7) 
            and e.comm is null)
    order by d.loc  asc;
-- select e.empno from emp e where e.job in ('MANAGER','ANALYST') and ((datediff(now(), e.hiredate) / 365) > 7) and e.comm is null;

--  ***Q41. Display the Empno, Ename, Sal, Dname, Loc, Deptno, Job of all emps working at CHICAGO or working for 
--  ACCOUNTING dept with Ann Sal>28000, but the Sal should not be=3000 or 2800 who doesn’t belongs to the Mgr 
--  and whose no is having a digit ‘7’ or ‘8’ in 3rd position in the asc order of Deptno and desc order of job.

select e.empno, e.ename, e.sal, d.dname, d.loc, d.deptno, e.job from emp e, dept d 
	where (e.deptno = d.deptno) 
    and (d.loc = 'CHICAGO' or d.dname = 'ACCOUNTING') 
		and (sal * 12) > 28000 
		and case when (mgr is null 
			and (empno like '__7%' 
				or empno like '__8%')) 
		then (sal <> 3000 
			or sal <> 2800) end
	order by d.deptno asc, e.job desc;
# NOTE: I used CASE when I should've used NESTED SELECT statements!!! (PRACTICE THIS!)
select E.empno, E.ename, E.sal, D.dname, D.loc, E.deptno, E.job from emp E, dept D
	where (D.loc = 'CHICAGO' or D.dname = 'ACCOUNTING') 
    and E.deptno = D.deptno 
    and E.empno in 
		(select E.empno from emp E 
			where (12*E.sal) > 28000 
            and  E.sal not in (3000,2800)
            and E.job !='MANAGER'
	and (E.empno like '__7%' or E.empno like '__8%'))
order by E.deptno asc, E.job desc;

-- Clean Up
drop table if exists EMP;
drop table if exists DEPT;