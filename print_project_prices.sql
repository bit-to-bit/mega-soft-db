SELECT 'Project ' || p.ID || (SELECT ' [' || c.NAME || ']' FROM client c WHERE c.id = p.CLIENT_ID) NAME,
       DATEDIFF(MONTH, p.START_DATE, p.FINISH_DATE)*
      (SELECT SUM(w.SALARY)
         FROM project_worker pw,
              worker w
        WHERE pw.PROJECT_ID = p.ID
          AND pw.WORKER_ID = w.ID)                                                                 PRICE
  FROM project p
 ORDER BY PRICE DESC; 