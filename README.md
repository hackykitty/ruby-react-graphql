# Kittynews 😼 Frontend Challenge

1. Follow [Installation](#installation) guide
2. GraphQL API browser is available in [GraphiQL](#graphiql)
3. Implement Task 1 & 2

### Task 1

Show post information & comments on post page:

http://localhost:3000/posts/1

* Use GraphQL for fetching and updating the data
  * We use placeholder.com for images
  * API is available [GraphiQL](https://www.npmjs.com/package/graphiql) Docs button
  * *If data isn't available, add placeholder data*
* Design are available [here](docs/design.png)
  * [Explanation](docs/design_explain.png)
  1. Post header - generic information + vote button
  2. Lists - `user` who posted, `maker`, `commenters`, `voters` in this order. Use exported in [docs](docs).
  3. Comments section - inactive comment form, list comments. Comment actions should be stubbed for now.
  4. About the launch - lists statistics about the given post
  5. Latest launches. List up to 3 other launches. Use `postsAll` GraphQL field
* **It is up to you to handle the mobile version of the page**


### Task 2

Add Vote/Unvote button in posts show page

* Click by an unlogged user should redirect to the login page
* Click by a logged in user should create a vote
* Click on an already voted post should remove the vote
* Visually mark which posts the user have voted on
* Use GraphQL for fetching and updating the data

### Task 3

*Can't tell you yet* 😸 🙊

This will be the task during the pair-programming session.

## Criteria:

**Getting to a working solution is most important**.

After that we look for:

- Code structure
- Best practices for React, HTML, CSS

---

## Installation

### System Requirements

- PostgreSQL 9.6
- Ruby 2.7.5
- bundler
- yarn
- Docker and docker-compose

### Setup

Install the app dependencies:

```
gem install bundler
brew install yarn

bin/setup
```

Start PostgreSQL via Docker *(and keep in background)*

```
docker-compose up -d
```

Setup the database:

```
bundle exec rails db:create db:migrate db:seed db:test:prepare
```

Start the server:

```
bundle exec rails server -p 3000
```

### Tests

To run all tests:

```
bundle exec rspec
```

### Running the app

Open the app:

```
http://localhost:3000
```

Sign in as:

* email: `bob@example.com`
* password: `password`

### GraphiQL

[GraphiQL](https://www.npmjs.com/package/graphiql) is installed and can be accessed via:

```
http://localhost:3000/graphiql
```
