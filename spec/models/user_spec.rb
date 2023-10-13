# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'Validators' do
    context 'when a register is successfully created' do
      it { expect(user.valid?).to eq(true) }
    end

    context "when a user name don't exists" do
      before do
        user.name = nil
        user.valid?
      end

      let(:error_message) do
        {
          name: ["can't be blank"]
        }
      end

      it { expect(user.errors.messages).to eq(error_message) }
    end
  end

  describe 'Uniqueness' do
    let(:user_b) { build(:user, email: user.email) }
    context 'when email has already been taken' do
      let(:error_message) do
        {
          email: ['has already been taken']
        }
      end
      before do
        user.save

        user_b.valid?
      end

      it { expect(user_b.errors.messages).to eq(error_message) }
    end
    context 'when email is not valid' do
      let(:invalid_message) { 'Invalid_message' }
      let(:error_message) do
        {
          email: ['invalid format']
        }
      end
      before do
        user.email = invalid_message
        user_b.valid?
      end

      it { expect(user_b.errors.messages).to eq(error_message) }
    end
  end

  describe 'callback :before_create' do
    context 'when the password is in correct format' do
      let(:valid_password) { 'ValidPassword@123'}
      let(:user) do
        create(:user, encrypted_password: valid_password )
      end

      let(:password_valid?) do
        my_password = BCrypt::Password.new(user.encrypted_password)

        my_password == valid_password
      end

      it { expect(password_valid?).to eq(true) }
    end
  end

  describe 'callback :before_update' do
    context 'when the password is in correct format' do
      let(:valid_password) { 'ValidPasswordUpdate@123'}
      let(:user) { create(:user) }

      before do
        user.update(encrypted_password: valid_password)
      end

      let(:password_valid?) do
        my_password = BCrypt::Password.new(user.encrypted_password)

        my_password == valid_password
      end

      it { expect(password_valid?).to eq(true) }
    end
  end
end
