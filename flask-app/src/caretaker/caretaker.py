from flask import Blueprint, request, jsonify, make_response
import json
from src import db


caretaker = Blueprint('caretaker', __name__) 

# get all of a particular dog's information
@caretaker.route('/dog/<id>', methods=['GET'])
def get_dog():
    cursor = db.get_db().cursor()
    query = 'select * \
            from Dog \
            where id = {0}'.format(id)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# get all of a particular cat's information
@caretaker.route('/cat/<id>', methods=['GET'])
def get_cat():
    cursor = db.get_db().cursor()
    query = 'select * \
            from Cat \
            where id = {0}'.format(id)
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
    query = 'select Dog.need_food, need_walk, need_clean, Cat.need_food, need_litter_cleaning \
            from Dog join Cat \
            where Cat.need_food OR Dog.need_food OR need_walk OR need_clean OR need_litter_cleaning'
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


# update an dog's need food status
@caretaker.route('/need_dogfood/<id>', methods=['PUT'])
def update_dogfood():
    the_data = request.json

    need_food = the_data['need_food']
	
    the_query = "update Dog "
    the_query += "set need_food = '" + need_food + "' "

    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "success"

# update an dog's need clean status
@caretaker.route('/need_clean/<id>', methods=['PUT'])
def update_clean():
    the_data = request.json

    need_clean = the_data['need_clean']
	
    the_query = "update Dog "
    the_query += "set need_clean = '" + need_clean + "' "

    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "success"

# update an dog's need walk status
@caretaker.route('/need_walk/<id>', methods=['PUT'])
def update_walk():
    the_data = request.json

    need_walk = the_data['need_walk']
	
    the_query = "update Dog "
    the_query += "set need_walk = '" + need_walk + "' "

    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "success"


# update an cat's need food status
@caretaker.route('/need_catfood/<id>', methods=['PUT'])
def update_catfood():
    the_data = request.json

    need_food = the_data['need_food']
	
    the_query = "update Cat "
    the_query += "set need_food = '" + need_food + "' "

    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "success"

# update an cat's need food status
@caretaker.route('/need_litter/<id>', methods=['PUT'])
def update_litter():
    the_data = request.json

    need_litter = the_data['need_litter_cleaning']
	
    the_query = "update Cat "
    the_query += "set need_litter_cleaning = '" + need_litter + "' "

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

