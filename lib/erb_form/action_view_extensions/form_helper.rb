module ErbForm
  module ActionViewExtensions
    module FormHelper
      different_methods = ['form_for', 'apply_form_for_options!', 'fields_for', 'label', 'check_box', 'radio_button', 'select', 'hidden_field']
      (ActionView::Helpers::FormHelper.instance_method_names - different_methods).each do |helper_method_name|
        module_eval <<-METHOD, __FILE__, __LINE__ + 1
          def #{helper_method_name}(object_name, method, options = {})
            begin
              raise template_error if !template?(options) || caller.first.include?("/app/views/")
              erb_template = ErbForm::Template.new(object_name, method, '#{helper_method_name}', @_virtual_path, options)
              render(:template => erb_template.file, :locals => erb_template.locals)
            rescue ActionView::MissingTemplate
              super(object_name, method, clean_options(options))
            end
          end
        METHOD
      end
      
      def check_box(object_name, method, options = {}, checked_value = "1", unchecked_value = "0")
        begin
          raise template_error if !template?(options) || caller.first.include?("/app/views/")
          erb_template = ErbForm::Template.new(object_name, method, :check_box, @_virtual_path, options)
          render(:template => erb_template.file, :locals => erb_template.locals.merge(:checked_value => checked_value, :unchecked_value => unchecked_value))
        rescue ActionView::MissingTemplate
          super(object_name, method, clean_options(options), checked_value, unchecked_value)
        end
      end
      
      def radio_button(object_name, method, tag_value, options = {})
        begin
          raise template_error if !template?(options) || caller.first.include?("/app/views/")
          erb_template = ErbForm::Template.new(object_name, method, :radio_button, @_virtual_path, options)
          render(:template => erb_template.file, :locals => erb_template.locals.merge(:tag_value => tag_value))
        rescue ActionView::MissingTemplate
          super(object_name, method, tag_value, clean_options(options))
        end
      end
      
      def select(object_name, method, choices, options = {}, html_options = {})
        begin
          raise template_error if !template?(options) || caller.first.include?("/app/views/")
          erb_template = ErbForm::Template.new(object_name, method, :select, @_virtual_path, options)
          render(:template => erb_template.file, :locals => erb_template.locals.merge(:choices => choices))
        rescue ActionView::MissingTemplate
          super(object_name, method, choices, options, html_options)
        end
      end
      
      ([:date_select, :time_select, :datetime_select]).each do |helper_method_name|
        module_eval <<-METHOD, __FILE__, __LINE__ + 1
          def #{helper_method_name}(object_name, method, options = {}, html_options = {})
            begin
              raise template_error if !template?(options) || caller.first.include?("/app/views/")
              erb_template = ErbForm::Template.new(object_name, method, '#{helper_method_name}', @_virtual_path, options)
              render(:template => erb_template.file, :locals => erb_template.locals)
            rescue ActionView::MissingTemplate
              super(object_name, method, clean_options(options), html_options = {})
            end
          end
        METHOD
      end
      
    private
      
      def method_missing(helper_method_name, *args)
        if !%w[hidden].include?(helper_method_name) && helper_method_name =~ /^(\w+)_field$/
          object_name, method, options = args[0], args[1], args[2]
          begin
            raise template_error if !template?(options) || caller.first.include?("/app/views/")
            erb_template = ErbForm::Template.new(object_name, method, helper_method_name, @_virtual_path, options)
            render(:template => erb_template.file, :locals => erb_template.locals)
          rescue ActionView::MissingTemplate
            raise NoMethodError, "undefined method `#{helper_method_name}', try adding the file '#{helper_method_name}_fields.html.erb' to app/views/#{ErbForm.forms_path}"
          end
        end
      end
      
      def template?(options)
        !(options[:template] == false)
      end
      
      def template_error
        ActionView::MissingTemplate.new([], '1', '2', '3') # this will never be shown, it will be rescued by super
      end
      
      def clean_options(options)
        keys = [:template]
        options.dup.delete_if { |k, v| keys.include?(k) }
      end
    end
  end
end

ActionView::Base.send :include, ErbForm::ActionViewExtensions::FormHelper
