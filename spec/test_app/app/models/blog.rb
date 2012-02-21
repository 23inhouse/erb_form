class Blog < ActiveRecord::Base
  validates :name, :presence => true
end
