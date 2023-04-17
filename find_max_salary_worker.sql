SELECT w.NAME,
       w.SALARY
  FROM worker w
 WHERE w.SALARY = (SELECT MAX(z.SALARY) FROM worker z);