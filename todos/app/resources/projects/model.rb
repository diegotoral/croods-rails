# frozen_string_literal: true

module Projects
  module Model
    extend ActiveSupport::Concern

    included do
      # before_create :do_something
      # enum something: { foo: 0, bar: 1 }
    end

    def budget_in_dolars
      return unless budget

      budget * 5
    end
  end
end
