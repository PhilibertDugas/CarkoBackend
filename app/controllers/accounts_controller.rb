class AccountsController < ApplicationController
  def create
    begin
      @customer = Customer.find_by(params[:id])
      account = Stripe::Account.create(account_params.to_h.reverse_merge(@customer.default_account_settings))
      @customer.update!(account_id: account.id)
    rescue Stripe::StripeError => e
      render json: e.message, status: :bad_request
    end
  end

  private

  def account_params
    params.require(:account).permit(legal_entity: [:first_name, :last_name, :type, :personal_id_number, address: [:city, :line1, :postal_code, :state], dob: [:day, :month, :year]], tos_acceptance: [:date, :ip])
  end
end
