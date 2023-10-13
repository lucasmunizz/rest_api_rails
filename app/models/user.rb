# frozen_string_literal: true

class User < ApplicationRecord
  EMAIL_REGEX = /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\z/
  PASSWORD_REGEX = /\A(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,}\z/
  INVALID_MESSAGE = 'invalid format'
  validates :name, :email, :encrypted_password, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: EMAIL_REGEX, message: INVALID_MESSAGE }
  validates :encrypted_password, format: { with: PASSWORD_REGEX, message: INVALID_MESSAGE}

  before_create :set_encrypted_password
  before_update :set_encrypted_password, if: :encrypted_password_change?

  private

  def encrypted_password_change?
    changes['encrypted_password'].present?
  end

  def set_encrypted_password
    self.encrypted_password = BCrypt::Password.create(encrypted_password)
  end
end
