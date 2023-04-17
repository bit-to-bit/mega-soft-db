SELECT 'YOUNGEST' TYPE,
        NAME      NAME,
        BIRTHDAY  BIRTHDAY        
  FROM worker w 
 WHERE w.BIRTHDAY = (SELECT MAX(z.BIRTHDAY) FROM worker z)  
 
 UNION ALL 

SELECT 'ELDEST'   TYPE,
        NAME      NAME,
        BIRTHDAY  BIRTHDAY        
  FROM worker w 
 WHERE w.BIRTHDAY = (SELECT MIN(z.BIRTHDAY) FROM worker z)   
  
  
 
  