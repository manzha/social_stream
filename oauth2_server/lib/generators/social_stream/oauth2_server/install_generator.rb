class SocialStream::Oauth2Server::InstallGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  
  source_root File.expand_path('../templates', __FILE__)

  def create_migration_file
    require 'rake'
    Rails.application.load_tasks
    Rake::Task['railties:install:migrations'].reenable
    Rake::Task['social_stream_oauth2_server_engine:install:migrations'].invoke
  end

  def require_javascripts
    inject_into_file 'app/assets/javascripts/application.js',
                     "//= require social_stream-oauth2_server\n",
                     :before => '//= require_tree .'
  end

  def require_stylesheets
    inject_into_file 'app/assets/stylesheets/application.css',
                     " *= require social_stream-oauth2_server\n",
                     :before => ' *= require_tree .'
  end
end
