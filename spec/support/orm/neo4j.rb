DatabaseCleaner[:neo4j].strategy = :truncation
DatabaseCleaner[:neo4j].clean_with :truncation