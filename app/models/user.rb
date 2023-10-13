# frozen_string_literal: true

class User < ApplicationRecord
  EMAIL_REGEX = /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\z/
  validates :name, :email, :encrypted_password, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: EMAIL_REGEX, message: 'invalid email' }
end
