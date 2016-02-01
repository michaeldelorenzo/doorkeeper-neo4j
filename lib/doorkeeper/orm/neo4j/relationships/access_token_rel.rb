module Doorkeeper
  module Relationships
    class AccessTokenRel
      include Neo4j::ActiveRel

      creates_unique

      from_class  'Doorkeeper::Application'
      to_class    'Doorkeeper::AccessToken'
      type        'ACCESS_TOKEN'
    end
  end
end