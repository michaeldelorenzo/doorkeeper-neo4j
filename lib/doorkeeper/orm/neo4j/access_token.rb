require 'doorkeeper/orm/neo4j/concerns/scopes'
require 'doorkeeper-mongodb/compatible'

module Doorkeeper
  class AccessToken
    include DoorkeeperNeo4j::Compatible

    include Neo4j::ActiveNode
    include Neo4j::Timestamps

    include AccessTokenMixin
    include Models::Neo4j::Scopes

    self.mapped_label_name = 'OAuthAccessToken'

    property :resource_owner_id, type: String
    property :token,             type: String, index: :exact
    property :refresh_token,     type: String
    property :expires_in,        type: Integer
    property :revoked_at,        type: DateTime

    has_one :in, :application, rel_class: 'Doorkeeper::Relationships::AccessTokenRel'

    validates :token,         uniqueness: true
    validates :refresh_token, uniqueness: { allow_nil: true }

    def self.delete_all_for(application_id, resource_owner)
      where(application_id: application_id,
            resource_owner_id: resource_owner.id).delete_all
    end
    private_class_method :delete_all_for

    def self.order_method
      :order_by
    end

    def self.created_at_desc
      [:created_at, :desc]
    end
  end
end