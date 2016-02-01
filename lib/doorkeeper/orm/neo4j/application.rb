require 'neo4j'

module Doorkeeper
  class Application
    include ::Neo4j::ActiveNode
    include ::Neo4j::Timestamps

    # TODO: What to do with this?
    include Models::Neo4j::Scopes

    include ApplicationMixin

    self.mapped_label_name = 'OAuthApplication'

    property :name,         type: String
    property :secret,       type: String
    property :redirect_uri, type: String

    # has_many :out, :authorized_tokens, rel_class: 'Doorkeeper::Relationships::AccessTokenRel'
    has_many :out, :access_tokens, rel_class: 'Doorkeeper::Relationships::AccessTokenRel'
    has_many :out, :access_grants, rel_class: 'Doorkeeper::Relationships::AccessGrantRel'

    def self.authorized_for(resource_owner)
      ids = AccessToken.where(resource_owner_id: resource_owner.id, revoked_at: nil).map(&:application_id)
      find(ids)
    end

    def uid
      uuid
    end

    def uid=(val)
      self.uuid = val
    end

  end
end