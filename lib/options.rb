# frozen_string_literal: true

require 'optparse'

class Options

  DEFAULT_START_VALUE = '1'
  DEFAULT_SEQUENCE_LENGTH = 6

  attr_accessor :start_value, :sequence_length

  def self.parse(args)
    options = Options.new
    OptionParser.new { |parser| options.define_options(parser) }.parse!(args)
    options
  rescue OptionParser::ParseError => e
    abort(e.message)
  end

  def initialize
    @start_value = DEFAULT_START_VALUE
    @sequence_length = DEFAULT_SEQUENCE_LENGTH
  end

  def define_options(parser)
    parser.banner = 'Usage: bin/look_and_say [options]'
    start_value_option(parser)
    sequence_length_option(parser)
    parser.on_tail('-h', '--help', 'Prints this help') do
      puts parser
      exit
    end
  end

  private

  def start_value_option(parser)
    parser.on('-s', '--start=VALUE', /\d+/, 'Specify start value. Default: "1"') do |value|
      self.start_value = value
    end
  end

  def sequence_length_option(parser)
    parser.on('-l', '--length=LENGTH', /\d+/, 'Specify length of sequence. Default: 5') do |value|
      self.sequence_length = value.to_i
    end
  end

end
