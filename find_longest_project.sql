WITH project_months as (
SELECT project.ID                                               ID,
       project.CLIENT_ID                                        CLIENT_ID, 
       DATEDIFF(MONTH, project.START_DATE, project.FINISH_DATE) MONTH_COUNT
  FROM project)

SELECT 'Project ' || p.ID || (SELECT ' [' || c.NAME || ']' FROM client c WHERE c.id = p.CLIENT_ID) NAME,
       p.month_count                                                                               MONTH_COUNT
  FROM project_months p
 WHERE p.MONTH_COUNT = (SELECT MAX(m.MONTH_COUNT) FROM project_months m);   
 