### Backend Code Challenge

We'd like you to complete a short programming exercise. You can use any
programming language. This test should take you around 4-5 hours. Don't worry if you finish faster,
or if it takes you a little longer, as being comfortable with the tooling matters. As you've been told, we'd like you to send your work to us in the following 7 days.

**Instructions**
Develop a Chuck Norris fact search application. Your source of information will be this API: [https://api.chucknorris.io/](https://api.chucknorris.io/)

**Requirements**

- No login is required.
- Users will be able to search by:
    - Words
    - Categories
    - Randomly
- Results will be paginated.
- Each search (and the results) will be stored in a database.
- The user will be able to (optionally) enter his/her email address to receive the search results.
- The app will be available both in English and Spanish. Only the app itself, the results
of the API queries don’t need to be translated and can be presented in English.
- The design of the web page and the emails are completely up to you.
- The data model and the database technology are up to you as well.
- Any other functionality can be added if desired.
- Notes
    - Please submit your solution and any notes as a Git repository (GitHub, Gitlab, etc)
    - Let us know how to run your solution and its tests (README)

## Before coding

After reading carefully the coding challenge proposal I started to think about it. At first glance it was kind of easy and quite straightforward. The following this is what I understood and some of the ideas I started to have on how I could solve it (it may change later, I will document it anyway):

- we have **users that perform a search** (use case)
- results to the search should be paginated (API pagination)
- search and results should be stored in database
- results, optionally, should be sent by email if email address is provided (I would use background jobs →sidekiq and mailer)
- app should present interface in English/Spanish (locales)
- mandatory use of Docker
- **results come from an external API.** I would use an API wrapper. Because I am going with Ruby on Rails for the back end I can use `Faraday` or `RestClient` to build one, instead of relaying in a gem like `ApiStruct` just to show some coding skills or sense of organization/architecture
- I would use `Rspec` for tests, and `WebMock` to test the API wrapper and use mocked responses
- I never used before but started to learn `Vue.js` two years ago and liked it, so I will go with this, just for pure fun.

So, nothing complex, just perform a search obtaining results from an external API, apply some conditions and done, right? Not so fast my friend. Devil lives in the details. We are not just returning what we get from an external API, we need to store it and then serve it, probably after some processing. Pagination is asking for this behavior, specifically when asking for random jokes, every time we request to external API we can get different result and exercise tell us to paginate result, so we have to store the search and the results so the front end can ask for specific page. The exercise is not difficult but to complete we have lots of moving parts:

- connecting to external API and handling errors
- saving results by converting to our internal data model
- responding to our users' requests after validating them
- sending emails with results that implies to use background jobs if we don't want to block our app

## Initial Architecture considerations

I will try to use Clean Architecture, specifically the use of Interactors (or use cases), Forms (for incoming data validation from front end requests), Repositories (to read and save to a persistent storage system) and probably DTOs. 

I think I will prepare 4 use cases: 

- getting categories (filling database if no category found, started by frontend or a scheduled background job)
- create new search based on some parameters
- get all searches (paginated) done so far
- get specific search and its results (paginated)

One good framework I started to take a look at one year and a half ago is [Trailblazer](https://github.com/trailblazer/trailblazer) and [Hanami](https://hanamirb.org/) but I don't have time now for experiments (I will do some with the frontend, `Vuejs`, which I never used before) so I will stick with the good old Ruby on Rails.

I think that one of the best ways to use Rails is using use-case oriented Rails. This way we can have any feature we want and conveniently decoupled so we can build features based on other features. Furthermore, we can do it in a very verbose way, like plain English, very easy to understand, thus to maintain.

### Main endpoints identified so far:

- GET /api/v1/categories, get all categories
- POST /api/v1/search, creates a new search, it could return just the id of the search but it will send back as the response all jokes belonging to the search
- GET /api/v1/searches, all searches (conveniently paginated by params or headers)
- GET /api/v1/searches/{id}, specific search and its results

### Models identified so far:

**`Joke`**

- ext_id (that's the id coming from the external API)
- categories (will point to model `Category`)
- searches (will point to model `Search`)
- created_at
- updated_at
- icon_url
- joke_url
- joke_value

**`Search`**

- id
- search_type (string that could be word, category, random)
- search_value
- email
- jokes (will point to model `Joke`)

**`Category`**

- id
- category_name
- jokes (will point to model `Joke`)

## Use Cases

### Getting CN Fact Categories

Because we can get Chuck Norris facts from the external API (cn_api) by searching categories, we need to get them and populate our database, so we can save time, don't need to get categories every time user perform a search by using categories.

So the workflow is:

- get categories (GET /api/v1/categories) endpoint is reached
- then, GetCategories use case is called
- use case doesn't need any input so it's going to get categories from the API wrapper directly
- if need it, it will fill database with non existing categories
- once done, use case will return all categories list

### Create New Search

### Get all searches performed so far (not the results, paginated)

### Get (specific) Search results, paginated

 

# Building the solution

First of all I will create a repo in GitHub that will contain code for both back and front end codes. Then I will create a Makefile, that will help us with frequently used commands) and a docker-compose file. 

As I said for back end I will use Ruby on Rails 6 API mode and PostgreSQL as database (it could be SQLite but we are using docker so, no problem and very near to production ready), Redis database for sidekiq background jobs engine (for sending emails) and Vue.js in the front end.

## Setting up environments with Docker & Docker Compose

I created a folder (and repo) called happets-jjcermeno that contains a `docker-compose.yml` and a `Makefile` that organize the whole she-bang.

## Docker, Docker Compose

I use Docker for back and front and Docker Compose to orchestrate everything. 

Versions I use are:

`Docker version 19.03.12-ce`

`docker-compose version 1.27.4`

I created a `Makefile` that contains the most frequent command I use to setup and run everything.

After creating conveniently the `docker-compose` file we can start creating a folder for back and other for front. Those are called `cn_api` for back end and `cn_front` for, yes, front end.

Back end based in Ruby on Rails: api mode, postgres, sidekiq and redis

Folder for front end based in Vue.js and axios for sending REST API requests to back end.

## Back end: Models

I created models following, more and less, the fields when studying the problem. However, because we are using Rails and Active Record is heavily used in Rails, we are going to use `has_many through:` because we have some relations between the models. So we have to build the join table between `Joke-Search` and `Joke-Category` and surprisingly that join table is called `JokeCategory` and `JokeSearch`.

Once we have created the models using command `rails g model`, it creates tests too. So, we are getting ride of `JokeCategory` and `JokeSearch` tests but not for the rest of models. We have to create factories too but they are easy. Those model specs try to test against relations and validations. Yes, I know, validations could be done in other layers of the architecture, but right now, I do not know if I am going to use so much abstraction, and if I finally use it, I can go to model and remove such validations and write tests against the proper logic.

## Back end: Requests

I am going to create request tests because those tests everything: routing, logic, responses, validation of incoming data, everything. However, I will probably write some unit test for specific pieces like the external API wrapper with mocked data.

### Service Info

Info is a small service just returns some info about the service like the service descriptive name, version, total count of jokes, searches and categories in the database.

It comes with test.

### GET /api/v1/categories

This endpoint returns the categories in the db. The interactor (use case) will connect with external API and it will add any new category not present in the db. This endpoint is usually used when frontend asks for categories to show in a select box or something similar.

Use case is `use_cases/categories/fetch_categories.rb` launched by use cases `manager.rb`

Because we can get Chuck Norris facts from the external API (`chuck_norris_api` client) by searching categories, we need to get them and populate our database, so we can save time, don't need to get categories every time user perform a search by using categories.

So the (initial) workflow is:

- defined endpoint GET /api/v1/categories
- then, `fetch_categories` use case is called when endpoint is reached (I'm using gem `caze` because it is quite straightforward)
- use case doesn't need any input so it's going to get categories from the API wrapper directly
- if need it, it will fill database with non existing categories
- once done, use case will return all categories list (I'm applying some kind of JSON API specification, I prefered to keep it flexible to my needs, and I am not using any gem to help me with that like [jsonapi-serializer](https://github.com/jsonapi-serializer/jsonapi-serializer), frontend will be able to work with it)

Tests are mocked as it should be, we can't test with real API services because we need predictable tests and we can't leave chance to connection errors, API server slow responses and that kind of nuances. Better have predictable and specific tests.