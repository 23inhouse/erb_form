require "spec_helper"

describe "blogs/double_render_error" do
  before(:each) do
    assign(:blog, stub_model(Blog,
      :name => "My name",
    ).as_new_record)
  end

  describe "when calling field from within an ErbForm template" do
    it "raises a double render error" do
      # lambda { render } .should raise_error(ErbForm::DoubleRenderError, "Called `field' from")
      lambda { render } .should raise_error(ActionView::Template::Error)
    end
  end
end
