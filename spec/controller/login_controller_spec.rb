require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe 'POST #create' do
    let(:email) { 'test@email.com'}
    let(:password) { 'senha@123' }
    let(:valid_params) do
        {
            email: email,
            password: password
        }
    end
    let(:invalid_params) do
        {
            email: email,
            password: 'senha@321'
        }
    end
    let(:user) do
        create(
            :user,
            email: email,
            encrypted_password: password
        )
    end

    before do
        user
    end

    it 'should return status 200 when login is ok' do
        post :create, params: valid_params
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key('access_token')
    end

    it 'should return status 401 when login is incorrect' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unauthorized)
    end
  end
end