module Doorkeeper
  module Models
    module Neo4j
      module Scopes
        extend ActiveSupport::Concern

        included do
          property :scopes, type: String
        end

        def scopes=(value)
          write_attribute :scopes, value
        end
      end
    end
  end
end