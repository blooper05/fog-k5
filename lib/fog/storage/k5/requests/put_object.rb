# frozen_string_literal: true

module Fog
  module Storage
    class K5
      class Real
        def put_object(container, object, data, _options = {})
          data   = Fog::Storage.parse_data(data)
          params = {
            method:  :PUT,
            path:    "#{container}/#{object}",
            expects: 201,
          }

          request(params.merge(data))
        end
      end

      class Mock
        def put_object(_container, _object, _data, _options = {})
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
