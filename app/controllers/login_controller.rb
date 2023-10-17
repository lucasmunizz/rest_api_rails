class LoginController < ApplicationController
    #criar o metodo create

    #criar o get

    #criar o metodo validar o token

    #criar o metodo user para achar o user

    #validar a senha

    TIME_EXPIRE = ENV.fetch("TIME_EXPIRE") { 10 }.freeze


    def create
      @email = params['email']
      @password = params['password']
      if password_valid?
        render json: access_token, status: :ok
      else
        head :unauthorized
      end
    end


    private

    def user
      user ||= User.find_by(email: email)
    rescue
      false
    end

    def password_valid?
      return nil if user.nil?

      encrypted_password = BCrypt::Password.new(user.encrypted_password)

      encrypted_password == password
    end

    def object_login
        {
          sub: user.email,
          iat: (Time.now + TIME_EXPIRE.minutes).to_i
        }
    end

    def access_token
        {
          access_token: JsonWebTokenService.new.encode(object_login)
        }
    end

    attr_reader :email, :password

end
