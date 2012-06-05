module ErbForm
  module ActionViewExtensions
    module FormHelper
      def erb_form_for(record, options={}, &block)
        options[:builder] ||= ErbForm::Builder
        options[:html] ||= {}

        form_for(record, options, &block)
      end

      def erb_fields_for(record_name, record_object = nil, options = {}, &block)
        options, record_object = record_object, nil if record_object.is_a?(Hash) && record_object.extractable_options?
        options[:builder] ||= ErbForm::Builder

        fields_for(record_name, record_object, options, &block)
      end
    end
  end
end

ActionView::Base.send :include, ErbForm::ActionViewExtensions::FormHelper
