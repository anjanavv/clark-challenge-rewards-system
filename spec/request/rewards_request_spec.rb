# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RewardsController', type: :request do
  describe '#POST' do
    it 'returns errors when file is not present' do
      post '/rewards/process_file'
      expect(response.status).to eq 422
      expect(response.body).to eq "{\"errors\":{\"file_path\":[\"can't be blank\"],\"file\":[\"invalid\"]}}"
    end

    it 'returns errors for invalid data' do
      post '/rewards/process_file', params: { file_details: 'spec/fixtures/invalid_input.txt', file_type: 'txt' },
                                    headers: {}

      expect(response.status).to eq 422
      expect(response.body).to eq "{\"errors\":{\"data\":[\"invalid. Row 1 Errors: To can't be blank\"]}}"
    end

    it 'returns result for valid data' do
      post '/rewards/process_file', params: { file_details: 'spec/fixtures/valid_input.txt', file_type: 'txt' },
                                    headers: {}

      expect(response.status).to eq 200
      expect(response.body).to eq '{"A":1.75,"B":1.5,"C":1}'
    end
  end
end
