# README

This is a rails api project for Brightwheel job position exercise. It covers the API endpoints requested to create device readings, get latest timestamp, and get  cumulative  count. This project don't use a database but Rails cache to store json data.


## Run locally

You need to run `rails dev:cache` inside the project in order to enable cache storing necessary in this project.

Run `rails s` to start  the local server. It will run at  http://127.0.0.1:3000 .

## Test API endponts

You can use curl to test API endpoints locally:

To create device reading:
`curl -d '{"device_readings": {"id": "36d5658a-6908-479e-887e-a949ec199272","readings": [{"timestamp": "2021-09-29T16:08:15+01:00","count": 2},{"timestamp": "2021-09-29T16:09:15+01:00","count": 123}]}}' -H "Content-Type: application/json" -X POST http://localhost:3000/readings/crate`

Get the latest timestamp

`curl  -H "Content-Type: application/json" -X GET http://localhost:3000/readings/36d5658a-6908-479e-887e-a949ec199272/latest`


Get the cumulative count

`curl  -H "Content-Type: application/json" -X GET http://localhost:3000/readings/36d5658a-6908-479e-887e-a949ec199272/device_count`


## Rspec tests

Using rspec to cover tests in the models and controller actions. Run `bundle exec rspec` .

## TODO or Improvements

If had more time i will create more tests, and a way to clear Cache when necessary, integrate Swagger for API documentation.
