# Brightwheel Email Server
## Setup

This project was created in Ruby on Rails. It's recommended you use Ruby `2.4.1p111`. If you have rebenv, you may want to `rbenv install 2.4.1` then `rbenv local 2.4.1`.

then...

- from the projects root, `cp .env.local .env`
- fill in the `.env` with correct API keys
- `bin/bundle install`
- `bin/rails s`
- `bin/rake db:migrate` (you might need this even though nothing is persisted)

## Project Overview
### Testing

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/fde4694f087d53dcfef6)

1. Check out the Postman docs [here](https://documenter.getpostman.com/view/408774/brightwheelemailserver/6fSZ7NG)
2. Start up the rails server `bin/rails s`
3. Open up Postman, change the `to` value to your email and send a request.
4. Give Sterling a job offer.

### Languages/Frameworks/Gems
* Ruby and Rails 5 API
* rest-client for HTTP goodness
* dotenv for variable management
* postman

### My thoughts

I considered using Backloop for this project but ended up using Rails because I felt the validation support and abstractions made more sense. Since it's just sending emails, I used pure ruby classes and included the parts of rails I needed for validations.

I started using HTTParty but switched to rest-client because it's API was documented well, it was straightforward to use and behaved as one might expect an HTTP lib to behave.

My go to lib for variable management is dotenv. It works well and even supports now.sh management. Even though the requirements say you want to be able to change the env, restart the server to use a different service, I think it would be better if the server automatically made the switch when the other service goes down so I used try/catch behavior that I get from `rest-client` to automatically switch over if there is problems with the first service.

I didn't test drive this application but probably should have. In fact, I didn't really write any test however during the process I used Postman and will include a link with everything set up so it's easy to test.

I'm a huge fan of functional programming for getting things done and OO programming for frameworks etc. Keeping that in mind, I designed this application so it's very easy to test. Defaults come from the .env file, but you can pass in the ENV variables into the modules so building up a test object doesn't require any "magic". It also makes understanding the email services very straight forward.

I broke up the two email services into `MailGunService` and `SendGridService` with an expected `send_email` method that all of these classes should have. This allows me to easily fall back to any number of services if desired. I think this works well for testing as well since each of these services can be tested separately without affecting the other. 

A nonpersistant model was used for basic validations called `Email` The `Email` object only takes care of understanding what an email is. It has no concept of sending itself. That is what `EmailService` is for. `EmailService` takes care of initializing itself with any number of email services and uses the appropriate one. Sending an email is as easy as `EmailService.send_email email` given email is valid `email = Email.new(email_params)`

### Tradoffs

I could have used Ruby's internal HTTP lib and build around that, but I don't think the point of this project is "build a rest lib". I don't use large regex to validate email either because it's better to be a little laxer there. I think checking for a @ is good enough. I decided not to write tests also (ok, that's a semi-lie, I think there are 1 or 2 tests). I did that because I think Postman was good enough for the project and didn't want to get hung up on setting up testing libs. They can be annoying to set up so I decided to spend my time writing code. 

### Items I didn't get around to

* Writing tests ... ugh...
* dotenv cleanup. I shouldn't be using `ENV` directly in my ruby classes as defaults. Intead, I should bootstrap my environment variables at startup time in my config files and then using them via `Rails.configs` or something like that. (I think there is a specific spot for them)
* I would also like to set up an dotenv now.sh server for easy bootstraping of config variables. That way I wouldn't have to share my env variables with everyone. They should just work. 
* Extend services to accept any number of email services. It would be nice to have any number of services and more abstractions around that but that would be way over engineering.
* Background jobs. Sending emails could be sent to a background job with some type of `/status` api
* Proper caching. I'm only using class caching, not `Rails.cache` caching. I could have done this to speed up performance 
* Versioned api. Either something like `/api/v1` or include that in the payload. I prefer putting it into the payload
* Better tag stripping. idk, seems like something more needs to be done there.
