# frozen_string_literal: true

require_relative './sequence'
require_relative './options'

class Application

  def self.run(args)
    options = Options.parse(args)
    sequence = Sequence.new(options.start_value)
    puts options.start_value
    (options.sequence_length - 1).times.each { puts sequence.next_value }
  end

end