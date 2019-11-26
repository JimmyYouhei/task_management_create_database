USE `heroku_72a3b7d93ef8a36`;

CREATE TABLE security(
	id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM("ADMIN" , "USER") NOT NULL,
    staff_id INT NOT NULL,
    
    UNIQUE(username),
    UNIQUE(staff_id),
    FOREIGN KEY (staff_id) REFERENCES staff(id)

);