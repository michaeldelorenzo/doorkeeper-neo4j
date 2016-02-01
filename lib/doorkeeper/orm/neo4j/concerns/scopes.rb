module Doorkeeper
  module Models
    module Neo4j
      module Scopes
        extend ActiveSupport::Concern

        included do
          property :_scopes, type: String
        end

        def scopes=(value)
          self._scopes = value
        end
      end
    end
  end
end