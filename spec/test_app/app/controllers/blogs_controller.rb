class BlogsController < ApplicationController
  
  before_filter :load_blog
  
private
  
  def load_blog
    @blog = Blog.new
    @blog.valid?
  end
end
