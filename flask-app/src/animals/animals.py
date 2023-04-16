from flask import Blueprint, request, jsonify, make_response
import json
from src import db


animals = Blueprint('animals', __name__)

# NEEDS WORK
# Add a new dog to the shelter database
@animals.route('/add_dog', methods=['POST'])
def add_dog():
    the_data = request.json

    price = the_data['price']
    brand = the_data['brand']
    quantity = the_data['quantity']
    item_cat = the_data['item_category']
    date_rec = the_data['date_received']
    op_id = the_data['operation_id']
    item_id = the_data['item_id']
	
    # construct insert statement
    the_query = "insert into products (price, brand, quantity, item_category, date_received, operation_id, item_id) "
    the_query += "values (" + str(price) + ", '" + brand + "', " + str(quantity) + ", '" + item_cat + "', '" + date_rec + "', " + str(op_id) + ", " + str(item_id) + ")"
    #current_app.logger.info(the_query)

    # execute query
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "success"

# NEEDS WORK
# Add a new cat to the shelter database
@animals.route('/add_cat', methods=['POST'])
def add_cat():
    the_data = request.json

    price = the_data['price']
    brand = the_data['brand']
    quantity = the_data['quantity']
    item_cat = the_data['item_category']
    date_rec = the_data['date_received']
    op_id = the_data['operation_id']
    item_id = the_data['item_id']
	
    # construct insert statement
    the_query = "insert into products (price, brand, quantity, item_category, date_received, operation_id, item_id) "
    the_query += "values (" + str(price) + ", '" + brand + "', " + str(quantity) + ", '" + item_cat + "', '" + date_rec + "', " + str(op_id) + ", " + str(item_id) + ")"
    #current_app.logger.info(the_query)

    # execute query
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "success"

# get all of a particular dog's information
@animals.route('/dog/<id>', methods=['GET'])
def get_dog():
    cursor = db.get_db().cursor()
    query = ' select * \
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
@animals.route('/cat/<id>', methods=['GET'])
def get_cat():
    cursor = db.get_db().cursor()
    query = ' select * \
            from Cat \
            where id = {0}'.format(id)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# NEEDS WORK
# update a dog's information
@animals.route('/update_dog/<id>', methods=['PUT'])
def update_dog():
    the_data = request.json

    location = the_data['location']
    walk_duration = the_data['walk_duration']
    # ...
	
    # construct update statement
    the_query = "update Dog "
    the_query += "set location = '" + location + "' "
    the_query += "set walk_duration = '" + walk_duration + "' "
    # ...

    #current_app.logger.info(the_query)

    # execute query
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "success"

# NEEDS WORK
# update a cat's information
@animals.route('/add_cat/<id>', methods=['PUT'])
def update_cat():
    the_data = request.json

    location = the_data['location']
    need_feeding = the_data['need_feeding']
    # ...
	
    # construct update statement
    the_query = "update Cat "
    the_query += "set location = '" + location + "' "
    the_query += "set need_feeding = '" + need_feeding + "' "
    # ...

    #current_app.logger.info(the_query)

    # execute query
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "success"

# CHECK IF WORKS
# Mark a dog as adopted
@animals.route('/dog/<id>', methods=['DELETE'])
def adopt_dog(id):
    cursor = db.get_db().cursor()
    cursor.execute(
        'delete from Dog \
        where id = {0}'.format(id)
        )
    db.get_db().commit()
    
    return "success"

# CHECK IF WORKS
# Mark a dog as adopted
@animals.route('/dog/<id>', methods=['DELETE'])
def adopt_dog(id):
    cursor = db.get_db().cursor()
    cursor.execute(
        'delete from Dog \
        where id = {0}'.format(id)
        )
    db.get_db().commit()
    
    return "success"

