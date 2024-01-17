# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Ruby on rails installation in windows 
1. install ruby with devkit (recommended) from https://rubyinstaller.org/downloads/
2. simply follow all the installation process 
3. Open terminal and check
	-> ruby -v 
	-> gem list 
4. install rails using command "gem install rails" 
5. rails new e-commerce-ruby 
6. cd e-commerce-ruby 
7. bundle install 

##  Ruby on rails installation in ubuntu 
1. open terminal and run command in sequence
2. sudo apt-get update
3. sudo apt-get install ruby-full -> for ruby
4. ruby -v
5. sudo apt install sqlite3
6. sqlite3 --version
7. gem -v
8. gem list
9. gem install rails
10. rails -v

<!-- Project Details --> 
1. signup and account activated through email
2. login and JWT token generated
3. use JWT token to authorize API
4. forgot/reset password 

<!-- smtp config setup for sending email -->
1. go to gmail and enable 2 step verification 
2. search app password and create an app
3. generate password 

<!-- challenges -->
1. https://stackoverflow.com/questions/35181340/rails-cant-verify-csrf-token-authenticity-when-making-a-post-request
2. 
