require "spec_helper"

describe "blogs/missing_layout_template_error" do
  before(:each) do
    assign(:blog, stub_model(Blog,
      :name => "My name",
    ).as_new_record)
  end

  describe "when calling field with a missing layout" do
    before do
      `mv app/views/blogs/name_field.html.erb app/views/blogs/name_field.html.erb.backup` unless `ls app/views/blogs/name_field.html.erb`.blank?
      `mv app/views/forms/default/name_field.html.erb app/views/forms/default/name_field.html.erb.backup` unless `ls app/views/forms/default/name_field.html.erb`.blank?
      `mv app/views/forms/default/field.html.erb app/views/forms/default/field.html.erb.backup` unless `ls app/views/forms/default/field.html.erb`.blank?
    end

    after do
      `mv app/views/blogs/name_field.html.erb.backup app/views/blogs/name_field.html.erb` unless `ls app/views/blogs/name_field.html.erb.backup`.blank?
      `mv app/views/forms/default/name_field.html.erb.backup app/views/forms/default/name_field.html.erb` unless `ls app/views/forms/default/name_field.html.erb.backup`.blank?
      `mv app/views/forms/default/field.html.erb.backup app/views/forms/default/field.html.erb` unless `ls app/views/forms/default/field.html.erb.backup`.blank?
    end

    it "raises a missing template error" do
      # lambda { render } .should raise_error(ErbForm::MissingTemplate)
      lambda { render } .should raise_error(ActionView::Template::Error)
    end
  end
end
