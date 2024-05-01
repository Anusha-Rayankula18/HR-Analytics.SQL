create database Employee;
drop database employee;
use employee;
Create table Employee (
empno Integer not null primary key,
ename varchar (255) not null,
job varchar (255) default 'CLERK',
mgr integer,
hiredate date not null,
sal decimal(7,2) check (sal >=0),
comm decimal(7,2),
deptno integer,
constraint empno_unique unique (empno)
);
insert into Employee (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7369,'SMITH','CLERK',7902,'1890-12-17',800.00,NULL,20),
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600.00,300.00,30),
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250.00,500.00,30),
(7566,'JONES','MANAGER',7839,'1981-04-02',2975.00,null,20),
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250.00,1400.00,30),
(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850.00,NULL,30),
(7782,'CLARK','MANAGER',7839,'1981-06-09',2450.00,NULL,10),
(7788,'SCOTT','ANALYST',7566,'1987-04-19',3000.00,NULL,20),
(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000.00,NULL,10),
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500.00,0.00,30),
(7876,'ADAMS','CLERK',7788,'1987-05-23',1100.00,NULL,20),
(7900,'JAMES','CLERK',7698,'1981-12-03',950.00,NULL,30),
(7902,'FORD','ANALYST',7566,'1981-12-03',3000.00,NULL,20),
(7934,'MILLER','CLERK',7782,'1982-01-23',1300.00,NULL,10);

select *from employee;

## Q2. List the Names and salary of the employees whose salary is greater than 1000.

Select ename,sal
from employee
where sal>1000;

## Q3. List the Employee Names Whose Names Start with either A or S.

Select ename
from employee
where ename like 'A%' or ename like 'S%';

## Q4. List Average Monthly salary for each job within each department.

select deptno, job, avg(sal) As average_sal
from employee
Group By deptno, job
Order by deptno, job;

## Q5. Display the empno, emp name, and the manager name under whom the employee works.

select e.empno, e.ename as employee_name, m.ename as manager_name
from employee e
left join employee m on e.mgr = m.empno;

select *from employee;

##Q6. Display empname,department no., salary, rank of salary in organisation. Rank of salary in their respective department.

with rankedemployees as(
select
ename,
deptno,
sal,
dense_rank() over (order by sal desc) as rank_in_organisation,
Rank() over (partition by deptno order by sal desc) as rank_in_department
from employee
)
select ename,deptno,sal, rank_in_organisation,rank_in_department
from rankedemployees;
