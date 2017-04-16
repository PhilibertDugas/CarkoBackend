Knock.setup do |config|

  ## Expiration claim
  ## ----------------
  ##
  ## How long before a token is expired. If nil is provided, token will
  ## last forever.
  ##
  config.token_lifetime = nil

  ## Audience claim
  ## --------------
  ##
  ## Configure the audience claim to identify the recipients that the token
  ## is intended for.
  ##
  config.token_audience = -> { Rails.application.secrets.token_audience }

  ## Signature algorithm
  ## -------------------
  ##
  ## Configure the algorithm used to encode the token
  ##
  config.token_signature_algorithm = 'RS256'

  ## Signature key
  ## -------------
  ##
  ## Configure the key used to sign tokens.
  ##
  ## Default:
  config.token_secret_signature_key = -> { Rails.application.secrets.token_secret_key }

  ## Public key
  ## ----------
  ##
  ## Configure the public key used to decode tokens, if required.
  ##
  config.token_public_key = -> { Rails.application.secrets.token_public_key }

  ## Exception Class
  ## ---------------
  ##
  ## Configure the exception to be used when user cannot be found.
  ##
  config.not_found_exception_class_name = 'ActiveRecord::RecordNotFound'
end
