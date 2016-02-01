module Doorkeeper
  module Models
    module Neo4j
      module Scopes
        extend ActiveSupport::Concern

        included do
          property :app_scopes, type: String
        end

        def scopes=(value)
          self.app_scopes = value
        end
      end
    end
  end
end