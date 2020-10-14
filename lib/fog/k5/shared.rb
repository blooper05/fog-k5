# frozen_string_literal: true

module Fog
  module K5
    module Shared
      K5_URL_SCHEME = 'https'
      K5_URL_SUFFIX = 'cloud.global.fujitsu.com'

      def build_url(url_type:, region: nil)
        region ||= @k5_region
        "#{K5_URL_SCHEME}://#{url_type}.#{region}.#{K5_URL_SUFFIX}"
      end

      def refresh_auth_token_if_expired
        refresh_auth_token if auth_token_expired?
      end

      private

      def auth_token_expired?
        !@k5_auth_token_expires_at ||
          @k5_auth_token_expires_at - 300 < Fog::Time.now
      end

      def refresh_auth_token
        connection = Excon.new(build_url(url_type: 'identity'))
        response   = connection.post(auth_request_params)

        @k5_auth_token = response.headers['X-Subject-Token']
        @k5_auth_token_expires_at = Fog::Time.parse(
          Fog::JSON.decode(response.body)['token']['expires_at'],
        )
      end

      def auth_request_params
        {
          path:       'v3/auth/tokens',
          idempotent: true,
          expects:    201,
          body:       auth_request_body,
        }
      end

      def auth_request_body
        Fog::JSON.encode(
          auth: {
            identity: {
              methods:  %w[password],
              password: {
                user: {
                  domain:   {
                    name: @k5_domain_name,
                  },
                  name:     @k5_user_name,
                  password: @k5_user_password,
                },
              },
            },
            scope:    {
              project: {
                id: @k5_project_id,
              },
            },
          },
        )
      end
    end
  end
end
