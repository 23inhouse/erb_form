require "spec_helper"

describe "blogs/render_field_from_a_partial" do
  before(:each) do
    assign(:blog, stub_model(Blog,
      :name => "",
    ).as_new_record)
  end

  describe "when the as option is passed" do
    it "finds the correct layout file" do
      render
      rendered.should have_selector "div", :class => "field_in_partial"
    end
  end
end
