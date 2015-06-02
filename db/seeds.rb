# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create Users
Nick = User.create({name: 'Nick', email: 'nick@ncronquist.com'})
Cody = User.create({name: 'Cody', email: 'codybarrus@gmail.com'})


# Create Tools Template
# t1 = Tool.create({title: '', description: '', language: '', is_free: 1, web_url: '', repo_url: ''})
t1 = Tool.create({title: 'Moment.js', description: 'Parse, validate, manipulate, and display dates in JavaScript.', language: 'javascript', is_free: 1, web_url: 'http://momentjs.com/', repo_url: 'https://github.com/moment/moment/'})
t2 = Tool.create({title: 'ramjet', description: 'Ramjet makes it looks as though one DOM element is capable of transforming into another, no matter where the two elements sit in the DOM tree. It does so by making copies of the two elements (and all their children), setting a fixed position on each, then using CSS transforms to morph the two elements in sync.', language: '', is_free: 1, web_url: 'http://www.rich-harris.co.uk/ramjet/', repo_url: 'https://github.com/rich-harris/ramjet'})
t3 = Tool.create({title: 'Nifty Modal Window Effects', description: 'Some inspiration for different modal window appearances', language: 'javascript', is_free: 1, web_url: 'http://tympanus.net/Development/ModalWindowEffects/', repo_url: ''})
t4 = Tool.create({title: 'Creative Link Effects', description: 'Subtle and modern effects for links or menu items', language: 'javascript', is_free: 1, web_url: 'http://tympanus.net/Development/CreativeLinkEffects/', repo_url: ''})
t5 = Tool.create({title: 'Creative Loading Effects', description: 'Loading animations don\'t have to be restricted to a tiny indicator. Here is some inspiration for some creative loading effects.*', language: 'javascript', is_free: 1, web_url: '', repo_url: 'http://tympanus.net/Development/CreativeLoadingEffects/'})
t6 = Tool.create({title: 'scrollReveal.js', description: 'Easily reveal elements as they enter the viewport.', language: 'javascript', is_free: 1, web_url: 'http://scrollrevealjs.org/', repo_url: 'https://github.com/julianlloyd/scrollReveal.js'})
t7 = Tool.create({title: 'jQuery Scoll Path', description: 'It\'s a plugin for defining custom scroll paths.', language: 'javascript', is_free: 1, web_url: 'http://joelb.me/scrollpath/', repo_url: 'https://github.com/JoelBesada/scrollpath'})
t8 = Tool.create({title: 'Animate.css', description: 'Just-add-water CSS animations', language: 'css', is_free: 1, web_url: 'http://daneden.github.io/animate.css/', repo_url: 'https://github.com/daneden/animate.css'})
t9 = Tool.create({title: 'Lettering.JS', description: 'Web type is exploding all over the web but CSS currently doesn\'t offer complete down-to-the-letter control. So we created a jQuery plugin to give you that control. Here are a few examples of what can easily be done with Lettering.js:', language: 'javascript', is_free: 1, web_url: 'http://letteringjs.com/', repo_url: 'https://github.com/davatron5000/Lettering.js'})
t10 = Tool.create({title: 'Skrollr', description: ' Stand-alone parallax scrolling library for mobile (Android + iOS) and desktop. No jQuery. Just plain JavaScript (and some love).', language: 'javascript', is_free: 1, web_url: 'http://prinzhorn.github.io/skrollr/', repo_url: 'https://github.com/Prinzhorn/skrollr'})
t11 = Tool.create({title: 'Scrolldeck', description: 'A jQuery plugin for making scrolling presentation decks', language: 'javascript', is_free: 1, web_url: 'https://johnpolacek.github.io/scrolldeck.js', repo_url: 'https://github.com/johnpolacek/scrolldeck.js'})
t12 = Tool.create({title: 'Famous', description: 'Famous abstracts the DOM & WebGL, allowing you to do custom layout and rendering. Centering objects and rotating them can be done with only a few lines of code.', language: 'javascript', is_free: 1, web_url: 'http://famous.org/', repo_url: ''})
t13 = Tool.create({title: 'Skipper', description: 'Skipper makes it easy to implement streaming file uploads to disk, S3, or any of its supported file adapters.', language: 'javascript', is_free: 1, web_url: '', repo_url: 'https://github.com/balderdashy/skipper'})
t14 = Tool.create({title: 'Waterline', description: 'Waterline is a brand new kind of storage and retrieval engine. It provides a uniform API for accessing stuff from different kinds of databases, protocols, and 3rd party APIs. That means you write the same code to get and store things like users, whether they live in Redis, mySQL, LDAP, MongoDB, or Postgres. Waterline strives to inherit the best parts of ORMs like ActiveRecord, Hibernate, and Mongoose, but with a fresh perspective and emphasis on modularity, testability, and consistency across adapters.', language: 'javascript', is_free: 1, web_url: 'https://github.com/balderdashy/waterline-docs', repo_url: 'https://github.com/balderdashy/waterline'})
t15 = Tool.create({title: 'Mongoose', description: 'Elegant MongoDB object modeling for Node.js', language: 'javascript', is_free: 1, web_url: 'http://mongoosejs.com/', repo_url: 'https://github.com/Automattic/mongoose'})
t16 = Tool.create({title: 'bcrypt', description: '', language: 'A bcrypt library for NodeJS.', is_free: 1, web_url: 'https://www.npmjs.com/package/bcrypt', repo_url: 'https://github.com/ncb000gt/node.bcrypt.js'})
t17 = Tool.create({title: 'Ionic', description: ' The beautiful, open source front-end SDK for developing hybrid mobile apps with HTML5.', language: 'javascript', is_free: 1, web_url: 'http://ionicframework.com/', repo_url: ''})
t18 = Tool.create({title: 'NPM', description: 'A package manager for javascript and a lot of other stuff.', language: '', is_free: 1, web_url: 'https://www.npmjs.com/', repo_url: ''})
t19 = Tool.create({title: 'Foreman', description: 'Manage Procfile-based applications', language: 'ruby', is_free: 1, web_url: 'https://github.com/ddollar/foreman', repo_url: ''})
t20 = Tool.create({title: 'Passport', description: 'Passport is authentication middleware for Node.js. Extremely flexible and modular, Passport can be unobtrusively dropped in to any Express-based web application. A comprehensive set of strategies support authentication using a username and password, Facebook, Twitter, and more.', language: 'javascript', is_free: 1, web_url: 'http://passportjs.org', repo_url: 'https://github.com/jaredhanson/passport'})
t21 = Tool.create({title: 'Debug', description: "tiny node.js debugging utility modelled after node core's debugging technique.", language: 'javascript', is_free: 1, web_url: 'https://www.npmjs.com/package/debug', repo_url: 'https://github.com/visionmedia/debug'})
t22 = Tool.create({title: 'Noty', description: 'NOTY is a jQuery plugin that makes it easy to create alert - success - error - warning - information - confirmation messages as an alternative the standard alert dialog. Each notification is added to a queue. (Optional)', language: 'javascript', is_free: 1, web_url: 'http://ned.im/noty/#/about', repo_url: 'https://github.com/needim/noty/'})
t23 = Tool.create({title: 'Sails', description: 'Sails makes it easy to build custom, enterprise-grade Node.js apps. It is designed to emulate the familiar MVC pattern of frameworks like Ruby on Rails, but with support for the requirements of modern apps: data-driven APIs with a scalable, service-oriented architecture. It\'s especially good for building chat, realtime dashboards, or multiplayer games; but you can use it for any web application project - top to bottom.', language: 'javascript', is_free: 1, web_url: 'http://sailsjs.org', repo_url: 'https://github.com/balderdashy/sails/'})
t24 = Tool.create({title: 'Async.js', description: 'Async is a utility module which provides straight-forward, powerful functions for working with asynchronous JavaScript. Although originally designed for use with Node.js and installable via npm install async, it can also be used directly in the browser.', language: 'javascript', is_free: 1, web_url: '', repo_url: 'https://github.com/caolan/async'})
t25 = Tool.create({title: 'body-parser', description: 'Node.js body parsing middleware.', language: 'javascript', is_free: 1, web_url: '', repo_url: 'https://github.com/expressjs/body-parser'})
t26 = Tool.create({title: 'ExpressJS', description: 'Fast, unopinionated, minimalist web framework for Node.js', language: 'javascript', is_free: 1, web_url: 'http://expressjs.com', repo_url: 'https://github.com/strongloop/expressjs.com'})
t27 = Tool.create({title: 'Easy table', description: 'Nice utility for rendering text tables with javascript.', language: 'javascript', is_free: 1, web_url: '', repo_url: 'https://github.com/eldargab/easy-table'})
t28 = Tool.create({title: 'Sequelize', description: 'Sequelize is a promise-based ORM for Node.js and io.js. It supports the dialects PostgreSQL, MySQL, MariaDB, SQLite and MSSQL and features solid transaction support, relations, read replication and more.', language: 'javascript', is_free: 1, web_url: 'http://docs.sequelizejs.com', repo_url: 'https://github.com/sequelize/sequelize'})
t29 = Tool.create({title: 'sequelize/cli', description: 'The Sequelize Command Line Interface', language: 'javascript', is_free: 1, web_url: '', repo_url: 'https://github.com/sequelize/cli'})

# Create Tags

frontend = Tag.create({tag:'frontend'})

frontend.tools << t1
frontend.tools << t2
frontend.tools << t3
frontend.tools << t4
frontend.tools << t5
frontend.tools << t6
frontend.tools << t7
frontend.tools << t8
frontend.tools << t9
frontend.tools << t10
frontend.tools << t11
frontend.tools << t12
frontend.tools << t22

backend = Tag.create({tag:'backend'})
backend.tools << t1
backend.tools << t13
backend.tools << t14
backend.tools << t15
backend.tools << t16
backend.tools << t17
backend.tools << t20
backend.tools << t21
backend.tools << t23
backend.tools << t24
backend.tools << t25
backend.tools << t26
backend.tools << t28


comandline = Tag.create({tag:'commandline'})
comandline.tools << t1
comandline.tools << t18
comandline.tools << t19
comandline.tools << t27
comandline.tools << t29

# Create Categories
# Associate Tools to Categories

library = Category.create({category: 'library'})
library.tools << t1
library.tools << t2
library.tools << t6
library.tools << t7
library.tools << t8
library.tools << t9
library.tools << t10
library.tools << t11
library.tools << t13
library.tools << t14
library.tools << t15
library.tools << t16
library.tools << t19
library.tools << t20
library.tools << t21
library.tools << t22
library.tools << t24
library.tools << t25
library.tools << t27
library.tools << t28
library.tools << t29

framework = Category.create({category: 'framework'})
framework.tools << t12
framework.tools << t17
framework.tools << t23
framework.tools << t26

assets = Category.create({category: 'assets'})
assets.tools << t3
assets.tools << t4
assets.tools << t5

packageManager = Category.create({category: 'package manager'})
packageManager.tools << t18

