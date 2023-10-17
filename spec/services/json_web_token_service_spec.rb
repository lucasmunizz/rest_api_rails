# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JsonWebTokenService do
  let(:user) { create(:user) }

  let(:service) { described_class.new }

  let(:payload) do
    {
      'sub' => user.email
    }
  end

  context 'when JWT is generated successfully' do
    let(:token) { service.encode(payload) }
    let(:decode) { service.decode(token) }
    it { expect(decode).to eq(payload) }
  end

  context 'when the payload is invalid' do
    let(:payload) { service.encode(nil) }
    it { expect(payload).to eq(false) }
  end

  context 'when the token is invalid' do
    let(:invalid_token) { 'invalid_token' }
    let(:decode) { service.decode(invalid_token) }
    it { expect(decode).to eq(false) }
  end
end
