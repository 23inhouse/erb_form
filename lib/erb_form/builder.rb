module ErbForm
  class Builder < ::SimpleForm::FormBuilder
    def field(attribute_name, options = {})
      raise ErbForm::DoubleRenderError.new(clean_backtrace(caller)), nil, clean_backtrace(caller) if recursing?
      @prevent_recursion = true
      @field_layout = options.delete(:layout)
      return render_field(field_template_path(attribute_name), attribute_name, options)
    rescue ActionView::MissingTemplate => e
      raise ErbForm::MissingTemplate.new(field_layouts(attribute_name)), nil, clean_backtrace(e.backtrace)
    end

  private

    def recursing?
      !!@prevent_recursion
    end

    def field_layouts(attribute_name)
      file = @field_layout.nil? ? attribute_name.to_s : @field_layout
      [
        [ErbForm.forms_path, @field_layout, attribute_name.to_s+'_field'],  # forms/custom_layout/attribute_name_field.html.erb
        [template.controller_path, file+'_field'],                          # resourse_path/attribute_name_field.html.erb
        [ErbForm.forms_path, @field_layout, 'field'],                       # forms/custom_layout/field.html.erb
        [ErbForm.forms_path, 'default', file+'_field'],                     # forms/attribute_name_field.html.erb
        [ErbForm.forms_path, 'default', 'field']                            # forms/attribute_name/field.html.erb
      ].delete_if { |template_array|
        template_array.include? nil
      }.map { |template_array|
        template_array.join('/')
      }
    end

    def render_field(field_template_path, attribute_name, options)
      output = template.render(:file => '/' + (field_template_path || 'a_non_existant_file_to_force_a_missing_template_error'), :locals => {
        :form => self,
        :attribute_name => attribute_name,
        :options => options
      })
      @prevent_recursion = false
      output
    end

    def field_template_path(attribute_name)
      @field_template_path ||= field_layouts(attribute_name).detect { |template_file|
        template.view_paths.exists?(template_file, '', false, {
          :locale => [template.locale],
          :formats => template.formats,
          :handlers => [:erb, :rjs, :builder, :rhtml, :rxml]
        })
      }
    end

    def clean_backtrace(backtrace)
      unless backtrace[0].scan(__FILE__).size > 0
        backtrace = backtrace.collect { |line| line.scan(__FILE__).size > 0 ? nil : line }.compact!
      end
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
