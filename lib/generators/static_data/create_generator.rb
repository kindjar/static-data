require 'rails/generators'
require 'rails/generators/named_base'

module StaticData
  module Generators
    class CreateGenerator < Rails::Generators::NamedBase
      desc "This generator creates a static-data file at db/static-data/<file_name>"

      source_root File.expand_path("../templates", __FILE__)

      def create_initializer_file
        template "static-data-subclass.erb", "db/static-data/#{file_name}.rb"
      end
    end
  end
end