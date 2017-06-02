
module PrismicRails
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../../templates", __FILE__)

    desc "Creates a PrismicRails initializer and copy locale files to your application."
     def create_initializer_file
       template "prismic_rails.rb", "config/initializers/prismic_rails.rb"
     end
  end

end
