DROP TABLE worker; 

CREATE TABLE worker(
    ID BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NAME VARCHAR(1000) CHECK (CHAR_LENGTH(NAME) >= 2),
    BIRTHDAY DATE CHECK (EXTRACT(YYYY FROM BIRTHDAY) > 1900),
    LEVEL VARCHAR(7) NOT NULL CHECK (LEVEL IN ('Trainee', 'Junior', 'Middle', 'Senior')),
    SALARY INTEGER CHECK (SALARY BETWEEN 100 AND 100000)
);

COMMENT ON TABLE worker IS 'Працівники'; 
COMMENT ON COLUMN worker.ID IS 'ID працівника'; 
COMMENT ON COLUMN worker.name IS 'Імя працівника'; 
COMMENT ON COLUMN worker.birthday IS 'Дата народження'; 
COMMENT ON COLUMN worker.level IS 'Рівень технічного розвитку працівника'; 
COMMENT ON COLUMN worker.level IS 'Заробітна плата працівника за 1 місяць, грн.'; 

DROP TABLE client;

CREATE TABLE client(
    ID BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NAME VARCHAR(1000) CHECK (CHAR_LENGTH(NAME) >= 2) 
);  
COMMENT ON TABLE client IS 'Клієнти'; 
COMMENT ON COLUMN client.ID IS 'ID клієнта'; 
COMMENT ON COLUMN client.name IS 'Імя клієнта';

DROP TABLE project;

CREATE TABLE project(
    ID BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    CLIENT_ID BIGINT, 
    START_DATE DATE,
    FINISH_DATE DATE
);

COMMENT ON TABLE project IS 'Проекти'; 
COMMENT ON COLUMN project.ID IS 'ID проекта'; 
COMMENT ON COLUMN project.CLIENT_ID IS 'ID клієнта, що замовив цей проєкт'; 
COMMENT ON COLUMN project.START_DATE IS 'Дата початку виконання проєкту'; 
COMMENT ON COLUMN project.FINISH_DATE IS 'Дата кінця виконання проєкту'; 

DROP TABLE project_worker;

CREATE TABLE project_worker(
    PROJECT_ID BIGINT NOT NULL,
    WORKER_ID BIGINT NOT NULL,
    PRIMARY KEY (PROJECT_ID, WORKER_ID)
);     

COMMENT ON TABLE project_worker IS 'Працівники, призначені на проекти';     
COMMENT ON COLUMN project_worker.PROJECT_ID IS 'ID проекта'; 
COMMENT ON COLUMN project_worker.WORKER_ID IS 'ID працівника';