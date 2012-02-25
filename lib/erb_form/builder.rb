module ErbForm
  class Builder < ::SimpleForm::FormBuilder
    def field(attribute_name, options = {})
      raise ErbForm::DoubleRenderError.new(clean_backtrace(caller)), nil, clean_backtrace(caller) if recursing?
      @prevent_recursion = true
      @field_layout = options.delete(:layout)
      render_field(attribute_name, options)
    rescue ActionView::MissingTemplate => e
      raise ErbForm::MissingTemplate.new(field_layouts(attribute_name)), nil, clean_backtrace(e.backtrace)
    end

  private

    def clean_backtrace(backtrace)
      unless backtrace[0].scan(__FILE__).size > 0
        backtrace = backtrace.collect { |line| line.scan(__FILE__).size > 0 ? nil : line }.compact!
      end
    end

    def field_layouts(attribute_name)
      template_path = caller.select { |line| line.scan(template.view_paths.first.to_s).size > 0 }.first
      template_path = template_path.split('/')[0...-1].join('/').gsub(template.view_paths.first.to_s, '')

      file = @field_layout.nil? ? attribute_name.to_s : @field_layout
      [
        [ErbForm.forms_path, @field_layout, attribute_name.to_s+'_field'],  # forms/custom_layout/attribute_name_field.html.erb
        [template_path, file+'_field'],                                     # template_path/attribute_name_field.html.erb
        [ErbForm.forms_path, @field_layout, 'field'],                       # forms/custom_layout/field.html.erb
        [ErbForm.forms_path, 'default', file+'_field'],                     # forms/attribute_name_field.html.erb
        [ErbForm.forms_path, 'default', 'field']                            # forms/attribute_name/field.html.erb
      ].delete_if { |template_array|
        template_array.include? nil
      }.map { |template_array|
        template_array.join('/')
      }
    end

    def field_template_path(attribute_name)
      field_layouts(attribute_name).detect { |template_file|
        template.view_paths.exists?(template_file, '', false, {
          :locale => [template.locale],
          :formats => template.formats,
          :handlers => [:erb, :rjs, :builder, :rhtml, :rxml]
        })
      }
    end

    def field_template_file(attribute_name)
      '/' + (field_template_path(attribute_name) || 'a_non_existant_file_to_force_a_missing_template_error')
    end

    def locals(attribute_name, options)
      options.except(:form, :attribute_name, :as, :collection, :required, :error, :hint, :input, :label).tap { |o|
        o[:form] = self
        o[:attribute_name] = attribute_name
        o[:error_options] = simplify_options(:error, options)
        o[:hint_options] = simplify_options(:hint, options)
        o[:input_options] = simplify_options(:input, options)
        o[:label_options] = simplify_options(:label, options)
      }
    end

    def recursing?
      !!@prevent_recursion
    end

    def render_field(attribute_name, options)
      output = template.render(:file => field_template_file(attribute_name), :locals => locals(attribute_name, options))
      @prevent_recursion = false
      output
    end

    def simplify_options(key, options = {})
      newkey = case key
      when :error
        locals = { :error_prefix => options[:error] || options[:label] }
        :error_prefix
      when :input
        locals = { :input_html => options[:input] }
        locals.merge!(options.select { |k,v| [:as, :collection, :required].include?(k)})
        :input_html
      when :label
        locals = { :label => options[:label] }
        locals.merge!(options.select { |k,v| [:as, :required].include?(k)})
        :modified
      else
        locals = { key => options[key] }
        key
      end
      options[key].is_a?(Hash) && newkey == key ? options[key] : locals
    end
  end

  class DoubleRenderError < StandardError;
    def initialize(caller)
      @caller = caller
    end

    def message
      %(Called `field' from #{@caller.first})
    end
  end

  class MissingTemplate < StandardError;
    def initialize(failed_templates)
      @failed_templates = failed_templates
    end

    def message
      %(Missing Template, tried:\n - #{@failed_templates.join("\n - ")})
    end
  end
end

ActionView::Base.default_form_builder = ErbForm::Builder
