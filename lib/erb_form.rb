require "erb_form/version"

require 'action_view'
require 'erb_form/template'
require 'erb_form/action_view_extensions/builder'
require 'erb_form/action_view_extensions/form_helper'

module ErbForm
  # Default form and report template paths
  mattr_accessor :forms_path
  @@forms_path = 'forms'
  
  # Default way to setup ErbForm. Run rails generate erb_form:install
  # to create a fresh initializer with all configuration values.
  def self.setup
    yield self
  end
end
