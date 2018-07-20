-- Trưởng phòng chỉ được phép đọc thông tin chi tiêu
--của dự án trong phòng ban mình quản lý. Với những dự án không
-- thuộc phòng ban của mình, các trưởng phòng được phép xem
--thông tin chi tiêu nhưng không được phép xem số tiền cụ thể 
CREATE OR REPLACE FUNCTION Depart_Chief_V_Charge
(obj_schema varchar2, obj_name varchar2)
RETURN varchar2
IS
  user varchar2(10);
BEGIN
  user := SYS_CONTEXT ('USERENV', 'SESSION_USER');
  RETURN 'Proj_id IN (SELECT Project_id 
        FROM Project , Department
        WHERE Depart_chief = ' || '''' || user || '''' || 'AND Project.Project_depart_host = Department.depart_id)';
END;

BEGIN 
DBMS_RLS.ADD_POLICY(
  object_schema => 'OwnerDB',
  object_name => 'Charge',
  policy_name => 'vpd_3',
  function_schema => 'OwnerDB',
  policy_function => 'Depart_Chief_V_Charge',
  sec_relevant_cols => 'Amount',
  sec_relevant_cols_opt => dbms_rls.ALL_ROWS);
END;

BEGIN
DBMS_RLS.DROP_POLICY(
  object_schema => 'OwnerDB',
  object_name => 'Charge',
  policy_name => 'vpd_3'
 );
END;
--test-case
select proj_id,Staff_id,  Charge_for, Amount from OwnerDB.Charge;
--tracing
--SELECT VALUE FROM V$DIAG_INFO WHERE NAME = 'Default Trace File';



