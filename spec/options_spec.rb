# frozen_string_literal: true

require_relative '../lib/options'

RSpec.describe Options do

  HELP = <<~HELP
    Usage: bin/look_and_say [options]
        -s, --start=VALUE                Specify start value. Default: "1"
        -l, --length=LENGTH              Specify length of sequence. Default: 5
        -h, --help                       Prints this help
  HELP

  describe 'self.parse' do

    around(:each) do |example|
      example.run
    rescue SystemExit
      # prevent from rspec stopping on exit/abort methods in code
    end

    shared_examples 'print help' do
      it 'prints help to stdout' do
        expect { Options.parse(args) }.to output(HELP).to_stdout
      end
    end

    let(:args) { %W[--start=#{start_value} --length=#{sequence_length}] }

    context 'when args valid' do
      let(:start_value) { '11222' }
      let(:sequence_length) { 3 }

      it do
        options = Options.parse(args)
        expect(options).to be_a(Options)
      end

      it 'parses args as options' do
        options = Options.parse(args)
        expect(options.start_value).to eq(start_value)
        expect(options.sequence_length).to eq(sequence_length)
      end
    end

    context 'when "start" arg invalid' do
      let(:start_value) { 'not-a-digits' }
      let(:sequence_length) { 3 }

      it 'aborts application' do
        expect { Options.parse(args) }.to raise_error(SystemExit)
      end

      include_examples 'print help'
    end

    context 'when "length" arg invalid' do
      let(:start_value) { '2233111' }
      let(:sequence_length) { 'not-a-positive-int' }

      it 'aborts application' do
        expect { Options.parse(args) }.to raise_error(SystemExit)
      end

      include_examples 'print help'
    end

    context 'when args contains "help" arg' do
      let(:args) { ['--help'] }

      it 'exist application' do
        expect { Options.parse(args) }.to raise_error(SystemExit)
      end

      include_examples 'print help'
    end

    context 'when args contains non-defined arg' do
      let(:args) { ['--not-a-argument=foobar'] }

      it 'aborts application' do
        expect { Options.parse(args) }.to raise_error(SystemExit)
      end

      include_examples 'print help'
    end

    context 'when args empty' do
      let(:args) { [] }

      it 'returns options with default values' do
        options = Options.parse(args)
        expect(options.start_value).to eq(Options::DEFAULT_START_VALUE)
        expect(options.sequence_length).to eq(Options::DEFAULT_SEQUENCE_LENGTH)
      end
    end

  end

  describe '#define_options' do
    let(:options) { Options.new }
    let(:parser) { OptionParser.new }

    it 'defines options with OptionParser' do
      options.define_options(parser)
      expect(parser.help).to eq(HELP)
    end
  end

end
