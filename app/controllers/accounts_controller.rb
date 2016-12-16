class AccountsController < ApplicationController
  before_action :load_customer

  def create
    begin
      account = Stripe::Account.create(account_params.to_h.reverse_merge(@customer.default_account_settings))
      @customer.update!(account_id: account.id)
      render :created
    rescue Stripe::StripeError => e
      render json: e.message, status: :bad_request
    end
  end

  def external
    begin
      account = Stripe::Account.retrieve(@customer.account_id)
      account.external_accounts.create(external_account: external_params[:token])
      render :created
    rescue Stripe::StripeError => e
      render json: e.message, status: :bad_request
    end
  end

  private

  def load_customer
    @customer = Customer.find_by(params[:id])
  end

  def external_params
    params.require(:external).permit(:token)
  end

  def account_params
    params.require(:account).permit(
      legal_entity:
        [:first_name, :last_name, :type, :personal_id_number,
         address: [:city, :line1, :postal_code, :state],
         dob: [:day, :month, :year]
        ],
      tos_acceptance: [:date, :ip]
    )
  end
end
