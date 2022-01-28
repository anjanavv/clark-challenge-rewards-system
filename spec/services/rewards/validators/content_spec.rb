# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Rewards::Validators::Content do
  describe 'File content' do
    it 'should be invalid if data is not present' do
      file = described_class.new('')
      expect(file.valid?).to be false
      expect(file.errors.full_messages).to eq(["Data can't be blank", "Date can't be blank", "Action can't be blank",
                                               "From can't be blank"])
    end

    it 'should be invalid if data is invalid' do
      file = described_class.new('Invalid data')
      expect(file.valid?).to be false
      expect(file.errors.full_messages).to eq(["Date can't be blank", "Action can't be blank", "From can't be blank"])
    end

    it 'should be invalid if date is invalid' do
      file = described_class.new('abc efg B recommends C')
      expect(file.valid?).to be false
      expect(file.errors.full_messages).to eq(["Date can't be blank"])
    end

    it 'should be invalid if action is invalid' do
      file = described_class.new('2018-06-16 09:41 B meets C')
      expect(file.valid?).to be false
      expect(file.errors.full_messages).to eq(["Action can't be blank"])
    end

    it 'should be invalid if to is not present' do
      file = described_class.new('2018-06-16 09:41 B recommends')
      expect(file.valid?).to be false
      expect(file.errors.full_messages).to eq(["To can't be blank"])
    end

    it 'should be valid if valid data is passed' do
      file = described_class.new('2018-06-16 09:41 B recommends C')
      expect(file.valid?).to be true
    end
  end
end
