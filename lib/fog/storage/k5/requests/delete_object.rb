# frozen_string_literal: true

module Fog
  module Storage
    class K5
      class Real
        def delete_object(container, object, _options = {})
          request(
            method:  :DELETE,
            path:    "#{container}/#{object}",
            expects: 204,
          )
        end
      end

      class Mock
        def delete_object(_container, _object, _options = {})
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
