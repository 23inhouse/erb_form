class MyErbFormsController < ApplicationController
  
  before_filter :load_my_erb_form
  
private
  
  def load_my_erb_form
    @my_erb_form = MyErbForm.new
  end
end
