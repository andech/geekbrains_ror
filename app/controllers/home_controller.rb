class HomeController < ApplicationController
  def index
    Rails.logger.info '############################'
    Rails.logger.info params.inspect
    Rails.logger.info '############################'
  end

  def poetry
  end
end
