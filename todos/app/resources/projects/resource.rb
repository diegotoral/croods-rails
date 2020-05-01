# frozen_string_literal: true

module Projects
  class Resource < ApplicationResource
    add_action :highlighted, on: :collection do
      authorize model
      render json: collection.where(highlighted: true)
    end

    extend_model { include Projects::Model }
  end
end
