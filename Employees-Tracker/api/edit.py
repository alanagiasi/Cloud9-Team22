from api.connection import connection
from model.Employee import Employee


def update_employee(employee: Employee, id):
    cur = connection.cursor()
    sql = "UPDATE Employees SET\
            First_Name='{}',\
            Last_Name='{}',\
            Email='{}',\
            Phone_Number='{}',\
            Hire_Date='{}',\
            Job_ID='{}',\
            Annual_Salary={},\
            Commission_Percent={},\
            Manager_ID={},\
            Department_No={}\
            WHERE Employee_No={}".format(
        employee.first_name,
        employee.surname,
        employee.email,
        employee.phone_number,
        employee.hire_date,
        employee.job_id,
        employee.salary,
        employee.commission,
        employee.manager_id,
        employee.department_no.
        id
    )
    print(sql)
    cur.execute(sql)

    return cur.fetchall()
