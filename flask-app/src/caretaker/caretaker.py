from flask import Blueprint, request, jsonify, make_response
import json
from src import db

caretaker = Blueprint('caretaker', __name__) 

# get all of a particular dog's information
@caretaker.route('/dog/<id>', methods=['GET'])
def get_dog(id):
    cursor = db.get_db().cursor()
    query = 'select dog_id \
            from dog \
            where dogID = {0}'.format(id)
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
            from Cat \
            where catID = {0}'.format(id)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# get all animals that need any kind of care
@caretaker.route('/needCare', methods=['GET'])
def get_care():
    cursor = db.get_db().cursor()
    query = 'select dog.need_food, need_walk, need_clean, cat.need_food, need_liter_cleaning \
            from dog natural join cat \
            where cat.need_food = True OR dog.need_food = True OR need_walk = True OR \
                  need_clean = True OR need_liter_cleaning = True'
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# update an dog's need food status
@caretaker.route('/need_dogfood/<id>', methods=['PUT'])
def update_dogfood(id):
    the_data = request.json
    need_food = the_data['need_food']
    
    the_query = "update Dog "
    the_query += "set need_food = '" + need_food + "' "
    the_query += "where dogID = {0}".format(id)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()
    return "success"

# update an dog's need clean status
@caretaker.route('/need_clean/<id>', methods=['PUT'])
def update_clean(id):
    the_data = request.json
    need_clean = the_data['need_clean']
    
    the_query = "update Dog "
    the_query += "set need_clean = '" + need_clean + "' "
    the_query += "where dogID = {0}".format(id)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()
    return "success"

# update an dog's need walk status
@caretaker.route('/need_walk/<id>', methods=['PUT'])
def update_walk(id):
    the_data = request.json
    need_walk = the_data['need_walk']
    
    the_query = "update Dog "
    the_query += "set need_walk = '" + need_walk + "' "
    the_query += "where dogID = {0}".format(id)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()
    return "success"

# update an cat's need food status
@caretaker.route('/need_catfood/<id>', methods=['PUT'])
def update_catfood(id):
    the_data = request.json
    need_food = the_data['need_food']
    
    the_query = "update Cat "
    the_query += "set need_food = '" + need_food + "' "
    the_query += "where catID = {0}".format(id)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()
    return "success"

# update an cat's need food status
@caretaker.route('/need_litter/<id>', methods=['PUT'])
def update_litter(id):
    the_data = request.json
    need_litter = the_data['need_litter_cleaning']
    
    the_query = "update Cat "
    the_query += "set need_litter_cleaning = '" + need_litter + "' "
    the_query += "where catID = {0}".format(id)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()
    return "success"

# Mark a dog as adopted
@caretaker.route('/dog/<id>', methods=['DELETE'])
def adopt_dog(id):
    cursor = db.get_db().cursor()
    cursor.execute(
        'delete from Dog \
        where id = {0}'.format(id)
        )
    db.get_db().commit()
    
    return "success"

# Mark a cat as adopted
@caretaker.route('/cat/<id>', methods=['DELETE'])
def adopt_cat(id):
    cursor = db.get_db().cursor()
    cursor.execute(
        'delete from Cat \
        where id = {0}'.format(id)
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
    animal_spec = the_data['animal_speciality']
    coord_id = 0  # assigned later
    caretaker_id = 0  # assigned later
    
    the_query = "insert into CaretakerVolunteer (first_name, last_name, phone_number, work_email, experience, animal_speciality, coordinator_id, caretaker_id) "
    the_query += "values ('" + work_email + "', " + str(years_exp) + ", '" + f_name + "', '" + l_name + "', '" + phone_num + "', '" + animal_spec + "', " + str(coord_id) + ", " + str(caretaker_id) + ")"
    # execute query
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()
    return "success"