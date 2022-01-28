# README

## Problem Statement

### Challenge Reward System
Description:
Reward system will reward customers for inviting their friends. It will provide customer points when an invited person accepts their contract. Inviters also will berewarded when someone they have invited refers more people.

Implementation:
Used simple graph like data structure for the imlementation. No database was used for the implementation, all the calculation are stored in the memory.
Endpoint: `/rewards/process_file`
This endpoint expect a file with input data and returning a set of scores for the contained customers. File and file content is mandatory. Will validate the commands in the file. Simple graph is created, which contains nodes. Each node has a parent node. When we have an accept command, we will have to update parent node, and look upto 3 levels with points 1 point, 0.5 points, 0.25 points.
Used `rails` gems for implementation of this task for webservice. Also, used `rubocop` gem for formatting the code and `rspec` to test the code.

Validations:
- File and file content is mandatory
- Actions are limited to `recommends` and `accepts`
- Date has to be in the valid
- `recommends` command need a `from` and `to` nodes

## Installation
### Dependencies

    Ruby 2.7.2
    Rails 7.0.1


### Install bundler and required gems

Once the specified version of Ruby is installed with all its dependencies satisfied, run the following command from the root directory of the application. 
```
bundle install
```
## Start the application

You can start the Rails server using
```
rails server
```

Curl command
```
curl -X POST -i -F "file_details=input.txt" -F "file_type=.txt" http://localhost:3000/rewards/process_file
```