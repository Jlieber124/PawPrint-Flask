from flask import Blueprint, request, jsonify, make_response
import json
from src import db

operations = Blueprint('operations', __name__)

# Get all identifying information and quantity of all items
@operations.route('/inventory', methods=['GET'])
def get_items():
    cursor = db.get_db().cursor()
    cursor.execute(
        'select * \
        from AnimalInventory'
        )
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    
    return jsonify(json_data)

# Add a new item to the inventory
@operations.route('/inventory', methods=['POST'])
def add_item():
    # access json data from request object
    the_data = request.json
    
    price = the_data['price']
    brand = the_data['brand']
    quantity = the_data['quantity']
    item_cat = the_data['item_category']
    date_rec = the_data['date_received']
    op_id = the_data['operation_id']
    item_id = the_data['item_id']
    
    # construct insert statement
    the_query = "insert into AnimalInventory (price, brand, quantity, item_category, date_received, operation_id, item_id) "
    the_query += "values (" + str(price) + ", '" + brand + "', " + str(quantity) + ", '" + item_cat + "', '" + date_rec + "', " + str(op_id) + ", " + str(item_id) + ")"
    # execute query
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()
    return "success"

# Return the quantity of a specific item
@operations.route('/inventory/<id>', methods=['GET'])
def get_item(id):
    cursor = db.get_db().cursor()
    cursor.execute(
        'select quantity \
        from AnimalInventory \
        where item_id = {0}'.format(id)
        )
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    
    return jsonify(json_data)

# update an item's quantity
@operations.route('/inventory/<id>', methods=['PUT'])
def update_quantity(id):
    the_data = request.json
    quantity = the_data['quantity']
    
    the_query = "update AnimalInventory "
    the_query += "set quantity = '" + quantity + "' "
    the_query += "where item_id = {0}".format(id)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()
    return "success"

# Mark an item as out of stock
@operations.route('/inventory/<id>', methods=['DELETE'])
def delete_item(id):
    cursor = db.get_db().cursor()
    cursor.execute(
        'delete from AnimalInventory \
        where item_id = {0}'.format(id)
        )
    db.get_db().commit()
    
    return "success"

# Get items that only have 1 left in stock
@operations.route('/low_inventory', methods=['GET'])
def get_low_items():
    cursor = db.get_db().cursor()
    cursor.execute(
        'select item_id, brand, quantity \
        from AnimalInventory \
        where quantity = 1'
        )
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    
    return jsonify(json_data)

# Get items ordered by most recent
@operations.route('/recent_items', methods=['GET'])
def get_recent_items():
    cursor = db.get_db().cursor()
    cursor.execute(
        'select item_id, brand, date_received \
        from AnimalInventory \
        order by date_received desc'
        )
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    
    return jsonify(json_data)

# Get number of items in stock for each category
@operations.route('/per_category', methods=['GET'])
def get_items_per_category():
    cursor = db.get_db().cursor()
    cursor.execute(
        'select distinct category, sum(quantity) \
        from AnimalInventory \
        group by category'
        )
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    
    return jsonify(json_data)