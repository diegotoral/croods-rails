# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:organization) { organization.create!(name: 'Foo', slug: 'foo') }
  let(:user) do
    organization.users.create!(email: 'a@b.c', name: 'John', password: '123123')
  end
  let(:project) do
    described_class.create!(project_params)
  end

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:lists) }

  describe '#budget_in_dolars' do
    subject { project.budget_in_dolars }

    let(:project_params) do
      {
        user: user,
        name: 'Whatever',
        budget: budget
      }
    end

    context 'when there is a budget' do
      let(:budget) { 5 }

      it { is_expected.to be 25 }
    end

    context 'when there is no budget' do
      let(:budget) { nil }

      it { is_expected.to be nil }
    end
  end
end
