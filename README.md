# GuitarBuilder

A Rails demo app for building and ordering custom guitars and managing those orders.

[ ![Codeship Status for dchopson/guitar_builder](https://codeship.com/projects/e90d5670-fcd5-0133-d954-4ed649fef8dc/status?branch=master)](https://codeship.com/projects/152085)

## Goals
- [x] Rails
- [x] JQuery
- [x] Bootstrap
- [x] User authorization (Devise)
- [x] External API (PayPal)
- [x] Security best practices
- [x] 100% code & documentation coverage
- [ ] Feature specs
- [ ] Host on Heroku

## Configuring the application
You will need a valid PayPal sandbox [facilitator account](https://developer.paypal.com/developer/accounts/) with TEST API credentials. These should be added as environment variables to your bash profile (don't forget to source when finished):

```
# PayPal
export PAYPAL_LOGIN="some-facilitator"
export PAYPAL_PASSWORD="some-password"
export PAYPAL_SIGNATURE="some-signature"
```

Then: `$ bundle exec rake db:setup`

## Running the application

`$ bundle exec rails s`
