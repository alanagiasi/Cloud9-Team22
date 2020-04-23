from api.connection import connection
from model.Employee import Employee
import random


def insert_new_employee(employee: Employee):
    cur = connection.cursor()
    sql = "INSERT INTO Employees\
            VALUES ('{}', '{}', '{}','{}', '{}','{}' , '{}','{}','{}','{}','{}');".format(
        random.randint(1, 20000),
        employee.first_name,
        employee.surname,
        employee.email,
        employee.phone_number,
        employee.hire_date,
        employee.job_id,
        employee.salary,
        employee.commission,
        employee.manager_id,
        employee.department_no
    )
    print(sql)
    cur.execute(sql)

    return cur.fetchall()
