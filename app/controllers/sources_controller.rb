class SourcesController < CustomerAreaController
  def create
    stripe_customer = Stripe::Customer.retrieve(@customer.stripe_id)
    stripe_customer.sources.create(source: customer_params[:source])
    render status: :created
  end

  def default_source
    stripe_customer = Stripe::Customer.retrieve(@customer.stripe_id)
    stripe_customer.default_source = customer_params[:default_source]
    stripe_customer.save
    render status: :ok
  end

  private

  def customer_params
    params.require(:customer).permit(:firebase_id, :source, :default_source)
  end
end
