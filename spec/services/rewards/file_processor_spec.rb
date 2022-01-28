# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Rewards::FileProcessor do
  describe 'File' do
    it 'should validate the file_path' do
      file_validator = instance_double('Rewards::Validators::FileInput')
      calculator = instance_double('Rewards::Calculator')
      expect(Rewards::Validators::FileInput).to receive(:new).with('file_path').and_return(file_validator)
      expect(file_validator).to receive(:sorted_rows).and_return([1])
      expect(Rewards::Calculator).to receive(:new).with([1]).and_return(calculator)
      expect(calculator).to receive(:process)
      file = described_class.new('file_path')
      file.calculate_rewards
    end
  end
end
