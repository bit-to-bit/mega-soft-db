DROP TABLE worker; 

CREATE TABLE worker(
    ID BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NAME VARCHAR(1000) CHECK (CHAR_LENGTH(NAME) >= 2),
    BIRTHDAY DATE CHECK (EXTRACT(YYYY FROM BIRTHDAY) > 1900),
    LEVEL VARCHAR(7) NOT NULL CHECK (LEVEL IN ('Trainee', 'Junior', 'Middle', 'Senior')),
    SALARY INTEGER CHECK (SALARY BETWEEN 100 AND 100000)
);

COMMENT ON TABLE worker IS '����������'; 
COMMENT ON COLUMN worker.ID IS 'ID ����������'; 
COMMENT ON COLUMN worker.name IS '��� ����������'; 
COMMENT ON COLUMN worker.birthday IS '���� ����������'; 
COMMENT ON COLUMN worker.level IS 'г���� ��������� �������� ����������'; 
COMMENT ON COLUMN worker.level IS '�������� ����� ���������� �� 1 �����, ���.'; 

DROP TABLE client;

CREATE TABLE client(
    ID BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NAME VARCHAR(1000) CHECK (CHAR_LENGTH(NAME) >= 2) 
);  
COMMENT ON TABLE client IS '�볺���'; 
COMMENT ON COLUMN client.ID IS 'ID �볺���'; 
COMMENT ON COLUMN client.name IS '��� �볺���';

DROP TABLE project;

CREATE TABLE project(
    ID BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    CLIENT_ID BIGINT, 
    START_DATE DATE,
    FINISH_DATE DATE
);

COMMENT ON TABLE project IS '�������'; 
COMMENT ON COLUMN project.ID IS 'ID �������'; 
COMMENT ON COLUMN project.CLIENT_ID IS 'ID �볺���, �� ������� ��� �����'; 
COMMENT ON COLUMN project.START_DATE IS '���� ������� ��������� ������'; 
COMMENT ON COLUMN project.FINISH_DATE IS '���� ���� ��������� ������'; 

DROP TABLE project_worker;

CREATE TABLE project_worker(
    PROJECT_ID BIGINT NOT NULL,
    WORKER_ID BIGINT NOT NULL,
    PRIMARY KEY (PROJECT_ID, WORKER_ID)
);     

COMMENT ON TABLE project_worker IS '����������, ��������� �� �������';     
COMMENT ON COLUMN project_worker.PROJECT_ID IS 'ID �������'; 
COMMENT ON COLUMN project_worker.WORKER_ID IS 'ID ����������';