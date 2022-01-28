# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rewards::Node do
  describe 'Rewards Node' do
    it 'should initialize the node' do
      parent = described_class.new('A', nil)
      child = described_class.new('B', parent)
      expect(parent.name).to eq('A')
      expect(parent.points).to eq(0)
      expect(parent.parent).to eq(nil)
      expect(child.name).to eq('B')
      expect(child.points).to eq(0)
      expect(child.parent).to eq(parent)
    end
  end
end
