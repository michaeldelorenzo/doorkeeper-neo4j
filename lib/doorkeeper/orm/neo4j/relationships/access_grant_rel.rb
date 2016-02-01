module Doorkeeper
  module Relationships
    class AccessGrantRel
      include Neo4j::ActiveRel

      creates_unique

      from_class  'Doorkeeper::Application'
      to_class    'Doorkeeper::AccessGrant'
      type        'ACCESS_GRANT'
    end
  end
end