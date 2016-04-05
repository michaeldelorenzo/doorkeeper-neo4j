require 'neo4j'
require 'doorkeeper/orm/neo4j/relationships/access_grant_rel'
require 'doorkeeper/orm/neo4j/relationships/access_token_rel'

module Doorkeeper
  class Application
    include ::Neo4j::ActiveNode
    include ::Neo4j::Timestamps
    include Models::Neo4j::Scopes

    before_validation :generate_secret, on: :create

    property :name,         type: String
    property :secret,       type: String
    property :redirect_uri, type: String

    has_many :out, :access_tokens, rel_class: 'Doorkeeper::Relationships::AccessTokenRel'
    has_many :out, :access_grants, rel_class: 'Doorkeeper::Relationships::AccessGrantRel'

    validates :name, :secret, presence: true
    validates :redirect_uri, redirect_uri: true

    scope :by_uid_and_secret, ->(uid, secret){ where(id: uid, secret: secret).first }

    if respond_to?(:attr_accessible)
      attr_accessible :name, :redirect_uri, :scopes
    end

    def self.authorized_for(resource_owner)
      Doorkeeper::Application.as(:app).access_tokens(:atokens).where(resource_owner_id: resource_owner.id, revoked_at: nil).pluck(:app)
    end

    private

    def has_scopes?
      Doorkeeper.configuration.orm != :active_record || Application.new.attributes.include?('app_scopes')
    end

    def generate_secret
      self.secret = Doorkeeper::OAuth::Helpers::UniqueToken.generate if secret.blank?
    end
  end
end
