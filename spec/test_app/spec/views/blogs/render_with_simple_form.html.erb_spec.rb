require "spec_helper"

describe "blogs/render_with_simple_form" do
  before(:each) do
    assign(:blog, stub_model(Blog,
      :name => "",
      :errors => {:name => ['must not be blank']}
    ).as_new_record)
  end

  describe "when there are simeple form helpers" do
    it "finds the correct layout file" do
      render
      rendered.should have_selector "div", :class => "simple_form_field"
    end

    it "renders the label" do
      render
      rendered.should have_selector "label", :class => "string required"
      rendered.should have_selector "abbr", :title => "required"
      rendered.should have_selector "label", :content => "My english label"
    end

    it "renders the input" do
      render
      rendered.should have_selector "input", :class => "string required"
      rendered.should have_selector "input", :placeholder => "type your name here (in english)"
    end

    it "renders the hint" do
      render
      rendered.should contain "My hint in english"
    end

    it "renders the error" do
      render
      rendered.should contain "Name must not be blank"
    end
  end
end
