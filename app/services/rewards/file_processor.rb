# frozen_string_literal: true

module Rewards
  class FileProcessor
    attr_accessor :file_contents, :calculator

    delegate :errors, :invalid?, to: :file_contents

    def initialize(file_path)
      @file_contents = Validators::FileInput.new(file_path)
    end

    def calculate_rewards
      Rewards::Calculator.new(@file_contents.sorted_rows).process
    end
  end
end
