class Merchant::BaseController < ApplicationController
  before_action :require_employee

  def require_employee
    render file: '/public/404' unless current_employee?
  end
end
