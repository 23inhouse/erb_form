require "spec_helper"

describe "blogs/render_optional_and_required_form" do
  before(:each) do
    assign(:blog, stub_model(Blog,
      :post => "",
      :published => ""
    ).as_new_record)
  end

  describe "when there are simeple form helpers" do
    it "finds the correct layout file" do
      render
      rendered.should have_selector "div", :class => "optional_field"
      rendered.should have_selector "div", :class => "required_field"
    end

    it "renders the helpers with a required class" do
      render
      rendered.should have_selector "label", :class => "text optional"
      rendered.should have_selector "textarea", :class => "text optional"
    end

    it "renders the helpers with an optional class" do
      render
      rendered.should have_selector "label", :class => "boolean required"
      rendered.should have_selector "input", :class => "boolean required"
    end
  end
end
