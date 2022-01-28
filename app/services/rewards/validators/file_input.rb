# frozen_string_literal: true

module Rewards
  module Validators
    class FileInput
      include ActiveModel::Validations
      attr_accessor :file_path, :file, :rows, :data

      validates :file_path, presence: true

      validate :file_exist?
      validate :content

      def initialize(file_path)
        @file_path = file_path
        @rows = []
      end

      def file_exist?
        errors.add(:file, 'invalid') unless valid_file?
      end

      def valid_file?
        file_path and File.exist?(file_path)
      end

      def content
        if valid_file?
          File.open(file_path).each_with_index do |line, index|
            row = Content.new(line)
            if row.valid?
              rows << row
            else
              errors.add(:data, "invalid. Row #{index + 1} Errors: #{row.errors.full_messages.join(',')}")
            end
          end
          errors.add(:rows, 'no rows present') unless rows
        end
      end

      def sorted_rows
        rows.sort_by!(&:date)
      end
    end
  end
end
