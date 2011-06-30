module ErbForm
  module ActionViewExtensions
    module Builder
      def self.included(base)
        base.send(:alias_method, :objectify_options_original, :objectify_options)
        base.send(:remove_method, :objectify_options)
      end
      
    private
      def objectify_options(options)
        form_t = @options[:template]
        form_t = form_t[:template] if form_t.respond_to?(:keys)
        form_t = form_t.to_s if form_t.is_a?(Symbol)
        
        if options.has_key?(:template)
          field_t = options[:template]
          options[:template][:template] = form_t if field_t.respond_to?(:keys) && !field_t.has_key?(:template)
        else
          options[:template] = (form_t == false) ? false : { :template => form_t }
        end
        
        objectify_options_original(options)
      end
      
      def method_missing(helper_method_name, *args)
        method_name, options = args[0], (args[1] || {})
        @template.send(helper_method_name, @object_name, method_name, objectify_options(options))
      end
    end
  end
end

ActionView::Helpers::FormBuilder.send :include, ErbForm::ActionViewExtensions::Builder
