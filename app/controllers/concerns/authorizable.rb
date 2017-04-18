module Authorizable
  extend ActiveSupport::Concern

  private

  def authenticate_customer
    token = token_from_headers
    decode_key = OpenSSL::X509::Certificate.new(Rails.application.secrets.token_cert).public_key
    decoded_token = JWT.decode(token, OpenSSL::PKey::RSA.new, false, verify_options)
    @customer = Customer.from_jwt_token(decoded_token.first)
    if @customer.nil?
      head(:unauthorized)
    end
  end

  def authorize_customer(id)
    render json: { error: "Action forbidden" }, status: :forbidden unless @customer.id.to_s == id.to_s
  end

  def token_from_headers
    unless request.headers["Authorization"].nil?
      request.headers["Authorization"].split.last
    end
  end

  def verify_options
    {
      algorithm: 'RSA256',
      aud: token_audience,
      verify_aud: true,
      verify_expiration: false
    }
  end

  def token_audience
    Rails.application.secrets.token_audience
  end
end
