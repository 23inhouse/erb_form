require "spec_helper"

describe "blogs/render_multiple_layouts" do
  before(:each) do
    assign(:blog, stub_model(Blog,
      :name => "My name",
    ).as_new_record)
  end

  describe "when there is more than one type of field" do
    it "renders the first field" do
      render
      rendered.should have_selector "div", :class => "blogs_name_field"
    end

    it "renders the second field" do
      render
      rendered.should have_selector "div", :class => "forms_legacy_name_field"
    end
  end
end
