USE TaskManagement;

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

Insert Into staff (full_name) Values ("HVCG");

Insert Into security (username , password , role , staff_id) 
Values ("HocVoiChuyenGia" , "$12$s5bLefZEhDNsNKo4OvdVQuyWGBvM7V3uutdGn0yBMHGxqiRCxWLnq" , "ADMIN" , 1)
