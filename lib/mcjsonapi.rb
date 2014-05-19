# Require files
["api", "version"].each do |f|
  require "mcjsonapi/#{f}"
end

# Require gems
["digest/sha2", "net/http", "json"].each do |g|
  require g
end

module Mcjsonapi
  # TODO add static method for single-use calling
end
