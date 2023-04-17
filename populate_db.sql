DELETE FROM project_worker;
DELETE FROM project;
DELETE FROM worker;
DELETE FROM client;

-- Generate random data into table worker 

WITH l as (SELECT rownum() ID, levels.level LEVEL FROM TABLE(level VARCHAR = ('Trainee', 'Junior', 'Middle', 'Senior')) levels),
     n as (SELECT * FROM TABLE(name VARCHAR = ('Bill', 'Elon', 'Bob', 'Jon', 'Mark', 'Jeremy', 'Harry', 'Thomas', 'Oscar', 'George', 'Jacob', 'Jim', 'Evan', 'Tom', 'Richard')) name)

INSERT INTO worker (NAME, BIRTHDAY, LEVEL, SALARY)

SELECT t.name                                                              NAME, 
       DATEADD('DAY', CONVERT(ROUND(RAND()*38351),INT), DATE '1901-01-01') BIRTHDAY, 
      (SELECT l.level FROM l WHERE l.ID = t.RANDOM_LEVEL)                  LEVEL,
       CONVERT(ROUND(RAND()*99900+100),int)                                SALARY 

FROM (SELECT n.name NAME, ROUND(RAND()*3+1) RANDOM_LEVEL FROM n) t; 

UPDATE worker w SET w.SALARY = CASE WHEN w.SALARY < 1000 THEN w.SALARY ELSE 999 END WHERE w.SALARY = (SELECT MIN(z.SALARY) FROM worker z) FETCH FIRST 1 ROWS ONLY; 

UPDATE worker w SET w.SALARY = CASE WHEN w.SALARY > 5000 THEN w.SALARY ELSE 99999 END WHERE w.SALARY = (SELECT MAX(z.SALARY) FROM worker z) FETCH FIRST 1 ROWS ONLY; 

UPDATE worker w
   SET w.LEVEL = 'Trainee'
 WHERE NOT EXISTS (SELECT 1 FROM worker t WHERE t.LEVEL = 'Trainee')
   AND w.LEVEL = (SELECT w.LEVEL FROM worker w GROUP BY w.LEVEL ORDER BY COUNT(w.ID) DESC FETCH FIRST 1 ROWS ONLY)
 FETCH FIRST 1 ROWS ONLY;
 
 UPDATE worker w
   SET w.LEVEL = 'Junior'
 WHERE NOT EXISTS (SELECT 1 FROM worker t WHERE t.LEVEL = 'Junior')
   AND w.LEVEL = (SELECT w.LEVEL FROM worker w GROUP BY w.LEVEL ORDER BY COUNT(w.ID) DESC FETCH FIRST 1 ROWS ONLY)
 FETCH FIRST 1 ROWS ONLY;

UPDATE worker w
   SET w.LEVEL = 'Middle'
 WHERE NOT EXISTS (SELECT 1 FROM worker t WHERE t.LEVEL = 'Middle')
   AND w.LEVEL = (SELECT w.LEVEL FROM worker w GROUP BY w.LEVEL ORDER BY COUNT(w.ID) DESC FETCH FIRST 1 ROWS ONLY)
 FETCH FIRST 1 ROWS ONLY;

UPDATE worker w
   SET w.LEVEL = 'Senior'
 WHERE NOT EXISTS (SELECT 1 FROM worker t WHERE t.LEVEL = 'Senior')
   AND w.LEVEL = (SELECT w.LEVEL FROM worker w GROUP BY w.LEVEL ORDER BY COUNT(w.ID) DESC FETCH FIRST 1 ROWS ONLY)
 FETCH FIRST 1 ROWS ONLY;

-- Generate random data into table client

INSERT INTO client(NAME)
SELECT names.NAME FROM TABLE(name VARCHAR = ('Olivia', 'Emma', 'Charlotte', 'Amelia', 'Ava', 'Sophia', 'Isabella', 'Mia', 'Evelyn', 'Harper')) names;

-- Generate random data into table project
 
INSERT INTO project (CLIENT_ID, START_DATE) 

SELECT c.ID                                                                CLIENT_ID, 
       DATEADD('DAY', CONVERT(ROUND(RAND()*2*365),INT), DATE '2023-01-01') START_DATE
  FROM client c,
       SYSTEM_RANGE(1, 100) r
 WHERE RAND() BETWEEN 0.25 AND 1;
 
UPDATE project p SET p.FINISH_DATE = DATEADD('MONTH', CONVERT(ROUND(RAND()*99+1),INT), p.START_DATE); 

-- Generate random data into table project_worker

WITH worker_set AS (SELECT p.ID                           PROJECT_ID,
                           w.ID                           WORKER_ID, 
                           RAND()                         WORKER_RATE
                      FROM project p,
                           worker w),

     project_set AS (SELECT ID                             PROJECT_ID,
                            CONVERT(ROUND(RAND()*4+1),INT) COUNT_WORKER
                       FROM project)       
       
INSERT INTO project_worker(PROJECT_ID, WORKER_ID)
SELECT w.PROJECT_ID, w.WORKER_ID
  FROM (SELECT s.PROJECT_ID                                                         PROJECT_ID,
              s.WORKER_ID                                                          WORKER_ID,
              ROW_NUMBER() OVER (PARTITION BY s.PROJECT_ID ORDER BY s.WORKER_RATE) RANG
         FROM worker_set s) w
 WHERE w.RANG <= (SELECT p.COUNT_WORKER FROM project_set p WHERE w.PROJECT_ID = p.PROJECT_ID)
 ORDER BY w.PROJECT_ID, w.WORKER_ID;