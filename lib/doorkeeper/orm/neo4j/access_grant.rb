require 'doorkeeper/orm/mongoid5/concerns/scopes'
require 'doorkeeper-mongodb/compatible'

module Doorkeeper
  class AccessGrant
    include DoorkeeperNeo4j::Compatible

    include Neo4j::ActiveNode
    include Neo4j::Timestamps

    include AccessGrantMixin
    include Models::Neo4j::Scopes

    self.mapped_label_name = 'OAuthAccessGrant'

    property :resource_owner_id, type: String
    property :token,             type: String, index: :exact
    property :expires_in,        type: Integer
    property :redirect_uri,      type: String
    property :revoked_at,        type: DateTime

    validates :token,         uniqueness: true
  end
end