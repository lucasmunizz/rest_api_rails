# frozen_string_literal: true

class JsonWebTokenService
  SECRET_KEY = Rails.application.credentials.secret_key_base
  ALGORITHM = ENV.fetch('ALGORITHM', 'HS256')

  def encode(payload)
    return false if payload.nil?

    JWT.encode payload, SECRET_KEY, ALGORITHM
  rescue StandardError
    false
  end

  def decode(token)
    JWT.decode(token, SECRET_KEY, true, { algorithm: ALGORITHM }).first
  rescue StandardError
    false
  end
end
