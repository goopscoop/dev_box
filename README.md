# dev_box
Dev_Box is a community driven developers toolbox database. It's a place where you can finally, easily find the development tools you want to use on your next project. Or, find the tools you should have used on your last one.

[Imgur](http://i.imgur.com/1DDvxCi.png)

## Technologies
- DevBox is powered by Rails, Angular.js, and Postgres, styled with Materialize.css and Material

## Features
- oauth login
- user added tools
- voting
- information per tool
  - name
  - description
  - category
  - tags
  - language
  - price/free
  - examples
  - installation
  - website url
  - repo url

## APIs
- oAuth
  - GitHub
  - Stack Exchange

## ER-Diagram

![](http://i.imgur.com/gGwpcZR.png)

## Tables
- Users
- Tools
- Tools_Users
- Categories
- Categories_Tools
- Tags
- Tags_Tools
- Reviews
- Tvotes
- Versions (Paper_trail)

### Users
- id
- name
- email
- image_url
- provider
- provider_id
- provider_hash
- refresh_hash
- hash_expires_at

		# Migration
		rails g model user name email image_url provider provider_id provider_hash refresh_hash hash_expires_at:datetime

		# Associations
		has_many :tvotes
		has_many :reviews
		has_and_belongs_to_many :tools

### Tools
- id
- title
- description
- language
- is_free (1-free, 0-paid, -1-freemium)
- web_url
- repo_url
- avg_rating

		# Migration
		rails g model tool title description:text language is_free:integer web_url repo_url avg_rating:integer

		# Associations
		has_paper_trail
		has_and_belongs_to_many :tags
		has_and_belongs_to_many :categories
		has_and_belongs_to_many :users
		has_many :tvotes
		has_many :reviews

### Tools_Users
- id
- tool_id
- user_id

		# Migrations
		rails g model tools_users tool:references user:references --force-plural

		# Associations
		belongs_to :tool
		belongs_to :user

### Categories
- id
- category

		# Migration
		rails g model category category

		# Associations
		has_and_belongs_to_many :tools

#### Category List
- Asset
- Framework
- Library
- Terminal
- Text-Editor/IDE
- Image Editor
- Team Communication
- Project Management
- Prototype Builder

###Categories_Tools
  - id
  - category_id
  - tool_id

		# Migrations
		rails g model categories_tools category:references tool:references --force-plural

		# Associations
		has_paper_trail
		belongs_to :category
		belongs_to :tool

### Tags
- id
- tag

		# Migration
		rails g model tag tag

		# Associations
		has_and_belongs_to_many :tools

### Tags_Tools
- id
- tag_id
- tool_id

		# Migration
		rails g model tags_tools tag:references tool:references --force-plural

		# Associations
		has_paper_trail
		belongs_to :tag
		belongs_to :tool

### Reviews
- id
- pro
- con
- rating
- tool_id
- user_id

		# Migration
		rails g model review pro:text con:text rating:integer tool:references user:references

		# Associations
		belongs_to :tool
		belongs_to :user

### Tvotes
- vote
- tool_id
- user_id

		# Migration
		rails g model tvote vote:integer tool:references user:references

		# Associations
		belongs_to :tool
		belongs_to :user

### Versions (Paper_Trail)
- *This table is for use by paper_trail to handle tracking of model changes*

		# Migrations
		bundle exec rails generate paper_trail:install

		# Associations
		**Add has_paper_trail to the models you want to track**

## History Row Example
ver   |   ver_last    |   price   |   web_url   | edited_by
------|---------------|-----------|-------------|------------------------
1     |     0         |    1      |   a@b.com   | ncronquist
2     |     1         |    1      |   c@d.com   | cbarrus
0     |     2         |    0      |   c@d.com   | jsmith

## Action List
- Create app on GitHub; include README and License
- Clone to local machine

	`git clone https://github.com/goopscoop/dev_box.git`

- CD into dev_box

	`cd dev_box`

- Create a new rails-api app without the testing framework and setup for postgresql; **MUST RUN FROM PROJECT ROOT**

	`rails-api new . -T -d postgresql`

- Add oAuth (omniauth), pry-rails, and paper_trail gems to the gemfile
- Run bundle

	`bundle`

- Create Migrations

		# Users
		rails g model user name email image_url provider provider_id provider_hash refresh_hash hash_expires_at:datetime

		# Tools
		rails g model tool title description:text language is_free:integer web_url repo_url avg_rating:integer

		# Tools_Users
		rails g model tools_users tool:references user:references --force-plural

		# Categories
		rails g model category category

		# Categories_Tools
		rails g model categories_tools category:references tool:references --force-plural

		# Tags
		rails g model tag tag

		# Tags_Tools
		rails g model tags_tools tag:references tool:references --force-plural

		# Reviews
		rails g model review pro:text con:text rating:integer tool:references user:references

		# Tvotes
		rails g model tvote vote:integer tool:references user:references

		# Versions (Paper_trail)
		bundle exec rails generate paper_trail:install

- Create the database

	`rake db:create`

- Run the migrations

	`rake db:migrate`
