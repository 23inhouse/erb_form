module ErbForm
  class Template
    
    attr_accessor :object_name, :method, :helper_method_name, :virtual_path, :options, :template
    
    def initialize(object_name, method, helper_method_name, virtual_path, options)
      @object_name, @method, @helper_method_name, @virtual_path, @options = object_name, method, helper_method_name, virtual_path, options
      @template = extract_template(options)
    end
    
    def locals
      self.template = {:template => template} unless template.respond_to?(:keys)
      self.template[:hint] = (template[:hint] || '').html_safe unless template[:hint] === false
      self.template[:label] = (template[:label] || method.to_s.humanize).html_safe unless template[:label] === false
      self.template[:required] = options[:object].class.validators_on(method).any? { |v| v.kind == :presence } if template[:required].nil?
      self.template[:required] = template[:required] ? I18n.t(:"erb_form.required.mark", :default => '*') : ''
      
      {
        :form => options.delete(:form),
        :helper_method_name => helper_method_name,
        :method => method,
        :object => options[:object],
        :object_name => object_name,
        :options => options.merge(:template => false),
        :template => template
      }
    end
    
    def file
      rendered_from = virtual_path.split('/')[0...-1].join('/')
      resource = options[:object].class.to_s.pluralize.downcase
      
      template_path = ActionView::PathSet.new(Array.wrap('app/views'))
      details = {:locale => [:en, :en], :formats => [:html], :handlers => [:erb, :rjs, :builder, :rhtml, :rxml]}
      path = ErbForm.forms_path
      [
        [path, template_name, helper_method_name.to_s+'_fields'].join('/'), # forms/custom/text_field_fields.html.erb
        [path, template_name, 'fields'].join('/'),                          # forms/custom/fields.html.erb
        [rendered_from, method.to_s+'_field'].join('/'),                    # blog/title_field.html.erb
        [rendered_from, helper_method_name.to_s+'_fields'].join('/'),       # blog/text_field_fields.html.erb
        [path, 'default', helper_method_name.to_s+'_fields'].join('/'),     # forms/default/text_field_fields.html.erb
        [path, 'default', 'input_field_fields'].join('/')                   # forms/default/input_field_fields.html.erb
      ].find do |template_file|
        template_path.exists?(template_file, '', false, details)
      end || '.not_found.'
    end
    
  private
    
    def extract_template(options)
      options[:template] || {}
    end
    
    def template_name
      (template.respond_to?(:keys) ? template[:template] : template).to_s
    end
    
  end
end
