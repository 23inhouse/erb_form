require "spec_helper"

describe "my_erb_forms/form_string_template" do
  before(:each) do
    assign(:my_erb_form, stub_model(MyErbForm,
      :text_field => "MyString",
      :text_area => "MyText",
      :check_box => false,
      :radio_button => false,
      :select => "MyString"
    ).as_new_record)
  end

  describe "when calling form_for with template => 'custom'" do
    it "renders a text_field from the forms/custom folder" do
      render
      rendered.should have_selector "form.string_template" do |form|
        form.should have_selector "fieldset div.custom_text_field" do |field|
          field.should have_selector "label", :for => "my_erb_form_text_field", :content => "Text field"
          field.should have_selector "input#my_erb_form_text_field", :name => "my_erb_form[text_field]"
          field.should_not have_selector "p.hint"
        end
      end
    end
  end
end
