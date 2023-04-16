from flask import Blueprint, request, jsonify, make_response
import json
from src import db


inventory = Blueprint('inventory', __name__)


# Get all Return identifying information and quantity of all items
@inventory.route('/inventory', methods=['GET'])
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
@inventory.route('/inventory', methods=['POST'])
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
    the_query = "insert into products (price, brand, quantity, item_category, date_received, operation_id, item_id) "
    the_query += "values (" + str(price) + ", '" + brand + "', " + str(quantity) + ", '" + item_cat + "', '" + date_rec + "', " + str(op_id) + ", " + str(item_id) + ")"
    #current_app.logger.info(the_query)

    # execute query
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "success"

# Return the quantity of a specific item
@inventory.route('/inventory/<id>', methods=['GET'])
def get_item(id):
    cursor = db.get_db().cursor()
    cursor.execute(
        'select quantity \
        from AnimalInventory \
        where id = {0}'.format(id)
        )
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    
    return jsonify(json_data)

# CHECK IF WORKS
# Mark an item as out of stock
@inventory.route('/inventory/<id>', methods=['DELETE'])
def delete_item(id):
    cursor = db.get_db().cursor()
    cursor.execute(
        'delete from AnimalInventory \
        where id = {0}'.format(id)
        )
    db.get_db().commit()
    
    return "success"