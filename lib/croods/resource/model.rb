# frozen_string_literal: true

module Croods
  module Resource
    module Model
      def extend_model(&block)
        return unless block

        model_blocks << block
      end

      def model_blocks
        @model_blocks ||= []
      end

      def model
        model_name.constantize
      end

      def create_model!
        Object.const_set(model_name, Class.new(Croods::Model))

        resource = model.resource

        if resource.search_method_name.present?
          model.send(:include, PgSearch::Model)
          model.send(:pg_search_scope, resource.search_method_name, resource.search_options)
        end

        model_blocks.each do |block|
          model.instance_eval(&block)
        end
      end

      def table_exists?
        ActiveRecord::Base.connection.table_exists? route_name
      rescue ActiveRecord::NoDatabaseError
        false
      end
    end
  end
end
