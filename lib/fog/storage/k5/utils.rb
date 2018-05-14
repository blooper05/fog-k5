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
          return response unless json?(response)

          response.body = Fog::JSON.decode(response.body)
          response
        end

        def json?(response)
          response.headers['Content-Type'].include?('application/json')
        end
      end
    end
  end
end
