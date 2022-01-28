# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rewards::Graph do
  describe 'Rewards Graph structure' do
    it 'should calculate the rewards' do
      data1 = Rewards::Validators::Content.new('2018-06-16 09:41 B recommends C')
      data2 = Rewards::Validators::Content.new('2018-06-16 09:41 C accepts')
      graph = described_class.new
      graph.add_node(data1)
      expect(graph.nodes["B"].points).to eq(0)
      expect(graph.nodes["C"].points).to eq(0)
      graph.update_node(data2)
      expect(graph.nodes["B"].points).to eq(1)
      expect(graph.nodes["C"].points).to eq(0)
    end

    it 'should update the points only for the first request' do
      data1 = Rewards::Validators::Content.new('2018-06-16 09:41 B recommends C')
      data2 = Rewards::Validators::Content.new('2018-06-16 09:41 A recommends C')
      data3 = Rewards::Validators::Content.new('2018-06-16 09:41 C accepts')
      graph = described_class.new
      graph.add_node(data1)
      graph.add_node(data2)
      expect(graph.nodes["A"].points).to eq(0)
      expect(graph.nodes["B"].points).to eq(0)
      graph.update_node(data3)
      expect(graph.nodes["B"].points).to eq(1)
      expect(graph.nodes["A"].points).to eq(0)
    end

    it 'should not change the parent' do
      data1 = Rewards::Validators::Content.new('2018-06-16 09:41 B recommends C')
      data3 = Rewards::Validators::Content.new('2018-06-16 09:41 C accepts')
      data2 = Rewards::Validators::Content.new('2018-06-16 09:41 A recommends C')
      graph = described_class.new
      graph.add_node(data1)
      graph.add_node(data2)
      expect(graph.nodes["A"].points).to eq(0)
      expect(graph.nodes["B"].points).to eq(0)
      graph.update_node(data3)
      expect(graph.nodes["B"].points).to eq(1)
      expect(graph.nodes["A"].points).to eq(0)
      expect(graph.nodes["C"].parent.name).to eq("B")
    end

    it 'should not update the point for multiple acceptance' do
      data1 = Rewards::Validators::Content.new('2018-06-16 09:41 B recommends C')
      data3 = Rewards::Validators::Content.new('2018-06-16 09:41 C accepts')
      data2 = Rewards::Validators::Content.new('2018-06-16 09:41 C accepts')
      graph = described_class.new
      graph.add_node(data1)
      graph.add_node(data2)
      expect(graph.nodes["B"].points).to eq(0)
      graph.update_node(data3)
      expect(graph.nodes["B"].points).to eq(1)
      expect(graph.nodes["C"].points).to eq(0)
    end

    it 'should update the points only if it more than min value' do
      graph = described_class.new
      graph.add_node(Rewards::Validators::Content.new('2018-06-16 09:41 A recommends B'))
      graph.update_node(Rewards::Validators::Content.new('2018-06-16 09:41 B accepts'))
      graph.add_node(Rewards::Validators::Content.new('2018-06-16 09:41 B recommends C'))
      graph.update_node(Rewards::Validators::Content.new('2018-06-16 09:41 C accepts'))
      graph.add_node(Rewards::Validators::Content.new('2018-06-16 09:41 C recommends D'))
      graph.update_node(Rewards::Validators::Content.new('2018-06-16 09:41 D accepts'))
      graph.add_node(Rewards::Validators::Content.new('2018-06-16 09:41 D recommends E'))
      graph.update_node(Rewards::Validators::Content.new('2018-06-16 09:41 E accepts'))
      expect(graph.nodes["A"].points).to eq(1.75)
      expect(graph.nodes["B"].points).to eq(1.75)
      expect(graph.nodes["C"].points).to eq(1.5)
      expect(graph.nodes["D"].points).to eq(1)
      expect(graph.nodes["E"].points).to eq(0)
    end
  end
end
