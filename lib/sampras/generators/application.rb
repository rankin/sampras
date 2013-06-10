require 'thor/group'
require 'active_support/core_ext/string/strip'
require 'active_support/inflector/methods'
require 'active_support/core_ext/object/blank'

module Sampras
  module Generators

    class Application < Thor::Group
      include Thor::Actions

      argument :application_path, :type => :string

      def initialize(*args, options)
        raise Thor::Error, "No application name supplied. Please run: sampras --help" if args[0].blank?
        super
      end

      def self.source_root
        @_source_root ||= File.join(File.dirname(__FILE__), "templates/application")
      end

      def self.banner
        "sampras new #{self.arguments.map(&:usage).join(' ')} [options]"
      end

      def create_root
        self.destination_root = File.expand_path(application_path, destination_root)
        valid_const?

        empty_directory '.'
        FileUtils.cd(destination_root)
      end

      def create_root_files
        template 'config.ru'
        template 'Gemfile'
        template 'application.rb'
        template 'Rakefile'
        template 'index.html'
        template 'sampras', '.sampras'
        
        empty_directory "public"
        empty_directory "public/javascripts"
      end

      def create_config
        empty_directory "config"

        inside "config" do
          template "routes.rb"
        end
      end

      def create_sources_dir
        empty_directory "sources"
        empty_directory "sources/users"

        inside "sources/users" do
          template "get_users.json"
          template "delete_users.json"
          template "put_users.json"
          template "post_users.json"
          template "match_users.json"
        end
      end

      protected

      def app_name
        @app_name ||= File.basename(destination_root)
      end

      def app_const
        @app_const ||= "#{app_const_base}::Application"
      end

      def app_const_base
        @app_const_base ||= ActiveSupport::Inflector.camelize(app_name.gsub(/\W/, '_').squeeze('_'), true)
      end

      def valid_const?
        if app_const =~ /^\d/
          raise Thor::Error, "Invalid application name #{app_name}. Please give a name which does not start with numbers."
        elsif Object.const_defined?(app_const_base)
          raise Thor::Error, "Invalid application name #{app_name}, constant #{app_const_base} is already in use. Please choose another application name."
        end
      end
    end

  end
end
