class AccountsController < ApplicationController
  before_action :authenticate_customer
  before_action -> { authorize_customer(params[:customer_id]) }

  def create
    account = Stripe::Account.create(account_params.to_h.reverse_merge(@customer.default_account_settings))
    @customer.update!(account_id: account.id)
    render :created
  end

  def external
    account = Stripe::Account.retrieve(@customer.account_id)
    external = account.external_accounts.create(external_account: external_params[:token])
    @customer.update!(bank_last_4_digits: external.last4, bank_name: external.bank_name)
    render :created
  end

  private

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
