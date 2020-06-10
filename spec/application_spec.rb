# frozen_string_literal: true

require_relative '../lib/application'

RSpec.describe Application do

  describe 'self.run' do

    it 'generates and prints sequence based on args' do
      expected_output = <<~OUT
        122333
        112233
        212223
        12113213
        11122113121113
      OUT
      expect {
        Application.run(%w[--start=122333 --length=5])
      }.to output(expected_output).to_stdout
    end

    it 'generates and prints sequence with default options' do
      expected_output = <<~OUT
        1
        11
        21
        1211
        111221
        312211
      OUT
      expect {
        Application.run([])
      }.to output(expected_output).to_stdout
    end

  end

end