# frozen_string_literal: true

module Rewards
  module Validators
    class Content
      include ActiveModel::Validations
      attr_accessor :data, :date, :action, :from, :to

      validates :data, :date, :action, :from, presence: true
      validates :to, presence: true, if: :recommends_action?

      ACTIONS = { recommends: :recommends, accepts: :accepts }.freeze

      def initialize(data)
        @data = data
        @date = fetch_date
        @action = fetch_action
        @from = fetch_from
        @to = fetch_to
      end

      def fetch_date
        self.date = Time.zone.parse("#{values[0]} #{values[1]}")
      end

      def fetch_action
        ACTIONS[values[3]&.to_sym]
      end

      def fetch_from
        self.from = values[2]
      end

      def fetch_to
        self.to = values[4]
      end

      def values
        data.split(' ')
      end

      def recommends_action?
        action == :recommends
      end

      def recommends?
        action == :recommends
      end
    end
  end
end
