require "rubygems"
require "bundler"

module <%= app_const_base %>
  class Application

    def self.routes
      @_routes ||= eval(File.read('./config/routes.rb'))
    end

  end
end

Bundler.require(:default)
