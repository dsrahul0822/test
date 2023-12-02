CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CONSTRAINT_ENABLE`()
BEGIN
    
	DECLARE PROCESS_NAME VARCHAR(30);
    DECLARE OPERATION_TYPE VARCHAR(50);
    DECLARE LOG_DETAILS VARCHAR(50);
    
    
    SET OPERATION_TYPE = 'ADDING CONSTRIANT';
    SET PROCESS_NAME = 'SP_CONSTRAINT_ENABLE';


ALTER TABLE TBL_FNL_EMPLOYEES ADD CONSTRAINT PK_EMP_ID PRIMARY KEY (EMPLOYEE_ID);
ALTER TABLE TBL_FNL_DEPARTMENTS ADD CONSTRAINT PK_DEPT_ID  PRIMARY KEY (DEPARTMENT_ID);
ALTER TABLE TBL_FNL_LOCATIONS ADD CONSTRAINT  PK_LOC_ID PRIMARY KEY (LOCATION_ID);
ALTER TABLE TBL_FNL_COUNTRIES ADD CONSTRAINT  PK_CNTRY_ID PRIMARY KEY (COUNTRY_ID);
ALTER TABLE TBL_FNL_REGIONS ADD CONSTRAINT PK_REG_ID PRIMARY KEY (REGION_ID);
ALTER TABLE TBL_FNL_JOBS ADD CONSTRAINT PK_JOB_ID PRIMARY KEY (JOB_ID);

ALTER TABLE TBL_FNL_EMPLOYEES
ADD CONSTRAINT FK_EMP_EMP FOREIGN KEY (MANAGER_ID) REFERENCES TBL_FNL_EMPLOYEES(EMPLOYEE_ID);
ALTER TABLE TBL_FNL_EMPLOYEES
ADD CONSTRAINT FK_EMP_DEPT FOREIGN KEY (DEPARTMENT_ID) REFERENCES TBL_FNL_DEPARTMENTS(DEPARTMENT_ID);
ALTER TABLE TBL_FNL_DEPARTMENTS
ADD CONSTRAINT FK_DEPT_EMP FOREIGN KEY (MANAGER_ID) REFERENCES TBL_FNL_EMPLOYEES(EMPLOYEE_ID);
ALTER TABLE TBL_FNL_DEPARTMENTS
ADD CONSTRAINT FK_DEPT_LOC FOREIGN KEY (LOCATION_ID) REFERENCES TBL_FNL_LOCATIONS(LOCATION_ID);
ALTER TABLE TBL_FNL_LOCATIONS
ADD CONSTRAINT FK_LOC_COUNTRY FOREIGN KEY (COUNTRY_ID) REFERENCES TBL_FNL_COUNTRIES(COUNTRY_ID);
ALTER TABLE TBL_FNL_COUNTRIES
ADD CONSTRAINT FK_COUNTRY_REG FOREIGN KEY (REGION_ID) REFERENCES TBL_FNL_REGIONS(REGION_ID);
ALTER TABLE TBL_FNL_JOB_HISTORY 
ADD CONSTRAINT FK_JH_EMP FOREIGN KEY (EMPLOYEE_ID) REFERENCES TBL_FNL_EMPLOYEES(EMPLOYEE_ID);
ALTER TABLE TBL_FNL_JOB_HISTORY 
ADD CONSTRAINT FK_JH_JOBS FOREIGN KEY (JOB_ID) REFERENCES TBL_FNL_JOBS(JOB_ID);
ALTER TABLE TBL_FNL_JOB_HISTORY 
ADD CONSTRAINT FK_JH_DEPT FOREIGN KEY (DEPARTMENT_ID) REFERENCES TBL_FNL_DEPARTMENTS(DEPARTMENT_ID);    
  
  /*  IF SOURCE1_COUNT <> TARGET1_COUNT THEN
        SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
    ELSE
        SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
    END IF;
    */
    INSERT INTO HRDB_SYS_AUDIT_CONTROL 
    (
    PROCESS_NAME,
    OPERATION_TYPE,
    OPERATED_BY,
	OPERATION_DATE)
    VALUES 
        (
        PROCESS_NAME,
        OPERATION_TYPE,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());
        

END