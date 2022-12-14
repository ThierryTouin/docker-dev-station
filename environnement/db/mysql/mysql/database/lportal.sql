
CREATE DATABASE IF NOT EXISTS ddslportal;

ALTER DATABASE ddslportal CHARACTER SET utf8 COLLATE utf8_general_ci;

GRANT ALL PRIVILEGES ON *.* TO 'dbuser'@'localhost' IDENTIFIED BY 'dbpassword';
flush privileges;