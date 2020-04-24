from api.connection import connection
                        
def fetch_by_employee_no(query):
    cur = connection.cursor()
    cur.execute("SELECT * from Employees where Employee_No='{}'".format(query))
    result = cur.fetchall()
    return result

def fetch_by_user_name(query):
    cur = connection.cursor()
    cur.execute("SELECT * from Employees where Email LIKE '{}%'".format(query.upper()))
    results = cur.fetchall()
    print(type(results))
    return results