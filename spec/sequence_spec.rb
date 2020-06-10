# frozen_string_literal: true

require_relative '../lib/sequence'

RSpec.describe Sequence do
  let(:sequence) { Sequence.new(start_value) }

  describe '#next_value' do
    let(:start_value) { '1' }

    it 'returns next value of sequence based on current value' do
      expect(sequence.next_value).to eq('11')
      expect(sequence.next_value).to eq('21')
      expect(sequence.next_value).to eq('1211')
      expect(sequence.next_value).to eq('111221')
      expect(sequence.next_value).to eq('312211')
    end

    it 'sets next value to current value' do
      sequence.next_value
      expect(sequence.current_value).to eq('11')
      sequence.next_value
      expect(sequence.current_value).to eq('21')
    end
  end

  describe '#current_value' do
    let(:start_value) { '11133' }

    it 'starts with start value' do
      expect(sequence.current_value).to eq(start_value)
    end
  end

end