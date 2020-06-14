
# Employee Register

An important part of the platform is to allow teachers to clock-in/clock-out of their daycare center. When a teacher arrives to work, they clock-in, when leave they clock-out, and the platform keeps track of these events.

## Install

### Clone the repository

```shell
git clone git@github.com:juliendargelos/employee_register.git
cd employee_register
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.7.0`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 2.7.0
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):

```shell
bundle && yarn
```

### Initialize the database

```shell
rails db:create db:migrate db:seed
```

## Test Cases

```shell
rspec
```

## Serve

```shell
rails s
```
## How did you approach this challenge?

To solve the given problem I have implemented the following features based on my understanding and some assumptions. 

1. User can check-in/check-out.
2. Auto check-outs at the EOD using background job if user does not check-out manually.
3. Admin can create, update and delete the check-in/check-outs for other users along with self.
4. Admin can create new users.
5. Users can view/index the check-in/check-out filtered by start and end date, the defaulf filter is for the current week.
6. In the Events index events are grouped by date and the date would appear red in case theere are dangling events / auto generated event is there for that date.
7. Admin can index users. 


## What schema design did you choose and why?

### Schema design
My schema design includes two tables. 

1. Events(occurred_at, event_type, user_id, auto_generated)
2. Users(name, email, password, admin)


For the events table:
occurred_at is a datetime field which would record check_in/check_out time.
event_type is to determine if the event is for check_in or check_out.
user_id is an assosication with the user table.
auto_generated is a boolean field which would be set as a true when a user forgets to check_out and its performed by the background job. It would avoid us to having dangling check_in type events. 

For the users table:
It's a fairly simple table using devise for login and a couple of custom fields name and a boolean for admin. 

### Why?
I designed this schema as events can be independant/loosly coupled with each other so it would be easier to update them without touching other records. 



## If you were given another day to work on this, how would you spend it? What if you were given a month?

### With another day.
I would like to focus on the following:
Feature:
- I would like to work on a feature which would allow user to request a create/edit events to the admin and the event gets updated once admin approves it.
- Create configs to store dynamic working hours and other daycare information.

Improvements: 
- UI clean-up
- Controller/Request specs

### With another month.
I can see the following possible features:
- Multiple daycare support. 
- Admin dashboard with features like visual time line with event CRUD.
- CSV reports.
- Expose APIs using https://github.com/Netflix/fast_jsonapi
- React app to be used in a physical device to scan QR code for check-in/check-out.
- Payroll sysyem.

But I would prefer to prioritize a couple of them after discussing with the product team or users.
