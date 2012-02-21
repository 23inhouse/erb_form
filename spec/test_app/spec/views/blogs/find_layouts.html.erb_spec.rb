require "spec_helper"

describe "blogs/find_layouts" do
  before(:each) do
    assign(:blog, stub_model(Blog,
      :name => "My name",
    ).as_new_record)
  end

  describe "when calling field with a layout" do
    describe "and a forms/legacy/name_field layout" do
      it "renders the layout" do
        render
        rendered.should have_selector "div", :class => "forms_legacy_name_field"
      end
    end

    describe "and a blogs/legacy/field layout" do
      before { `mv app/views/forms/legacy/name_field.html.erb app/views/forms/legacy/name_field.html.erb.backup` unless `ls app/views/forms/legacy/name_field.html.erb`.blank? }
      after  { `mv app/views/forms/legacy/name_field.html.erb.backup app/views/forms/legacy/name_field.html.erb` unless `ls app/views/forms/legacy/name_field.html.erb.backup`.blank? }

      it "renders the layout" do
        render
        rendered.should have_selector "div", :class => "blogs_legacy_field"
      end
    end

    describe "and a forms/legacy/field layout" do
      before {
        `mv app/views/forms/legacy/name_field.html.erb app/views/forms/legacy/name_field.html.erb.backup` unless `ls app/views/forms/legacy/name_field.html.erb`.blank?
        `mv app/views/blogs/legacy_field.html.erb app/views/blogs/legacy_field.html.erb.backup` unless `ls app/views/blogs/legacy_field.html.erb`.blank?
      }
      after {
        `mv app/views/forms/legacy/name_field.html.erb.backup app/views/forms/legacy/name_field.html.erb` unless `ls app/views/forms/legacy/name_field.html.erb.backup`.blank?
        `mv app/views/blogs/legacy_field.html.erb.backup app/views/blogs/legacy_field.html.erb` unless `ls app/views/blogs/legacy_field.html.erb.backup`.blank?
      }

      it "renders the layout" do
        render
        rendered.should have_selector "div", :class => "forms_legacy_field"
      end
    end

    describe "and a forms/default/legacy/field layout" do
      before {
        `mv app/views/forms/legacy/name_field.html.erb app/views/forms/legacy/name_field.html.erb.backup` unless `ls app/views/forms/legacy/name_field.html.erb`.blank?
        `mv app/views/blogs/legacy_field.html.erb app/views/blogs/legacy_field.html.erb.backup` unless `ls app/views/blogs/legacy_field.html.erb`.blank?
        `mv app/views/forms/legacy/field.html.erb app/views/forms/legacy/field.html.erb.backup` unless `ls app/views/forms/legacy/field.html.erb`.blank?
      }
      after {
        `mv app/views/forms/legacy/name_field.html.erb.backup app/views/forms/legacy/name_field.html.erb` unless `ls app/views/forms/legacy/name_field.html.erb.backup`.blank?
        `mv app/views/blogs/legacy_field.html.erb.backup app/views/blogs/legacy_field.html.erb` unless `ls app/views/blogs/legacy_field.html.erb.backup`.blank?
        `mv app/views/forms/legacy/field.html.erb.backup app/views/forms/legacy/field.html.erb` unless `ls app/views/forms/legacy/field.html.erb.backup`.blank?
      }

      it "renders the layout" do
        render
        rendered.should have_selector "div", :class => "forms_default_legacy_field"
      end
    end

    describe "and a fors/default/field layout" do
      before {
        `mv app/views/forms/legacy/name_field.html.erb app/views/forms/legacy/name_field.html.erb.backup` unless `ls app/views/forms/legacy/name_field.html.erb`.blank?
        `mv app/views/blogs/legacy_field.html.erb app/views/blogs/legacy_field.html.erb.backup` unless `ls app/views/blogs/legacy_field.html.erb`.blank?
        `mv app/views/forms/legacy/field.html.erb app/views/forms/legacy/field.html.erb.backup` unless `ls app/views/forms/legacy/field.html.erb`.blank?
        `mv app/views/forms/default/legacy_field.html.erb app/views/forms/default/legacy_field.html.erb.backup` unless `ls app/views/forms/default/legacy_field.html.erb`.blank?
      }
      after {
        `mv app/views/forms/legacy/name_field.html.erb.backup app/views/forms/legacy/name_field.html.erb` unless `ls app/views/forms/legacy/name_field.html.erb.backup`.blank?
        `mv app/views/blogs/legacy_field.html.erb.backup app/views/blogs/legacy_field.html.erb` unless `ls app/views/blogs/legacy_field.html.erb.backup`.blank?
        `mv app/views/forms/legacy/field.html.erb.backup app/views/forms/legacy/field.html.erb` unless `ls app/views/forms/legacy/field.html.erb.backup`.blank?
        `mv app/views/forms/default/legacy_field.html.erb.backup app/views/forms/default/legacy_field.html.erb` unless `ls app/views/forms/default/legacy_field.html.erb.backup`.blank?
      }

      it "renders the layout" do
        render
        rendered.should have_selector "div", :class => "forms_default_field"
      end
    end
  end
end
