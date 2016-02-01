module Doorkeeper
  module Orm
    module Neo4j
      def self.initialize_models!
        require 'doorkeeper/orm/neo4j/access_grant'
        require 'doorkeeper/orm/neo4j/access_token'
        require 'doorkeeper/orm/neo4j/application'
      end

      def self.initialize_application_owner!
        require 'doorkeeper/models/concerns/ownership'

        Doorkeeper::Application.send :include, Doorkeeper::Models::Ownership
      end

      def self.check_requirements!(_config);end
    end
  end
end
