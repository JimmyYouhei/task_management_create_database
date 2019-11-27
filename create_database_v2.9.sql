DROP DATABASE IF EXISTS TaskManagement;

CREATE DATABASE TaskManagement;

USE TaskManagement;

CREATE TABLE staff (
	id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    date_of_birth DATE,
    phone_number VARCHAR(255),
    email VARCHAR(255),
    facebook VARCHAR(255),
    office_id INT,
    create_by INT , 
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_by INT,
    update_time TIMESTAMP NULL DEFAULT NULL,
    

	FOREIGN KEY(create_by) REFERENCES staff(id),
	FOREIGN KEY(update_by) REFERENCES staff(id),
    
    CONSTRAINT staff_unique UNIQUE(full_name , date_of_birth)
);

CREATE TABLE office(
	id INT AUTO_INCREMENT PRIMARY KEY,
	address VARCHAR(255) NOT NULL,
    person_in_charge_id INT , 
	create_by INT , 
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_by INT,
    update_time TIMESTAMP NULL DEFAULT NULL,

	FOREIGN KEY(create_by) REFERENCES staff(id),
	FOREIGN KEY(update_by) REFERENCES staff(id), 
	FOREIGN KEY(person_in_charge_id) REFERENCES staff(id),

	UNIQUE(address)
);

ALTER TABLE staff ADD FOREIGN KEY(office_id) REFERENCES office(id);

CREATE TABLE team(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    
	create_by INT , 
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_by INT,
    update_time TIMESTAMP NULL DEFAULT NULL,
    
	FOREIGN KEY(create_by) REFERENCES staff(id),
	FOREIGN KEY(update_by) REFERENCES staff(id),
    
    UNIQUE(name)
); 

CREATE TABLE staff_team(

	id INT AUTO_INCREMENT PRIMARY KEY,
	staff_id INT NOT NULL,
    team_id INT NOT NULL ,
    
	create_by INT , 
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_by INT,
    update_time TIMESTAMP NULL DEFAULT NULL,
    
	FOREIGN KEY(create_by) REFERENCES staff(id),
	FOREIGN KEY(update_by) REFERENCES staff(id), 
    
	FOREIGN KEY(staff_id) REFERENCES staff(id),
	FOREIGN KEY(team_id) REFERENCES team(id),
    
    CONSTRAINT st_unique UNIQUE(staff_id , team_id)

);

CREATE TABLE project(
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT , 
    note TEXT , 
    
	create_by INT , 
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_by INT,
    update_time TIMESTAMP NULL DEFAULT NULL,
    
	FOREIGN KEY(create_by) REFERENCES staff(id),
	FOREIGN KEY(update_by) REFERENCES staff(id),

	UNIQUE(name)
);

CREATE TABLE team_project(
	id INT AUTO_INCREMENT PRIMARY KEY,
	team_id INT NOT NULL,
    project_id INT NOT NULL, 

	create_by INT , 
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_by INT,
    update_time TIMESTAMP NULL DEFAULT NULL,
    
	FOREIGN KEY(create_by) REFERENCES staff(id),
	FOREIGN KEY(update_by) REFERENCES staff(id),
	FOREIGN KEY(team_id) REFERENCES team(id),
	FOREIGN KEY(project_id) REFERENCES project(id),
    
    CONSTRAINT tp_unique UNIQUE (team_id , project_id)
    
);

CREATE TABLE task_category(
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    project_id INT,
    name VARCHAR(255) NOT NULL,
    description TEXT, 
    note TEXT, 
    
	create_by INT , 
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_by INT,
    update_time TIMESTAMP NULL DEFAULT NULL,

	FOREIGN KEY(create_by) REFERENCES staff(id),
	FOREIGN KEY(update_by) REFERENCES staff(id),
    FOREIGN KEY(project_id) REFERENCES project(id),

	CONSTRAINT tg_unique UNIQUE(project_id , name)
);

CREATE TABLE subtask(
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
    name VARCHAR(255) NOT NULL,
    description TEXT, 
    task_category_id INT NOT NULL, 
    date_start TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_finish TIMESTAMP NOT NULL, 
    status ENUM ("NOT_STARTED", "IN_PROGRESS", "FINISHED") , 
    note TEXT,

	create_by INT , 
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_by INT,
    update_time TIMESTAMP NULL DEFAULT NULL,

	FOREIGN KEY(create_by) REFERENCES staff(id),
	FOREIGN KEY(update_by) REFERENCES staff(id),
	FOREIGN KEY(task_category_id) REFERENCES task_category(id),
    
    CONSTRAINT sub_unique UNIQUE(task_category_id , name),
    CONSTRAINT sub_date_integrity CHECK (date_start < date_finish)
); 

CREATE TABLE staff_subtask(

	id INT AUTO_INCREMENT PRIMARY KEY,
	staff_id INT NOT NULL,
    subtask_id INT NOT NULL,
    
	create_by INT , 
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_by INT,
    update_time TIMESTAMP NULL DEFAULT NULL,
    
	FOREIGN KEY(create_by) REFERENCES staff(id),
	FOREIGN KEY(update_by) REFERENCES staff(id),
	FOREIGN KEY(staff_id) REFERENCES staff(id),
	FOREIGN KEY(subtask_id) REFERENCES subtask(id),
    
    CONSTRAINT ss_unique UNIQUE (staff_id , subtask_id)
); 

