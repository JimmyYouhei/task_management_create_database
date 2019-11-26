CREATE USER 'task_admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL ON TaskManagement.* TO 'task_admin'@'localhost';
FLUSH PRIVILEGES;