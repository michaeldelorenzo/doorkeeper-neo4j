class User
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property  :name,        type: String
  property  :password,    type: String

  if ::Rails.version.to_i < 4 || defined?(::ProtectedAttributes)
    attr_accessible :name, :password
  end

  def self.authenticate!(name, password)
    User.where(name: name, password: password).first
  end
end