require 'fog/core'
require 'fog/json'
require 'fog/k5/version'

module Fog
  module K5
    extend Fog::Provider
    service(:storage, :Storage)
  end

  module Storage
    autoload :K5, File.expand_path('storage/k5', __dir__)
  end
end
