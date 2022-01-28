# frozen_string_literal: true

class RewardsController < ApplicationController
  def process_file
    result = Rewards::FileProcessor.new(file_params[:file_details])
    if result.invalid?
      render json: { errors: result.errors }, status: :unprocessable_entity
    else
      render json: result.calculate_rewards, status: :ok
    end
  end

  private

  def file_params
    params.permit(:file_details, :file_type)
  end
end
