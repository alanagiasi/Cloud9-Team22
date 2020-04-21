#!/usr/bin/env 
from pprint import pprint as pp
from flask import Flask, flash, redirect, render_template, request, url_for, Response
from weather import query_api
# import os
# import logging

# import subprocess

import sqlalchemy

# subprocess.call("./cloud_sql_proxy -dir=cloudsql/ --instances=keen-precinct-273713:europe-west2:ccassignment --credential_file=keen-precinct-273713-178fe09e1d7a.json &", shell=True)

# db_user = os.environ.get("frontend")
# db_pass = os.environ.get("frontend")
# db_name = os.environ.get("ccdatabase")
# cloud_sql_connection_name = os.environ.get("keen-precinct-273713:europe-west2:ccassignment")

db_user = 'frontend'
db_pass = 'frontend'
db_name = 'ccdatabase'
cloud_sql_connection_name = 'keen-precinct-273713:europe-west2:ccassignment'

app = Flask(__name__)

# logger = logging.getLogger()


db = sqlalchemy.create_engine(
    # Equivalent URL:
    # mysql+pymysql://<db_user>:<db_pass>@/<db_name>?unix_socket=/cloudsql/<cloud_sql_instance_name>
    sqlalchemy.engine.url.URL(
        drivername="mysql+pymysql",
        username=db_user,
        password=db_pass,
        database=db_name,
        # query={"unix_socket": "/cloudsql/{}".format(cloud_sql_connection_name)},
        query={"unix_socket": "cloudsql/keen-precinct-273713:europe-west2:ccassignment".format(cloud_sql_connection_name)},
    ),
    pool_size=5,
    max_overflow=2,
    pool_timeout=30,  # 30 seconds
    pool_recycle=1800,  # 30 minutes
)

# db = sqlalchemy.create_engine('mysql+pymysql://frontend:frontend@/ccdatabase?unix_socket=cloudsql/keen-precinct-273713:europe-west2:ccassignment', pool_recycle=3600, pool_timeout=60, max_overflow=2, pool_size=5)

# with db.connect() as conn:
# 	q = conn.execute("SHOW TABLES")

#First page with selection of 5 last employees number showed by name.
@app.route('/', methods=["GET"])
def index():
	data = []
	with db.connect() as conn:
		employee = conn.execute(
			"SELECT * FROM Employees ORDER BY Employee_No DESC LIMIT 5"
			).fetchall()
		
		for row in employee:
			if row[0] >= 260:
				data.append({'Employee_No': row[0]})


	return render_template('weather.html', data=data)

#Show the data for the selected Employee
@app.route("/result", methods=['GET', 'POST'])
def result():
	data = []

	Employee_No = request.form.get('comp_select')

	firstnameText = sqlalchemy.text(
		"SELECT First_Name FROM Employees WHERE Employee_No=:Employee_No"
		)

	lastnameText = sqlalchemy.text(
		"SELECT Last_Name FROM Employees WHERE Employee_No=:Employee_No"
		)

	emailText = sqlalchemy.text(
		"SELECT Email FROM Employees WHERE Employee_No=:Employee_No"
		)

	phonenumberText = sqlalchemy.text(
		"SELECT Phone_Number FROM Employees WHERE Employee_No=:Employee_No"
		)

	with db.connect() as conn:
		First_Name = conn.execute(firstnameText, Employee_No=Employee_No).fetchone()
		# if "'" in First_Name:
		First_Name = str(First_Name).split("'")[1]

		Last_Name = conn.execute(lastnameText, Employee_No=Employee_No).fetchone()
		# if "'" in Last_Name:
		Last_Name = str(Last_Name).split("'")[1]

		Email = conn.execute(emailText, Employee_No=Employee_No).fetchone()
		# if "'" in Email:
		Email = str(Email).split("'")[1]

		Phone_Number = conn.execute(phonenumberText, Employee_No=Employee_No).fetchone()
		# if "'" in Phone_Number:
		Phone_Number = str(Phone_Number).split("'")[1]


	return render_template('result.html', Employee_No=Employee_No, First_Name=First_Name, Last_Name=Last_Name, Email=Email, Phone_Number=Phone_Number)


@app.route("/new", methods=['GET', 'POST'])
def new():
	First_Name = request.form.get('FirstName')
	Last_Name = request.form.get('LastName')
	Email = request.form.get('Email')
	Phone_Number = request.form.get('PhoneNumber')


	querryText = sqlalchemy.text(
		"INSERT INTO Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) VALUES (:Employee_No, :First_Name, :Last_Name, :Email, :Phone_Number, '1999-11-14' , 'SA_REP', 1000, 0.25, 150, 60)"
		)

	with db.connect() as conn:
		Employee_No = conn.execute(
			"SELECT Employee_No FROM Employees ORDER BY Employee_No DESC LIMIT 1"
			).fetchone()
		for row in Employee_No:
			Employee_No = row
		Employee_No = str(Employee_No + 1)

		# conn.execute("INSERT INTO Employees (Employee_No,First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) VALUES (280,'Kevin', 'Myers','KMYERS', '532 555 161','1999-11-14' , 'SA_REP',1000,0.25,150,60)")
		conn.execute(querryText, Employee_No=Employee_No, First_Name=First_Name, Last_Name=Last_Name, Email=Email, Phone_Number=Phone_Number)


	return render_template('new.html', Employee_No=Employee_No, First_Name=First_Name, Last_Name=Last_Name, Email=Email, Phone_Number=Phone_Number)

@app.route("/delete", methods=['GET', 'POST'])
def delete():
	Employee_No = request.form.get('delete_select')

	deleteQuerry = sqlalchemy.text(
		"DELETE FROM Employees WHERE Employee_No=:Employee_No"
		)

	with db.connect() as conn:
		conn.execute(deleteQuerry, Employee_No=Employee_No)


	return(render_template('delete.html', Employee_No=Employee_No))


if __name__=='__main__':    
	app.run(host="127.0.0.1", port=8080, debug=True)