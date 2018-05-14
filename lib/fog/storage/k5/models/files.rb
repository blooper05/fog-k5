module Fog
  module Storage
    class K5
      class Files < Fog::Collection
        model Fog::Storage::K5::File
      end
    end
  end
end
