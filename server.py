from flask import Flask, request, make_response
from flask_restful import Resource, Api
from pymongo import MongoClient
from bson.objectid import ObjectId
import bcrypt
import json
from CustomClass import JSONEncoder
from flask import jsonify
import pdb
from bson import BSON
from bson import json_util
from basicauth import decode
from bson.json_util import dumps

app = Flask(__name__)
client = MongoClient('mongodb://localhost:27017/')
app.db = client.homie
database = app.db
rounds = app.bcrypt_rounds = 5
api = Api(app)
homie_collection = database.homie_collection


def authenticated_request(func):
    def wrapper(*args, **kwargs):
        auth = request.authorization
        print('***********')
        print(request.authorization)
        print('***********')
        auth_code = request.headers['authorization']
        email,password = decode(auth_code)

        if email is not None and password is not None:
            user_collection = database.homie_collection
            user = user_collection.find_one({'email': email})
            if user is not None:
                encoded_password = password.encode('utf-8')
                if bcrypt.checkpw(encoded_password, user['password']):
                    return func(*args, **kwargs)
                else:
                    return ({'error': 'email or password is not correct'}, 401, None)
            else:
                return ({'error': 'could not find user in the database'}, 400, None)
        else:
            return ({'error': 'enter both email and password'}, 400, None)

    return wrapper

class User(Resource):
    # This class is to represent the users
    def post(self):
        # This function this is going to represent how we post the users
        requested_json = request.json

        # So we specfically have to get the password so we can essentially hash it in our server
        requested_password = requested_json.get('password')

        # Once we have the users password we can now be able to encode the users password in plain text and then it can be hashed
        encoded_password = requested_password.encode('utf-8')
        hashed = bcrypt.hashpw(encoded_password, bcrypt.gensalt(rounds))
        requested_json['password'] = hashed

        if 'email' in requested_json and 'password' in requested_json:
            homie_collection.insert_one(requested_json)
            requested_json.pop('password')
            print('The user has succesfully been implemented to the database')
            return(requested_json, 201, None)
        else:
            print("An error has occured trying to implement this document")
            return(None, 404, None)


    @authenticated_request
    def get(self):
        # This is essentially the function that we are going to be using to fetch the users

        # Since we are fetching users we have to take whatever the user
        auth = request.authorization
        # Essentially we need the credentials they are passing in the headers

        # Now we need to find the user in the database
        # pdb.set_trace()
        user_find = homie_collection.find_one({'email': auth.username})

        # Now we esentially implement the error handling
        if user_find is not None:
            user_find.pop('password')
            print('The user has succesfully been fetched')
            return(user_find, 200, None)
        else:
            print("The user could not be fetched")
            return(None, 401, None)

    def delete(self):
        # This will essentially be the function to delete users

        # First we find the users
        auth = request.authorization

        user_query = homie_collection.find_one({'email': auth.username})

        # Now we do some simple error handling to see if the user exist

        if user_query is not None:
            homie_collection.remove(user_query)
            user_query.pop('password')
            print("The user has been removed")
            return(user_query, 204, None)
        else:
            print("The user could not be deleted")
            return(None, 404, None)

class WalletBalance(Resource):
    @authenticated_request
    def get(self):
        '''Fetches the user current wallet balance that has been saved in the database'''
        wallet_collection = database.wallet_collection

        # Getting access to the credentials passed in the headers to see if the user is actually logged in
        auth = request.authorization

        user_find = homie_collection.find_one({'email': auth.username})

        wallet_find = wallet_collection.find_one({'email': auth.username})

        if user_find is not None and wallet_find is not None:
            user_find.pop('password')
            print(wallet_find)
            print('The wallet has succesfully been fetched')
            return(wallet_find, 200, None)

    def post(self):
        '''Posts the users wallet to the database'''
        wallet_collection = database.wallet_collection

        # Getting access to the users credentials so that we can verify if the user is logged in
        auth = request.authorization

        # The json in this case will essentially be the funds that the user has bought
        requested_json = request.json

        user_find = homie_collection.find_one({'email': auth.username})

        if user_find is not None and 'fund_amount' in requested_json and 'email' in requested_json:
            wallet_collection.insert_one(requested_json)
            print("The users funds have been sent to the database")
            print(requested_json)
            return requested_json, 201, None


api.add_resource(User, '/users')
api.add_resource(WalletBalance, '/wallet')

@api.representation('application/json')
def output_json(data, code, headers=None):
    resp = make_response(JSONEncoder().encode(data), code)
    resp.headers.extend(headers or {})
    return resp
# Encodes our resouces for us


if __name__ == '__main__':
    # Turn this on in debug mode to get detailled information about request related exceptions: http://flask.pocoo.org/docs/0.10/config/
    app.config['TRAP_BAD_REQUEST_ERRORS'] = True
    app.run(debug=True)