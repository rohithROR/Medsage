# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
    - 2.6.0p0

* Rails version
    - 6.0.3.3

* Configuration
    - bundle install

* Database creation
    - rake db:create
    - rake db:migrate

* How to run the test suite
    - rspec

* About
    - This application helps to import data of patients, orders and the invoices in to database
        by using file upload. The file can be .csv or .zip.

* Additional Notes
    - This requirment can be achieved in two ways.
    1. Using sidekiq and rub the logic in background once the file is uploaded and send the confirmation or error messages if any over Email to the uploaded user. This approach is possible only if there is session management with authentication.

    2. Another is simple. Once the file is uploaded the user has to wait for the process to complete and can see the success/failure message upfront.

    Here, to make the application simple Approach 2 is followed. But if the requirment is with session management and if lot of huge files plays a role then Approach 2 is preferrable.
