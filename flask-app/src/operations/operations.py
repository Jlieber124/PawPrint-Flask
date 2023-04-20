from flask import Blueprint, request, jsonify, make_response, current_app
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
    
    brand = the_data['brand']
    quantity = the_data['quantity']
    item_cat = the_data['item_category']
    date_rec = the_data['date_received']
    op_id = the_data['operation_id']
    item_id = the_data['item_id']
    
    the_query = "insert into AnimalInventory (brand, quantity, item_category, date_received, operation_id, item_id) "
    the_query += "values ('" + brand + "', " + str(quantity) + ", '" + item_cat + "', '" + date_rec + "', " + str(op_id) + ", " + str(item_id) + ")"

    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()
    return "success"


# Return the quantity of a specific item
@operations.route('/inventory/<id>', methods=['GET'])
def get_item(id):
    cursor = db.get_db().cursor()
    cursor.execute(
        'select item_id, brand, quantity \
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
    the_query += "set quantity = " + str(quantity)
    the_query += " where item_id = {0}".format(id)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()
    return "success"


# Return all operation IDs
@operations.route('/getOpId', methods=['GET'])
def get_operationId():
    cursor = db.get_db().cursor()
    cursor.execute(
        'select distinct operation_id \
        from OperationVolunteer'
        )
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    
    return jsonify(json_data)


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


# Get items that only have 3 or less left in stock
@operations.route('/low_inventory', methods=['GET'])
def get_low_items():
    cursor = db.get_db().cursor()
    cursor.execute(
        'select item_id, brand, quantity, item_category \
        from AnimalInventory \
        where quantity <= 3'
        )
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    
    return jsonify(json_data)


# Get a list of brands in stock for this item category
@operations.route('/brand_categories/<item_cat>', methods=['GET'])
def get_recent_items(item_cat):
    # assign item_cat parameter to category
    if (item_cat == '1'):
        category = 'Cat Food'
    elif (item_cat == '2'):
        category = 'Cat Toy'
    elif (item_cat == '3'):
        category = 'Cat Treat'
    elif (item_cat == '4'):
        category = 'Dog Food'
    elif (item_cat == '5'):
        category = 'Dog Toy'
    elif (item_cat == '6'):
        category = 'Dog Treat'
    elif (item_cat == '7'):
        category = 'Leash'
    elif (item_cat == '8'):
        category = 'Litter Box'
    else:
        category = 'Poop Bag'
    
    cursor = db.get_db().cursor()
    the_query = 'select distinct brand, sum(quantity) as count \
        from AnimalInventory \
        where item_category = "' + category + '" \
        group by brand'
    current_app.logger.info(the_query)
    cursor.execute(the_query)
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
        'select distinct item_category, sum(quantity) as count \
        from AnimalInventory \
        group by item_category \
        order by item_category'
        )
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    
    return jsonify(json_data)