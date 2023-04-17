WITH client_project_count AS (SELECT client_id, count(*) project_count FROM project GROUP BY client_id)

SELECT c.name, p.project_count
  FROM client c INNER JOIN client_project_count p ON c.id = p.client_id
 WHERE p.project_count = (SELECT MAX(z.project_count) FROM client_project_count z);    