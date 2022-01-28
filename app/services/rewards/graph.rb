# frozen_string_literal: true

module Rewards
  class Graph
    attr_accessor :structure, :nodes

    DIVISOR = 2.0
    MIN_POINT = 0.25
    MAX_POINT = 1

    def initialize
      @nodes = {}
    end

    def add_node(record)
      parent = nodes[record.from] || create_node(record.from, nil)
      nodes[record.to] || create_node(record.to, parent)
    end

    def create_node(name, parent)
      node = Rewards::Node.new(name, parent)
      nodes[name] = node
    end

    def update_node(record)
      child = nodes[record.from]
      unless child.accepted
        update_points(child.parent, MAX_POINT) if child
        child.mark_accepted
      end
    end

    def update_points(node, point)
      return if point < MIN_POINT
      return unless node

      node.points += point
      update_points(node.parent, point / DIVISOR)
    end

    def result
      nodes.transform_values(&:points).reject { |_k, v| v.zero? }
    end
  end
end
