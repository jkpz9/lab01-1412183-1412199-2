-- Chỉ trưởng phòng, trưởng chi nhánh được cấp quyền thực thi
-- stored procedure cập nhật thông tin phòng ban của mình
CREATE OR REPLACE PROCEDURE sp_Update_Department
(
	dp_id Department.Depart_id%TYPE,
	dp_name Department.Depart_name%TYPE,
	dp_chief Department.depart_chief%TYPE,
 	dp_date_role Department.Depart_chief_start_date%TYPE,
 	br_id Branch.Branch_id%TYPE
 ) 
IS 
USERNAME VARCHAR2(10);
BEGIN
	USERNAME :=sys_context('userenv', 'session_user');
	update Department SET 
							Department.depart_name = dp_name,
							Department.depart_chief =  dp_chief,
							Department.Depart_chief_start_date = dp_date_role,
							Department.Depart_branch = br_id
						    where Department.Depart_id = dp_id
								AND (Department.depart_chief = USERNAME
										OR Department.Depart_branch IN 
										(SELECT Branch.Branch_id FROM Branch 
											WHERE Branch.Branch_Director = USERNAME);
END sp_Update_Department;

--GRANT
GRANT execute on sp_Update_Department to depart_chief;
GRANT execute on sp_Update_Department to Branch_Director;
--test
--1 depart_chief
exec OwnerDB.sp_Update_Department(4, N'KHTC', 'xxxxxxxx21','22-December-22',2);
--conn OwnerDB/OwnerDB
--select * from Department where Depart_id =4;
--2 Branch_Director
exec OwnerDB.sp_Update_Department(4, N'KHTC', 'xxxxxxxx21',sysdate,2);