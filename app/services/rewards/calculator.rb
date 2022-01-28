# frozen_string_literal: true

module Rewards
  class Calculator
    attr_accessor :records, :graph

    def initialize(records)
      @records = records
      @graph = Graph.new
    end

    def process
      records.each do |record|
        process_record(record)
      end
      graph.result
    end

    def process_record(record)
      if record.recommends?
        graph.add_node(record)
      else
        graph.update_node(record)
      end
    end
  end
end
