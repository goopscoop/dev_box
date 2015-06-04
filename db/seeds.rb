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
t1 = Tool.create({title: 'Moment.js', description: 'Parse, validate, manipulate, and display dates in JavaScript.', language: 'javascript', is_free: 1, web_url: 'http://momentjs.com/', repo_url: 'https://github.com/moment/moment/', avg_rating: 5})
t2 = Tool.create({title: 'ramjet', description: 'Ramjet makes it looks as though one DOM element is capable of transforming into another, no matter where the two elements sit in the DOM tree. It does so by making copies of the two elements (and all their children), setting a fixed position on each, then using CSS transforms to morph the two elements in sync.', language: 'CSS', is_free: 1, web_url: 'http://www.rich-harris.co.uk/ramjet/', repo_url: 'https://github.com/rich-harris/ramjet', avg_rating: 5})
t3 = Tool.create({title: 'Nifty Modal Window Effects', description: 'Some inspiration for different modal window appearances', language: 'javascript', is_free: 1, web_url: 'http://tympanus.net/Development/ModalWindowEffects/', repo_url: '', avg_rating: 5})
t4 = Tool.create({title: 'Creative Link Effects', description: 'Subtle and modern effects for links or menu items', language: 'javascript', is_free: 1, web_url: 'http://tympanus.net/Development/CreativeLinkEffects/', repo_url: '', avg_rating: 5})
t5 = Tool.create({title: 'Creative Loading Effects', description: 'Loading animations don\'t have to be restricted to a tiny indicator. Here is some inspiration for some creative loading effects.*', language: 'javascript', is_free: 1, web_url: '', avg_rating: 5, repo_url: 'http://tympanus.net/Development/CreativeLoadingEffects/'})
t6 = Tool.create({title: 'scrollReveal.js', description: 'Easily reveal elements as they enter the viewport.', language: 'javascript', is_free: 1, web_url: 'http://scrollrevealjs.org/', repo_url: 'https://github.com/julianlloyd/scrollReveal.js', avg_rating: 5})
t7 = Tool.create({title: 'jQuery Scoll Path', description: 'It\'s a plugin for defining custom scroll paths.', language: 'javascript', is_free: 1, web_url: 'http://joelb.me/scrollpath/', repo_url: 'https://github.com/JoelBesada/scrollpath', avg_rating: 5})
t8 = Tool.create({title: 'Animate.css', description: 'Just-add-water CSS animations', language: 'css', is_free: 1, web_url: 'http://daneden.github.io/animate.css/', repo_url: 'https://github.com/daneden/animate.css', avg_rating: 5})
t9 = Tool.create({title: 'Lettering.JS', description: 'Web type is exploding all over the web but CSS currently doesn\'t offer complete down-to-the-letter control. So we created a jQuery plugin to give you that control. Here are a few examples of what can easily be done with Lettering.js:', avg_rating: 3, language: 'javascript', is_free: 1, web_url: 'http://letteringjs.com/', repo_url: 'https://github.com/davatron5000/Lettering.js'})
t10 = Tool.create({title: 'Skrollr', description: ' Stand-alone parallax scrolling library for mobile (Android + iOS) and desktop. No jQuery. Just plain JavaScript (and some love).', language: 'javascript', is_free: 1, web_url: 'http://prinzhorn.github.io/skrollr/', repo_url: 'https://github.com/Prinzhorn/skrollr', avg_rating: 5})
t11 = Tool.create({title: 'Scrolldeck', description: 'A jQuery plugin for making scrolling presentation decks', language: 'javascript', is_free: 1, web_url: 'https://johnpolacek.github.io/scrolldeck.js', repo_url: 'https://github.com/johnpolacek/scrolldeck.js', avg_rating: 5})
t12 = Tool.create({title: 'Famous', description: 'Famous abstracts the DOM & WebGL, allowing you to do custom layout and rendering. Centering objects and rotating them can be done with only a few lines of code.', language: 'javascript', is_free: 1, web_url: 'http://famous.org/', repo_url: '', avg_rating: 4})
t13 = Tool.create({title: 'Skipper', description: 'Skipper makes it easy to implement streaming file uploads to disk, S3, or any of its supported file adapters.', language: 'javascript', is_free: 1, web_url: '', repo_url: 'https://github.com/balderdashy/skipper', avg_rating: 2})
t14 = Tool.create({title: 'Waterline', description: 'Waterline is a brand new kind of storage and retrieval engine. It provides a uniform API for accessing stuff from different kinds of databases, protocols, and 3rd party APIs. That means you write the same code to get and store things like users, whether they live in Redis, mySQL, LDAP, MongoDB, or Postgres. Waterline strives to inherit the best parts of ORMs like ActiveRecord, Hibernate, and Mongoose, but with a fresh perspective and emphasis on modularity, testability, and consistency across adapters.', language: 'javascript', is_free: 1, web_url: 'https://github.com/balderdashy/waterline-docs', repo_url: 'https://github.com/balderdashy/waterline'})
t15 = Tool.create({title: 'Mongoose', description: 'Elegant MongoDB object modeling for Node.js', language: 'javascript', is_free: 1, web_url: 'http://mongoosejs.com/', repo_url: 'https://github.com/Automattic/mongoose', avg_rating: 1})
t16 = Tool.create({title: 'bcrypt', description: 'A bcrypt library for NodeJS.', language: 'javascript', is_free: 1, web_url: 'https://www.npmjs.com/package/bcrypt', repo_url: 'https://github.com/ncb000gt/node.bcrypt.js', avg_rating: 4})
t17 = Tool.create({title: 'Ionic', description: ' The beautiful, open source front-end SDK for developing hybrid mobile apps with HTML5.', language: 'javascript', is_free: 1, web_url: 'http://ionicframework.com/', repo_url: '', avg_rating: 5})
t18 = Tool.create({title: 'NPM', description: 'A package manager for javascript and a lot of other stuff.', language: '', is_free: 1, web_url: 'https://www.npmjs.com/', repo_url: '', avg_rating: 1})
t19 = Tool.create({title: 'Foreman', description: 'Manage Procfile-based applications', language: 'ruby', is_free: 1, web_url: 'https://github.com/ddollar/foreman', repo_url: '', avg_rating: 4})
t20 = Tool.create({title: 'Passport', description: 'Passport is authentication middleware for Node.js. Extremely flexible and modular, Passport can be unobtrusively dropped in to any Express-based web application. A comprehensive set of strategies support authentication using a username and password, Facebook, Twitter, and more.', language: 'javascript', is_free: 1, web_url: 'http://passportjs.org', repo_url: 'https://github.com/jaredhanson/passport', avg_rating: 2})
t21 = Tool.create({title: 'Debug', description: "tiny node.js debugging utility modelled after node core's debugging technique.", language: 'javascript', is_free: 1, web_url: 'https://www.npmjs.com/package/debug', repo_url: 'https://github.com/visionmedia/debug', avg_rating: 5})
t22 = Tool.create({title: 'Noty', description: 'NOTY is a jQuery plugin that makes it easy to create alert - success - error - warning - information - confirmation messages as an alternative the standard alert dialog. Each notification is added to a queue. (Optional)', language: 'javascript', is_free: 1, web_url: 'http://ned.im/noty/#/about', repo_url: 'https://github.com/needim/noty/', avg_rating: 5})
t23 = Tool.create({title: 'Sails', description: 'Sails makes it easy to build custom, enterprise-grade Node.js apps. It is designed to emulate the familiar MVC pattern of frameworks like Ruby on Rails, but with support for the requirements of modern apps: data-driven APIs with a scalable, service-oriented architecture. It\'s especially good for building chat, realtime dashboards, or multiplayer games; but you can use it for any web application project - top to bottom.', language: 'javascript', is_free: 1, web_url: 'http://sailsjs.org', repo_url: 'https://github.com/balderdashy/sails/', avg_rating: 5})
t24 = Tool.create({title: 'Async.js', description: 'Async is a utility module which provides straight-forward, powerful functions for working with asynchronous JavaScript. Although originally designed for use with Node.js and installable via npm install async, it can also be used directly in the browser.', language: 'javascript', is_free: 1, web_url: '', repo_url: 'https://github.com/caolan/async', avg_rating: 3})
t25 = Tool.create({title: 'body-parser', description: 'Node.js body parsing middleware.', language: 'javascript', is_free: 1, web_url: '', repo_url: 'https://github.com/expressjs/body-parser', avg_rating: 2})
t26 = Tool.create({title: 'ExpressJS', description: 'Fast, unopinionated, minimalist web framework for Node.js', language: 'javascript', is_free: 1, web_url: 'http://expressjs.com', repo_url: 'https://github.com/strongloop/expressjs.com', avg_rating: 4})
t27 = Tool.create({title: 'Easy table', description: 'Nice utility for rendering text tables with javascript.', language: 'javascript', is_free: 1, web_url: '', repo_url: 'https://github.com/eldargab/easy-table', avg_rating: 5})
t28 = Tool.create({title: 'Sequelize', description: 'Sequelize is a promise-based ORM for Node.js and io.js. It supports the dialects PostgreSQL, MySQL, MariaDB, SQLite and MSSQL and features solid transaction support, relations, read replication and more.', language: 'javascript', is_free: 1, web_url: 'http://docs.sequelizejs.com', repo_url: 'https://github.com/sequelize/sequelize', avg_rating: 1})
t29 = Tool.create({title: 'sequelize/cli', description: 'The Sequelize Command Line Interface', language: 'javascript', is_free: 1, web_url: '', repo_url: 'https://github.com/sequelize/cli', avg_rating: 5})
t30 = Tool.create({title: 'AngularJS', description: 'HTML is great for declaring static documents, but it falters when we try to use it for declaring dynamic views in web-applications. AngularJS lets you extend HTML vocabulary for your application. The resulting environment is extraordinarily expressive, readable, and quick to develop.', language: 'javascript', is_free: 1, web_url: 'https://angularjs.org/', doc_url: 'https://angularjs.org/', repo_url: 'http://cdnjs.com/libraries/angular.js/', avg_rating: 5})
t31 = Tool.create({title: 'UI Bootstrap', description: 'Bootstrap components written in pure AngularJS by the AngularUI Team', language: 'javascript', is_free: 1, web_url: 'http://angular-ui.github.io/bootstrap/', doc_url: 'http://angular-ui.github.io/bootstrap/', repo_url: 'https://github.com/angular-ui/bootstrap', avg_rating: 5})
t32 = Tool.create({title: 'lumx', description: 'The first responsive front-end framework based on AngularJS & Google Material Design specifications.', language: 'javascript', is_free: 1, web_url: 'http://ui.lumapps.com/', doc_url: 'http://ui.lumapps.com/directives/dropdowns', repo_url: 'https://github.com/lumapps/lumX/', avg_rating: 5})
t33 = Tool.create({title: 'ngAnimate', description: 'The ngAnimate module provides support for CSS-based animations (keyframes and transitions) as well as JavaScript-based animations via callback hooks. Animations are not enabled by default, however, by including ngAnimate then the animation hooks are enabled for an Angular app.', language: 'javascript', is_free: 1, web_url: 'https://docs.angularjs.org/api/ngAnimate', doc_url: 'https://docs.angularjs.org/api/ngAnimate', repo_url: '', avg_rating: 5})
t34 = Tool.create({title: 'Angular Material', description: 'The Angular Material project is an implementation of Material Design in Angular.js. This project provides a set of reusable, well-tested, and accessible UI components based on the Material Design system.', language: 'javascript', is_free: 1, web_url: 'https://material.angularjs.org', repo_url: 'https://github.com/angular/material/tree/v0.9.7', doc_url: 'https://material.angularjs.org/latest/#/getting-started', avg_rating: 5})
t35 = Tool.create({title: 'ngInfinite Scroll', description: 'ngInfiniteScroll is a directive that you can use to implement infinite scrolling in your AngularJS applications. Simply declare which function to call when the user gets close to the bottom of the content with the directive and the module will take care of the rest. Of course, you can specify several options to ensure that the behavior is just what you\'re looking for.', language: 'javascript', is_free: 1, web_url: 'https://sroze.github.io/ngInfiniteScroll/', repo_url: 'https://github.com/sroze/ngInfiniteScroll', doc_url: 'https://sroze.github.io/ngInfiniteScroll/documentation.html', avg_rating: 5})
t36 = Tool.create({title: 'spin.js', description: 'Spin.js dynamically creates spinning activity indicators that can be used as resolution-independent replacement for AJAX loading GIFs.', language: 'javascript', is_free: 1, web_url: 'http://fgnass.github.io/spin.js/', repo_url: 'http://github.com/fgnass/spin.js', doc_url: 'http://fgnass.github.io/spin.js/', avg_rating: 5})
t37 = Tool.create({title: 'Typhoeus', description: 'Like a modern code version of the mythical beast with 100 serpent heads, Typhoeus runs HTTP requests in parallel while cleanly encapsulating handling logic.', language: 'ruby', is_free: 1, web_url: 'https://github.com/typhoeus/typhoeus', repo_url: 'https://github.com/typhoeus/typhoeus', doc_url: 'https://github.com/typhoeus/typhoeus', avg_rating: 5})

# Create Tags
terminal = Category.create({category:'terminal'})
terminal.tools << t29
terminal.tools << t27

gems = Tag.create({tag:'gem'})
gems.tools << t37

rails = Tag.create({tag:'rails'})
rails.tools << t37

requests = Tag.create({tag: 'requests'})
requests.tools << t37

angular = Tag.create({tag:'angular.js'})
angular.tools << t30
angular.tools << t31
angular.tools << t32
angular.tools << t33
angular.tools << t34
angular.tools << t35

directive = Tag.create({tag:'directive'})
directive.tools << t31
directive.tools << t32
directive.tools << t33
directive.tools << t34
directive.tools << t35

pagination = Tag.create({tag:'pagination'})
pagination.tools << t35

responsive = Tag.create({tag:'responsive'})
responsive.tools << t31
responsive.tools << t32
responsive.tools << t34
responsive.tools << t35

jquery = Tag.create(tag:'jquery')
jquery.tools << t22
jquery.tools << t36

oauth = Tag.create(tag:'oauth')
oauth.tools << t20

date = Tag.create(tag:'date')
date.tools << t1

time = Tag.create(tag:'time')
time.tools << t1

sails = Tag.create(tag:'sails.js')
sails.tools << t13

node = Tag.create(tag:'node.js')
node.tools << t15
node.tools << t23
node.tools << t20
node.tools << t21
node.tools << t25
node.tools << t26
node.tools << t28

font = Tag.create(tag:'font')
font.tools << t9

animate = Tag.create(tag:'animation')
animate.tools << t2
animate.tools << t10
animate.tools << t8
animate.tools << t5
animate.tools << t6
animate.tools << t7
animate.tools << t33
animate.tools << t35
animate.tools << t36


frontend = Tag.create({tag:'frontend'})
frontend.tools << t36
frontend.tools << t35
frontend.tools << t33
frontend.tools << t34
frontend.tools << t32
frontend.tools << t31
frontend.tools << t30
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
backend.tools << t37
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

loading = Tag.create({tag:'loading'})
loading.tools << t36

# Create Categories
# Associate Tools to Categories

library = Category.create({category: 'library'})
library.tools << t37
library.tools << t36
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
library.tools << t35

framework = Category.create({category: 'framework'})
framework.tools << t1
framework.tools << t31
framework.tools << t32
framework.tools << t34
framework.tools << t33
framework.tools << t30
framework.tools << t12
framework.tools << t17
framework.tools << t23
framework.tools << t26

assets = Category.create({category: 'assets'})
assets.tools << t1
assets.tools << t3
assets.tools << t4
assets.tools << t5
assets.tools << t31
assets.tools << t35

packageManager = Category.create({category: 'package manager'})
packageManager.tools << t18


text = Category.create({category:'text-editory/ide'})
image = Category.create({category:'image editor'})
team = Category.create({category:'team communication'})
project = Category.create({category:'project management'})
prototype = Category.create({category:'prototype builder'})


tv1 = Tvote.create(vote:75)
t1.tvotes << tv1
Cody.tvotes << tv1
tv2 = Tvote.create(vote:1)
t1.tvotes << tv2
Nick.tvotes << tv2
tv3 = Tvote.create(vote:100)
t2.tvotes << tv3
Cody.tvotes << tv3
tv4 = Tvote.create(vote:6)
t3.tvotes << tv4
Nick.tvotes << tv4
tv5 = Tvote.create(vote:15)
t3.tvotes << tv5
Cody.tvotes << tv5
tv6 = Tvote.create(vote:1)
t4.tvotes << tv6
Nick.tvotes << tv6
tv7 = Tvote.create(vote:20)
t5.tvotes << tv7
Nick.tvotes << tv7
tv8 = Tvote.create(vote:75)
t5.tvotes << tv8
Cody.tvotes << tv8
tv9 = Tvote.create(vote:1)
t6.tvotes << tv9
Nick.tvotes << tv9
tv10 = Tvote.create(vote:100)
t7.tvotes << tv10
Cody.tvotes << tv10
tv11 = Tvote.create(vote:6)
t8.tvotes << tv11
Nick.tvotes << tv11
tv12 = Tvote.create(vote:15)
t9.tvotes << tv12
Cody.tvotes << tv12
tv13 = Tvote.create(vote:1)
t10.tvotes << tv13
Nick.tvotes << tv13
tv14 = Tvote.create(vote:20)
t11.tvotes << tv14
Nick.tvotes << tv14
tv15 = Tvote.create(vote:75)
t12.tvotes << tv15
Cody.tvotes << tv15
tv16 = Tvote.create(vote:1)
t13.tvotes << tv16
Nick.tvotes << tv16
tv17 = Tvote.create(vote:100)
t14.tvotes << tv17
Cody.tvotes << tv17
tv18 = Tvote.create(vote:6)
t15.tvotes << tv18
Nick.tvotes << tv18
tv19 = Tvote.create(vote:15)
t16.tvotes << tv19
Cody.tvotes << tv19
tv20 = Tvote.create(vote:1)
t17.tvotes << tv20
Nick.tvotes << tv20
tv21 = Tvote.create(vote:20)
t18.tvotes << tv21
Nick.tvotes << tv21
tv22 = Tvote.create(vote:75)
t19.tvotes << tv22
Cody.tvotes << tv22
tv23 = Tvote.create(vote:1)
t20.tvotes << tv23
Nick.tvotes << tv23
tv24 = Tvote.create(vote:100)
t21.tvotes << tv24
Cody.tvotes << tv24
tv25 = Tvote.create(vote:6)
t22.tvotes << tv25
Nick.tvotes << tv25
tv26 = Tvote.create(vote:15)
t23.tvotes << tv26
Cody.tvotes << tv26
tv27 = Tvote.create(vote:1)
t24.tvotes << tv27
Nick.tvotes << tv27
tv28 = Tvote.create(vote:20)
t25.tvotes << tv28
Nick.tvotes << tv28
tv29 = Tvote.create(vote:6)
t26.tvotes << tv29
Nick.tvotes << tv29
tv30 = Tvote.create(vote:15)
t27.tvotes << tv30
Cody.tvotes << tv30
tv31 = Tvote.create(vote:1)
t28.tvotes << tv31
Nick.tvotes << tv31
tv32 = Tvote.create(vote:20)
t29.tvotes << tv32
Nick.tvotes << tv32
