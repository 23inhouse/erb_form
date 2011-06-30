class CreateMyErbForms < ActiveRecord::Migration
  def self.up
    create_table :my_erb_forms do |t|
      t.string :text_field
      t.text :text_area
      t.boolean :check_box
      t.boolean :radio_button
      t.date :date_select
      t.string :select

      t.timestamps
    end
  end

  def self.down
    drop_table :my_erb_forms
  end
end
