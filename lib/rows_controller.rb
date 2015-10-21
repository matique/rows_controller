require 'rows_controller/engine'

module Rows
end

I18n.load_path << File.expand_path('../rows_controller/locales/en.yml', __FILE__)
I18n.load_path << File.expand_path('../rows_controller/locales/de.yml', __FILE__)
I18n.reload!
