require "spec_helper"

describe "blogs/render_field_with_extra_options" do
  before(:each) do
    assign(:blog, stub_model(Blog,
      :name => "",
    ).as_new_record)
  end

  describe "when there are extra options" do
    it "finds the correct layout file" do
      render
      rendered.should have_selector "div", :class => "extra_options_field"
    end

    it "passes them thru as locals" do
      render
      rendered.should contain "My extra options as locals"
    end
  end
end
