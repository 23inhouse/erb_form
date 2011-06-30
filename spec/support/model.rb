class Model
  
  attr_accessor :any_method, :specific_method
  
  def self.validators_on(*args)
    [Validator.new]
  end
end

class Validator
  def kind
    :presence
  end
end