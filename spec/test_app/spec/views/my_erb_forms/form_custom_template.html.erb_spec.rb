require "spec_helper"

describe "my_erb_forms/form_custom_template" do
  before(:each) do
    assign(:my_erb_form, stub_model(MyErbForm,
      :text_field => "MyString",
      :text_area => "MyText",
      :check_box => false,
      :radio_button => false,
      :select => "MyString"
    ).as_new_record)
  end

  describe "when calling form_for with template => custom" do
    it "renders a text_field from the forms/custom folder" do
      render
      rendered.should have_selector "form.custom_template" do |form|
        form.should have_selector "fieldset div.custom_field" do |field|
          field.should have_selector "label", :for => "my_erb_form_any_method", :content => "Any method"
          field.should have_selector "input#my_erb_form_text_field", :name => "my_erb_form[text_field]"
          field.should have_selector "textarea#my_erb_form_text_area", :name => "my_erb_form[text_area]"
          field.should_not have_selector "p.hint"
        end
      end
    end
    
    it "renders an other_text_field from the forms/other_custom folder" do
      render
      rendered.should have_selector "form.custom_template" do |form|
        form.should have_selector "fieldset div.other_text_field" do |field|
          field.should_not have_selector "label"
          field.should have_selector "input#my_erb_form_text_field", :name => "my_erb_form[text_field]"
          field.should have_selector "p.hint", :content => "Hint me other_text_field."
        end
      end
    end
    
    it "renders an other_custom_field from the forms/other_custom folder" do
      render
      rendered.should have_selector "form.custom_template" do |form|
        form.should have_selector "fieldset div.other_custom_field" do |field|
          field.should_not have_selector "label"
          field.should have_selector "input#my_erb_form_text_field", :name => "my_erb_form[text_field]"
          field.should have_selector "textarea#my_erb_form_text_area", :name => "my_erb_form[text_area]"
          field.should have_selector "p.hint", :content => "Hint me other_custom_field."
        end
      end
    end
  end
end
