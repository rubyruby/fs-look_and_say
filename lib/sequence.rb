class Sequence

  attr_reader :current_value

  def initialize(start_value)
    @current_value = start_value
  end

  def next_value
    @current_value = @current_value.scan(/((\d)\2*)\1*/).reduce([]) do |new_value, (same_digits, digit)|
      new_value + [same_digits.length, digit]
    end.join
  end

end