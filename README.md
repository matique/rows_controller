Rows
====

DRYs Rails controllers. Imagine replacing that @order by 'resource' in the
controllers/views and, imho, an area for DRYing appears.
Instead of:

    class OrdersController < ApplicationController
      ...

use:

    class OrdersController < RowsController  # < ApplicationController


The OrdersController may end there as RowsController has all the usual
methods (index, show, edit,...).

The methods may be redefined in OrdersController overwritting the
methods from RowsController.

Protected low level methods like 'resources' may be redefined as well.
An example:

    def resources
      @_resources ||= model_class.paginate(:page => params[:page])
    end

RowsController inherites from ApplicationController, i.e. all the helpers
defined there will be available.


Customization of views
----------------------

Providing e.g. an "#{Rails.root}/app/views/order/index.html.erb"
overwrites the default view as Rails will first look
into the directory "#{Rails.root}/app/views" before looking
into the RowsController.


model_class
-----------

RowsController guesses the model from params[:controller]. This can
be changed by e.g.:

    class OrdersController < RowsController
      model_class Booking

The model class can be retrieved with model_class.


## Enhancements

### copy

The method "copy" was added to the RowsController.
"copy" is like "new", however its attributes are initialized
from an existing resource.
The "id" of the cloned resource is set to nil.

Usage of "copy" requires a defining in config/routes.rb. An example:

    resources :orders
      get 'copy', :on => :member
    end

### columns

Add a class method 'column_headers' to the model
returning the columns to be displayed by '#index'.
Default is to display the columns returned by 'content_columns',
a class method which returns the columns defined by the ActiveRecord model.


## Installation and Testing

As usual:

    gem 'rows_controller' # in Gemfile
    bundle
    ( cd spec/dummy; rake db:create db:migrate )
    rake


## Credits

Inspiration from the web.
Look for:

- Radiant
- inherited_resources
- decent_exposure


Copyright (c) 2009-2011 [Dittmar Krall], released under the MIT license
