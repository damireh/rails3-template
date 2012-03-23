## Rails 3 Application Template

This is the Rails template I use to facilitate the quick setup of new Rails applications

### Overview
---
* Sets up RVM with your choice of Ruby and gemset
* Removes Rails default files (index.html, rails.png)
* Removes timestamps from migrations
* Sets up a Git Repo
* Integrates [Twitter Bootstrap](http://twitter.github.com/bootstrap/) (v2.0.2)
* Integrates parts of the [HTML5Boilerplate](http://html5boilerplate.com/) (v3.0)
* Adds Thin, Devise, CanCan, FriendlyId, Paperclip, Debugger and Minitest to Gemfile
* Sets up Test environment using MiniTest (use `rake test` to run your tests)
* Sets up Devise and CanCan, and generates a User model
* Sets up Paperclip and adds Avatar to User
* Sets up FriendlyId and adds slug on username
* Adds alerts and form error messages partials
* Generates welcome controller with root route set to index action

### Prerequisites
---
[RVM](http://beginrescueend.com) with at least one Ruby installed.

### Usage
---
Clone the repository using

`git clone git://github.com/damireh/rails3-template.git`

Create a new Rails application as normal, specifying the path to the template script with the *-m* flag

`rails new appname -m rails3-template/template.rb`

### Credits
---

Based on [greendog99](https://github.com/greendog99/greendog-rails-template)'s rails template

* [http://blog.madebydna.com/all/code/2010/10/11/cooking-up-a-custom-rails3-template.html](http://blog.madebydna.com/all/code/2010/10/11/cooking-up-a-custom-rails3-template.html)
* [http://m.onkey.org/rails-templates](http://m.onkey.org/rails-templates)
* [http://guides.rubyonrails.org/generators.html#application-templates](http://guides.rubyonrails.org/generators.html#application-templates)
* [http://textmate.rubyforge.org/thor/Thor/Actions.html](http://textmate.rubyforge.org/thor/Thor/Actions.html)
