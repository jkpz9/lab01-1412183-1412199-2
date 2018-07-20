--1412199
-- Chỉ trưởng phòng được phép cập nhật và thêm thông tin vào dự án
GRANT UPDATE, INSERT ON Project to depart_chief;
update OwnerDB.Project 
	set Project_budget = 1400000000
	where Project_id=1;
connect OwnerDB/OwnerDB;
select * from Project
	 where Project_id = 1;