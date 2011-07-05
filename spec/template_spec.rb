require 'spec_helper'
require 'erb_form/template'

describe "ErbForm::Template" do
  
  before :each do
    @object = Model.new
    @template = ErbForm::Template.new(:my_model, :name, :text_field, 'my_erb_forms/form', {:object => @object})
  end
  
  describe "new" do
    it "sets all class attributes" do
      @template.options = {:template => {:hint => 'hint'}}
      
      @template.object_name.should == :my_model
      @template.method.should == :name
      @template.options.should == {:template => {:hint => 'hint'}}
      @template.helper_method_name.should == :text_field
    end
  end
    
  describe "locals" do
    describe "hash" do
      it "returns an hash with specific keys" do
        @template.locals.keys.should == [
          :form,
          :helper_method_name,
          :method,
          :object,
          :object_name,
          :options,
          :template
        ]
      end
    end
    
    describe "hint" do
      it "returns the hint" do
        @template.options = {:object => @object, :template => {:hint => 'hint'}}
        @template.template = @template.options[:template]
        @template.locals[:template][:hint].should == 'hint'
      end
    
      it "returns an empty hint when the template is an empty hash" do
        @template.options = {:object => @object, :template => {}}
        @template.template = @template.options[:template]
        @template.locals[:template][:hint].should == ''
      end
    
      it "returns an empty hint when the template is nil" do
        @template.options = {:object => @object}
        @template.template = @template.options[:template]
        @template.locals[:template][:hint].should == ''
      end
    
      it "returns false for the hint" do
        @template.options = {:object => @object, :template => {:hint => false}}
        @template.template = @template.options[:template]
        @template.locals[:template][:hint].should == false
      end
    end
    
    describe "label" do
      it "returns the humanized method" do
        @template.method = :first_name
        @template.locals[:template][:label].should == 'First name'
      end
    
      it "returns the label passed in" do
        @template.method = :first_name
        @template.options = {:object => @object, :template => {:label => 'Custom label'}}
        @template.template = @template.options[:template]
        @template.locals[:template][:label].should == 'Custom label'
      end
    end
    
    describe "required" do
      it "returns the default * when true is passed" do
        @template.options = {:object => @object, :template => {:required => true}}
        @template.template = @template.options[:template]
        @template.locals[:template][:required].should == '*'
      end
    
      it "returns the default * when the object validates the presence of" do
        @template.options = {:object => @object}
        @template.locals[:template][:required].should == '*'
      end
    end
  end
  
  describe "file" do
    it "returns the default input field" do
      @template.file.should == 'forms/default/input_field_fields'
    end
    
    it "returns the specific method field" do
      @template.method = :specific_method
      @template.file.should == 'my_erb_forms/specific_method_field'
    end
    
    it "returns the default text area field" do
      @template.method = :any_method
      @template.helper_method_name = :text_area
      @template.file.should == 'forms/default/text_area_fields'
    end
    
    it "returns the custom text field" do
      @template.options = {:object => @object, :template => {:template => 'custom'}}
      @template.template = @template.options[:template]
      @template.file.should == 'forms/custom/text_field_fields'
    end
    
    it "returns the default input field" do
      @template.helper_method_name = :custom_method
      @template.options = {:object => @object, :template => {:template => 'custom'}}
      @template.template = @template.options[:template]
      @template.file.should == 'forms/default/input_field_fields'
    end
    
    it "returns the other custom custom field" do
      @template.helper_method_name = :custom_field
      @template.options = {:object => @object, :template => {:template => 'other_custom'}}
      @template.template = @template.options[:template]
      @template.file.should == 'forms/other_custom/custom_field_fields'
    end
    
    it "returns the other custom text field" do
      @template.method = :text_field
      @template.options = {:object => @object, :template => {:template => 'other_custom'}}
      @template.template = @template.options[:template]
      @template.file.should == 'forms/other_custom/text_field_fields'
    end
    
    it "returns the default input field" do
      @template.helper_method_name = :any_field
      @template.method = :any_method
      @template.options = {:object => @object, :template => {:template => 'other_custom'}}
      @template.template = @template.options[:template]
      @template.file.should == 'forms/default/input_field_fields'
    end
  end
end
