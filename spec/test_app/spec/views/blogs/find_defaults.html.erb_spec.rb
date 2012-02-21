require "spec_helper"

describe "blogs/find_defaults" do
  before(:each) do
    assign(:blog, stub_model(Blog,
      :name => "My name",
    ).as_new_record)
  end

  describe "when calling field" do
    describe "with a blogs/name/field layout" do
      it "renders the layout" do
        render
        rendered.should have_selector "div", :class => "blogs_name_field"
      end
    end

    describe "with a forms/default/name_field layout" do
      before { `mv app/views/blogs/name_field.html.erb app/views/blogs/name_field.html.erb.backup` unless `ls app/views/blogs/name_field.html.erb`.blank? }
      after { `mv app/views/blogs/name_field.html.erb.backup app/views/blogs/name_field.html.erb` unless `ls app/views/blogs/name_field.html.erb.backup`.blank? }

      it "renders the layout" do
        render
        rendered.should have_selector "div", :class => "forms_default_name_field"
      end
    end

    describe "with a forms/default/field layout" do
      before {
        `mv app/views/blogs/name_field.html.erb app/views/blogs/name_field.html.erb.backup` unless `ls app/views/blogs/name_field.html.erb`.blank?
        `mv app/views/forms/default/name_field.html.erb app/views/forms/default/name_field.html.erb.backup` unless `ls app/views/forms/default/name_field.html.erb`.blank?
      }
      after {
        `mv app/views/blogs/name_field.html.erb.backup app/views/blogs/name_field.html.erb` unless `ls app/views/blogs/name_field.html.erb.backup`.blank?
        `mv app/views/forms/default/name_field.html.erb.backup app/views/forms/default/name_field.html.erb` unless `ls app/views/forms/default/name_field.html.erb.backup`.blank?
      }

      it "renders the layout" do
        render
        rendered.should have_selector "div", :class => "forms_default_field"
      end
    end
  end
end
