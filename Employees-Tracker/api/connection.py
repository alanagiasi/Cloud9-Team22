import pymysql

db_user = "frontend"
db_pass = "frontend"
db_name = "ccdatabase"
cloud_sql_connection_name = "keen-precinct-273713:europe-west2:ccassignment"

connection = pymysql.connect(host='127.0.0.1',
                           user= db_user,
                            password= db_pass,
                            db= db_name,
                            unix_socket="/cloudsql/{}".format(cloud_sql_connection_name))