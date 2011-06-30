require "spec_helper"

describe "my_erb_forms/form_custom_field" do
  before(:each) do
    assign(:my_erb_form, stub_model(MyErbForm,
      :text_field => "MyString",
      :text_area => "MyText",
      :check_box => false,
      :radio_button => false,
      :select => "MyString"
    ).as_new_record)
  end

  describe "when calling form_for with a custom_field" do
    it "renders a custom_field from the same folder as the form" do
      render
      rendered.should have_selector "form.custom_field" do |form|
        form.should have_selector "fieldset div.custom_text_field" do |field|
          field.should have_selector "input#my_erb_form_text_field", :name => "my_erb_form[text_field]"
        end
      end
    end
    
    it "renders an other_custom_field from the forms folder" do
      render
      rendered.should have_selector "form.custom_field" do |form|
        form.should have_selector "fieldset div.custom_text_field" do |field|
          field.should have_selector "input#my_erb_form_text_field", :name => "my_erb_form[text_field]"
        end
      end
    end
    
    it "renders an other_custom_field from the forms folder" do
      render
      rendered.should have_selector "form.custom_field" do |form|
        form.should have_selector "fieldset div.other_custom_field" do |field|
          field.should have_selector "input#my_erb_form_text_field", :name => "my_erb_form[text_field]"
        end
      end
    end
  end
end
