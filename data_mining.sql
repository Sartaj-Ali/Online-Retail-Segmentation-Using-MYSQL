use data_mining;

create table history_student (
	std_id int auto_increment primary key,
    name varchar(100),
    roll_no int,
    age int,
    dpt varchar(100)
    
    );
   
insert into history_student
values
(101,'sajid',20,22,"IT");    

select name from history_student;
select * from history_student;
