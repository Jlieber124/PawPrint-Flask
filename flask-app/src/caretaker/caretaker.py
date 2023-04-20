from flask import Blueprint, request, jsonify, make_response
import json
from src import db

caretaker = Blueprint('caretaker', __name__) 

# get all dogs
@caretaker.route('/all_dog', methods=['GET'])
def get_allDog():
    cursor = db.get_db().cursor()
    query = 'select * \
            from dog'
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)


# get all cats
@caretaker.route('/all_cat', methods=['GET'])
def get_allCat():
    cursor = db.get_db().cursor()
    query = 'select * \
            from cat'
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)


# get all of a particular dog's information
@caretaker.route('/dog/<id>', methods=['GET'])
def get_dog(id):
    cursor = db.get_db().cursor()
    query = 'select * \
            from dog \
            where dog_id = {0}'.format(id)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)


# get all of a particular cat's information
@caretaker.route('/cat/<id>', methods=['GET'])
def get_cat(id):
    cursor = db.get_db().cursor()
    query = 'select * \
            from cat \
            where catID = {0}'.format(id)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)


# get all dogs that need any kind of care
@caretaker.route('/need_dogcare', methods=['GET'])
def get_dogcare():
    cursor = db.get_db().cursor()
    query = 'select name_dog, dog_id, need_food, need_walk, need_clean \
            from dog \
            where need_food = TRUE OR need_walk = TRUE OR need_clean = TRUE'
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)


# get all cats that need any kind of care
@caretaker.route('/need_catcare', methods=['GET'])
def get_catcare():
    cursor = db.get_db().cursor()
    query = 'select name_cat, catID, need_food, need_litter_cleaning \
            from cat \
            where need_food = TRUE OR need_litter_cleaning = TRUE'
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)


# update an dog's need food status
@caretaker.route('/updateDog/<id>', methods=['PUT'])
def update_dog(id):
    the_data = request.json
    need_food = the_data['need_food']
    need_clean = the_data['need_clean']
    need_walk = the_data['need_walk']
    
    the_query = "update dog "
    the_query += "set need_food = " + str(need_food)
    the_query += ", need_clean = " + str(need_clean)
    the_query += ", need_walk = " + str(need_walk)
    the_query += " where dog_id = {0}".format(id)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()
    return "success"


# update a cat's need status
@caretaker.route('/updateCat/<id>', methods=['PUT'])
def update_cat(id):
    the_data = request.json
    need_litter = the_data['need_litter_cleaning']
    need_food = the_data['need_food']
    
    the_query = "update cat "
    the_query += "set need_litter_cleaning = " + str(need_litter)
    the_query += ", need_food = " + str(need_food)
    the_query += " where catID = {0}".format(id)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()
    return "success"


# Mark a dog as adopted
@caretaker.route('/dog/<id>', methods=['DELETE'])
def adopt_dog(id):
    cursor = db.get_db().cursor()
    cursor.execute(
        'DELETE FROM dog \
        WHERE dog_id = {0}'.format(id)
        )
    db.get_db().commit()
    
    return "success"


# Mark a cat as adopted
@caretaker.route('/cat/<id>', methods=['DELETE'])
def adopt_cat(id):
    cursor = db.get_db().cursor()
    cursor.execute(
        'delete from cat \
        where catID = {0}'.format(id)
        )
    db.get_db().commit()
    
    return "success"


# enter own information in to the database
@caretaker.route('/add_caretaker', methods=['POST'])
def add_caretaker():
    the_data = request.json
    f_name = the_data['first_name']
    l_name = the_data['last_name']
    phone_num = the_data['phone_number']
    work_email = the_data['work_email']
    years_exp = the_data['experience']
    animal_spec = the_data['animal_specialty']
    coord_id = the_data['coordinator_id']
    caretaker_id = 0  # assigned later
    
    the_query = "insert into CaretakerVolunteer (work_email, experience, first_name, last_name, phone_number, animal_specialty, coordinator_id, caretaker_id) "
    the_query += "values ('" + work_email + "', " + str(years_exp) + ", '" + f_name + "', '" + l_name + "', '" + phone_num + "', '" + animal_spec + "', " + str(coord_id) + ", " + str(caretaker_id) + ")"

    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()
    return "success"