# frozen_string_literal: true

require 'rails_helper'

describe 'DELETE /users/:id', type: :request do
  subject { response }

  let(:user) do
    User.create! email: 'foo@bar.com', name: 'Foo Bar', password: 'foobar'
  end

  context 'with valid request' do
    before do
      delete "/users/#{user.id}"
    end

    it { is_expected.to have_http_status(:ok) }
    it { expect(response.body).to eq_json(user) }
    it { expect(User.find_by(email: 'foo@bar.com')).to be_nil }
  end

  context 'with invalid request' do
    let(:error) do
      {
        id: 'bad_request',
        message: "Invalid request.\n\n#: failed schema " \
          '#/definitions/user/links/3/schema: "foo" is not a ' \
          'permitted key.'
      }
    end

    before do
      delete "/users/#{user.id}", params: { foo: 'bar' }.to_json
    end

    it { is_expected.to have_http_status(:bad_request) }
    it { expect(response.body).to eq_json(error) }
    it { expect(User.find_by(email: 'foo@bar.com')).to eq(user) }
  end

  context 'without current user' do
    let(:headers) { { 'access-token' => nil } }

    before do
      delete "/users/#{user.id}", headers: headers
    end

    it { is_expected.to have_http_status(:unauthorized) }
  end

  context 'when current user is not admin but is a supervisor' do
    before do
      current_user.update! admin: false, supervisor: true
      delete "/users/#{user.id}"
    end

    it { is_expected.to have_http_status(:forbidden) }
  end

  context 'when current user is not admin or supervisor' do
    let(:error) do
      {
        id: 'forbidden',
        message: 'not allowed to destroy? this User'
      }
    end

    before do
      current_user.update! admin: false, supervisor: false
      delete "/users/#{user.id}"
    end

    it { is_expected.to have_http_status(:forbidden) }
    it { expect(response.body).to eq_json(error) }
  end
end
