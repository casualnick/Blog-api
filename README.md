# Blog-api
Api only version of my Project 

For more information visit my project ['Project' repository](https://github.com/casualnick/Project)

## Setup 
To run this aplication, clone the git repo and run tests

```
bundle exec rspec
```

## Authentication with JWT

Instead of casual ruby protect_from_forgery i used JWT authorization token in this project to authenticate every users's request. To achive that I used gem:

```
gem 'jwt'
```

To authenticate user I create JWT helper in app/lib/json_web_token.rb that encode and decode JWT and raise custom error if token is invalid, every custom error handler is in app/controller/concerns/exception_handler.rb.

Then i created authorize_request in app./auth that takes header as an argument and return user if decoded token is correct. Next, I authenticate user in app/auth/authenticate_user.rb. That class take email and the password as and argument and check if user is valid with authenticate method that is provide thanks to bcrypt gem.

In order to everithing work fine, I create AuthenticateController to return auth token as json if user is valid.

To Authenticate every request on use actions, I made authenticate method in application_controller as every controller ihnerit from it. Only exception is authentiacte methods and user create method. 


 ## Based on Json
 
 That api project is based on json.
 
 #### This is apy_only version of Blogy, so application hasn't got any views. In order to see how Blogy is working, click link above. ( Working on designing )

