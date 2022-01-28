# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Rewards::Validators::FileInput do
  describe 'File' do
    it 'should validate the file_path' do
      file = described_class.new(nil)
      expect(file.valid?).to be false
      expect(file.errors.full_messages).to eq(["File path can't be blank", 'File invalid'])
    end

    it 'should validate the invalid path' do
      file = described_class.new('spec/files/valid_input.txt')
      expect(file.valid?).to be false
      expect(file.errors.full_messages).to eq(['File invalid'])
    end

    it 'should validate the invalid file' do
      file = described_class.new('spec/fixtures/invalid_input.txt')
      expect(file.valid?).to be false
      expect(file.errors.full_messages).to eq(["Data invalid. Row 1 Errors: To can't be blank"])
    end

    it 'should validate the invalid path' do
      file = described_class.new('spec/fixtures/valid_input.txt')
      expect(file.valid?).to be true
      expect(file.rows.count).to eq(7)
    end
  end
end
