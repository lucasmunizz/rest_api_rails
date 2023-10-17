require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { create(:user, email: 'test@email.com', encrypted_password: 'senha@123') }
  let(:valid_params) do
    {
      user: {
        name: 'teste',
        email: 'testeefe@email.com',
        encrypted_password: 'senha@123'
      }
    }
  end
  let(:invalid_params) do
    {
      user: {
        name: nil,
        email: 'testeefe@email.com',
        encrypted_password: 'senha@123'
      }
    }
  end

  before do
    user
  end
  describe "POST #create" do
    context 'when parameters are valid' do
     it 'should return status code 201 when an user is created' do
      post :create, params: valid_params
      expect(response).to have_http_status(:created)
     end
    end

    context 'when user is not successfulled created' do
      it 'should return status code 422' do
        post :create, params: invalid_params
        expect(response).to have_http_status(422)
      end
    end
  end
end