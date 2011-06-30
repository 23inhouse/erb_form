require "spec_helper"

describe "my_erb_forms/form_other_custom_template" do
  before(:each) do
    assign(:my_erb_form, stub_model(MyErbForm,
      :text_field => "MyString",
      :text_area => "MyText",
      :check_box => false,
      :radio_button => false,
      :select => "MyString"
    ).as_new_record)
  end

  describe "when calling form_for with template => other_custom" do
    it "renders the default fields when using template => ('' or nil or template => ('' or nil))" do
      render
      rendered.should have_selector "form.other_custom_template" do |form|
        form.should have_selector("fieldset div") { |f| f.size.should == 8 }
        form.should have_selector("fieldset div.input_field") { |f| f.size.should == 4 }
        form.should have_selector("fieldset div.custom_field") { |f| f.size.should == 4 }
      end
    end
  end
end
