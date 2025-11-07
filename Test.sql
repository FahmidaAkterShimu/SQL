# Create Database
create database testdb;
create database db2;
show databases;
drop database db2;
show databases;

# Basic Operations
select 'Shimu';
select 5+8;

# Create Table
Create table student(
    student_id int,
    student_name varchar(50),
    department varchar(20),
    address text
);

# Alter Table
Alter table student
add phone varchar(20);

Alter table student
drop column phone;

Alter table student
rename column phone to phn;

Alter table student
modify column phn int;

Alter table student
rename to student_info;

#drop table student_info;

# Constraints
Alter table student_info
modify column phn int not null;     # NOT NULL Constraints

alter table student_info
add unique (student_id);            # UNIQUE Constraints

alter table student_info
drop index student_id;              # Delete the Constraints

