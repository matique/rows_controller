require 'rows/engine'

module Rows
end

I18n.load_path << File.expand_path('../rows/locales/en.yml', __FILE__)
I18n.load_path << File.expand_path('../rows/locales/de.yml', __FILE__)
I18n.reload!
