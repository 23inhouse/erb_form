require "spec_helper"

describe "blogs/render_input_as_different_type" do
  before(:each) do
    assign(:blog, stub_model(Blog,
      :name => "",
    ).as_new_record)
  end

  describe "when the as option is passed" do
    it "finds the correct layout file" do
      render
      rendered.should have_selector "div", :class => "blogs_name_field"
    end

    it "renders the input as that type" do
      render
      rendered.should have_selector "input", :type => 'checkbox'
      rendered.should have_selector "input", :class => 'boolean required'
    end

    it "renders the label as that type" do
      render
      rendered.should have_selector "label", :class => 'boolean required'
    end
  end
end
