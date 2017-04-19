class CustomerAreaController < ApplicationController
  before_action -> { authorize_customer(params[:customer_id]) }, except: [:index, :show]
end
