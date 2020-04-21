from api.connection import connection 


def delete_employee(id):
    cur = connection.cursor()
    sql = "DELETE FROM Employees WHERE Employee_No={}".format(id)
    cur.execute(sql)

    return cur.fetchall()
    
    