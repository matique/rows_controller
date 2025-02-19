# RowsController
[![Gem Version](https://badge.fury.io/rb/rows_controller.svg)](https://badge.fury.io/rb/rows_controller)
[![GEM Downloads](https://img.shields.io/gem/dt/rows_controller?color=168AFE&logo=ruby&logoColor=FE1616)](https://rubygems.org/gems/rows_controller)
[![rake](https://github.com/matique/rows_controller/actions/workflows/rake.yml/badge.svg)](https://github.com/matique/rows_controller/actions/workflows/rake.yml)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/standardrb/standard)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](http://choosealicense.com/licenses/mit/)

DRYs Rails controllers. Imagine replacing that @order by 'resource' in the
controllers/views and, IMHO, an area for DRYing appears.
Instead of:

~~~ruby
class OrdersController < ApplicationController
 .....          # quite a lot of lines from "rails generate scaffold ..."
 private
  def order_params
   params.require(:order).permit(:name)
  end
end
~~~

use:

~~~ruby
class OrdersController < RowsController  # < ApplicationController
 private
  def resource_whitelist
   %i{ name }
  end
end
~~~

I.e. RowsController defines all the usual methods (index, show, edit,...).

The methods may be redefined in OrdersController
(overwrites methods from RowsController).

Low level methods like 'resources' may be redefined as well.
An example:

~~~ruby
def resources
  @_resources ||= model_class.paginate(page: params[:page])
end
~~~

RowsController inherites from ApplicationController, i.e. all the helpers
defined there will be available.


## Customizing of views

RowsController initializes some instance variables used in the views
(e.g. @order, @orders; legacy @row & @rows are still supported).
Furthermore, the helpers resource, resources, set_resource and
set_resources are available. You guess their usage.

Providing e.g. an "#{Rails.root}/app/views/order/index.html.erb"
overwrites the default RowsController view as Rails will first look
into the directory "#{Rails.root}/app/views" before looking
into the RowsController.

Similarly, partials '\_row\_buttons' and '\_list\_footer' may be overwritten
as well.


## model_class

RowsController guesses the model from params[:controller]. This can
be changed by:

~~~ruby
class OrdersController < RowsController
  model_class Booking
  ...
~~~

The model class can be retrieved with the helper model_class.


## Rails 8

RowsController 3.2.* is intended for Rails 8+.
In particular, *turbo stream* is used for row deletion.
Older Rails versions may use "gem 'rows_controller', '= 3.1.7'".


## Rails 7

RowsController 3.1.* is intended for Rails 7.
In particular Hotwire caused some quirks
which are handled by this version.
Compatibility with older Rails versions are not intended
and has not been checked.

Older Rails versions may use "gem 'rows_controller', '= 3.0.5'".


## Rails 6

This gem is intended for Rails 6.
Older Rails versions may use "gem 'rows_controller', '= 2.2.2'".


## Rails 5

This gem is intended for Rails 5.
Older Rails versions may use "gem 'rows_controller', '= 2.0.8'".


## Rails 4

This gem is intended for Rails 4.
Older Rails versions may use "gem 'rows_controller', '= 1.1.9'".

Rails 4 introduced strong parameters.
To support them a private method 'resource_whitelist' is required
in the controllers.
Alternatively you may define the private method 'resource_params'
in the controller to filter params.

## Enhancements

### columns

Add a class method 'column_headers' to the model
returning the columns to be displayed by '#index'.
Default is to display the columns returned by 'content_columns',
a class method which returns the columns defined by the ActiveRecord model.


## Installation and Testing

As usual:

~~~ruby
gem "rows_controller" # in Gemfile
bundle
( cd spec/dummy; rake db:create db:migrate ) # not required for Rails 6+
rake
~~~


## Credits

Inspiration from the web.
Look for:

- Radiant
- inherited_resources
- decent_exposure

## Miscellaneous

Copyright (c) 2009-2025 Dittmar Krall (www.matiq.com),
released under the [MIT license](https://opensource.org/licenses/MIT).
