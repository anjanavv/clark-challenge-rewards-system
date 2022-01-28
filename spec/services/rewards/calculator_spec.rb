# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rewards::Calculator do
  describe 'Rewards Calculator' do
    it 'should calculate the rewards' do
      data1 = Rewards::Validators::Content.new('2018-06-16 09:41 B recommends C')
      data2 = Rewards::Validators::Content.new('2018-06-16 09:41 C accepts')
      file = described_class.new([data1, data2])
      expect(file.process).to eq({ 'B' => 1 })
    end
  end
end
