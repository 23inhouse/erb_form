require "spec_helper"

describe "my_erb_forms/form_template" do
  before(:each) do
    assign(:my_erb_form, stub_model(MyErbForm,
      :text_field => "MyString",
      :text_area => "MyText",
      :check_box => false,
      :radio_button => false,
      :select => "MyString"
    ).as_new_record)
  end

  describe "when calling form_for" do
    it "renders a text_field" do
      render
      rendered.should have_selector "form.template" do |form|
        form.should have_selector "fieldset div.input_field" do |field|
          field.should have_selector "label", :for => "my_erb_form_text_field", :content => "My custom label"
          field.should have_selector "input#my_erb_form_text_field", :name => "my_erb_form[text_field]"
          field.should have_selector "p.hint", :content => "Hint me text_field."
        end
      end
    end

    it "renders a text_area" do
      render
      rendered.should have_selector "form.template" do |form|
        form.should have_selector "fieldset div.text_area_field" do |field|
          field.should have_selector "label", :for => "my_erb_form_text_area", :content => "Text area"
          field.should have_selector "textarea#my_erb_form_text_area", :name => "my_erb_form[text_area]"
          field.should have_selector "p.hint", :content => "Hint me text_area."
        end
      end
    end

    it "renders a check_box" do
      render
      rendered.should have_selector "form.template" do |form|
        form.should have_selector "fieldset div.check_box_field" do |field|
          field.should have_selector "label", :for => "my_erb_form_check_box", :content => "Check box"
          field.should have_selector "input#my_erb_form_check_box", :name => "my_erb_form[check_box]"
          field.should have_selector "p.hint", :content => "Hint me check_box."
        end
      end
    end

    it "renders a radio_button" do
      render
      rendered.should have_selector "form.template" do |form|
        form.should have_selector "fieldset div.radio_button_field" do |field|
          field.should have_selector "label", :for => "my_erb_form_radio_button", :content => "Radio button"
          field.should have_selector "input#my_erb_form_radio_button_cool", :name => "my_erb_form[radio_button]"
          field.should have_selector "p.hint", :content => "Hint me radio_button."
        end
      end
    end

    it "renders a date_select" do
      render
      rendered.should have_selector "form.template" do |form|
        form.should have_selector "fieldset div.date_select_field" do |field|
          field.should have_selector "label", :for => "my_erb_form_date_select", :content => "Date select"
          field.should have_selector "select#my_erb_form_date_select_1i", :name => "my_erb_form[date_select(1i)]"
          field.should have_selector "p.hint", :content => "Hint me date_select."
        end
      end
    end

    it "renders a select" do
      render
      rendered.should have_selector "form.template" do |form|
        form.should have_selector "fieldset div.select_field" do |field|
          field.should have_selector "label", :for => "my_erb_form_select", :content => "Select"
          field.should have_selector "select#my_erb_form_select", :name => "my_erb_form[select]"
          field.should have_selector "p.hint", :content => "Hint me select."
        end
      end
    end
  end
end
