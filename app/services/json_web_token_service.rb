class JsonWebTokenService
    #definir a secret key e algoritmos
    SECRET_KEY = Rails.application.credentials.secret_key_base
    ALGORITHM = ENV.fetch("ALGORITHM") { "HS256" }

    #criar metodo para encode e decode

    def encode(payload)
        JWT.encode payload, SECRET_KEY, ALGORITHM
    end

    def decode(token)
        JWT.decode(token, SECRET_KEY, true, { algorithm: ALGORITHM }).first
    end
end