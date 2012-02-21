require "erb_form/version"

require 'simple_form'
require 'erb_form/builder'

module ErbForm
  # Default form and report template paths
  mattr_accessor :forms_path
  @@forms_path = 'forms'
end
