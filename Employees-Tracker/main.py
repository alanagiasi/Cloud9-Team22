from flask import Flask, render_template, request
from api.search import fetch_by_employee_no, fetch_by_user_name
from model.Employee import Employee
from api.add import insert_new_employee
from api.edit import update_employee
from api.delete import delete_employee


app = Flask(__name__, template_folder="templates")


@app.route("/")
def hello():
    return render_template("index.html")


@app.route("/search_results")
def search_results(query=""):
    # Allow a search by empty string to list everything in the database
    query = request.args.get("query") or query

    if query.isnumeric():
        results = fetch_by_employee_no(query)
    else:
        results = fetch_by_user_name(query)

    if not len(results):
        return render_template("error_page.html", error="No results found for your query: {}".format(query))
    return render_template("search_results.html", results=results)


@app.route("/add_employee", methods=["GET"])
def add_employee():

    return render_template("add_employee.html")


@app.route("/add_employee", methods=["POST"])
def add_employee_process():
    employee = Employee(
        request.form["first_name"],
        request.form["surname"],
        request.form["email"],
        request.form["phone_number"],
        request.form["hire_date"],
        request.form["job_id"],
        request.form["salary"],
        request.form["commission"],
        request.form["manager_id"],
        request.form["department_no"],
    )
    result = insert_new_employee(employee)
    return search_results(request.form["email"])


@app.route("/edit_employee", methods=["GET"])
def edit_employee():
    id = request.args.get("id")
    try:
        result = fetch_by_employee_no(id)[0]
        return render_template(
            "edit_employee.html",
            first_name=result[1],
            surname=result[2],
            email=result[3],
            phone_number=result[4],
            hire_date=result[5],
            job_id=result[6],
            salary=result[7],
            commission=result[8],
            manager_id=result[9],
            department_no=result[10],
        )
    except IndexError:
        return render_template("error_page.html", error="Employee Id: {} does not exist".format(id))

@app.route("/edit_employee", methods=["POST"])
def edit_employee_process():
    employee = Employee(
        request.form["first_name"],
        request.form["surname"],
        request.form["email"],
        request.form["phone_number"],
        request.form["hire_date"],
        request.form["job_id"],
        request.form["salary"],
        request.form["commission"],
        request.form["manager_id"],
        request.form["department_no"],
    )
    update_employee(employee, request.args.get("id"))

    return search_results(request.args.get("id"))


@app.route("/delete_employee", methods=["GET"])
def delete_employee_process():
    id = request.args.get("id")
    if not id:
        return render_template("error_page.html", "No id supplied to delete")
    delete_employee(id)
    return render_template("delete_employee.html", id=id)

if __name__ == "__main__":
    app.run(host='127.0.0.1', port=8080, debug=True)
