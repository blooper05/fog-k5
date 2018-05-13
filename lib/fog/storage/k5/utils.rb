module Fog
  module Storage
    class K5
      module Utils
        def request(params)
          parse(@connection.request(params))
        end

        private

        def parse(response)
          return response if response.body.empty?
          response.body = Fog::JSON.decode(response.body)
          response
        end
      end
    end
  end
end
