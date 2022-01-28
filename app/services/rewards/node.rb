# frozen_string_literal: true

module Rewards
  class Node
    attr_accessor :name, :points, :parent, :accepted

    def initialize(name, parent)
      @name = name
      @points = 0
      @parent = parent
      @accepted = false
    end

    def mark_accepted
      self.accepted = true
    end
  end
end
