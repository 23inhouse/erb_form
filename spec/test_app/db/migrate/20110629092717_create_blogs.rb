class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.string :name
      t.text :post
      t.boolean :published
      t.date :release_date

      t.timestamps
    end
  end

  def self.down
    drop_table :my_erb_form
  end
end
