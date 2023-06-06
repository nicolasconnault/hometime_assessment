# README

This is an API app for receiving and storing accommodation bookings and guest information from multiple APIs.

## Ruby version
3.2.0

## System dependencies
Ruby and Bundler must be installed. Other dependencies will be handled by bundler during setup.

## Configuration
There is nothing to configure at this stage (no environment variables or credentials).
Run `rails s` to launch the local server.
You can then test the endpoints using curl or Postman.

## Database creation
SQLite is currently used, so there is no need to manually create a database.

## Database initialization
Run rails db:migrate to set up the database

## How to run the test suite
Run rspec spec/

## Internal Description

API controllers have the responsibility to:
- check the incoming payload structures for validity
- return an appropriate HTTP message if the payload's schema or JSON is invalid
- if the payload valid, pass it to the appropriate payload processing service

Payload processing services have an abstract class for each endpoint and one child class for each defined payload schema. These are responsible for converting the payload's data into a uniform object that can be saved in the database using ActiveRecord.

Accepted payload structures are stored using JSON schemas, found under app/schemas. These must be updated when the incoming payload structures change.
