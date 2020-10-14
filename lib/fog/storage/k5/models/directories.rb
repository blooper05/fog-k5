# frozen_string_literal: true

module Fog
  module Storage
    class K5
      class Directories < Fog::Collection
        model Fog::Storage::K5::Directory
      end
    end
  end
end
