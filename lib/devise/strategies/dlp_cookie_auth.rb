require 'devise/strategies/database_authenticatable'

module Devise
  module Strategies
    class DlpCookieAuth < Devise::Strategies::DatabaseAuthenticatable
      def valid?
        request.cookies.has_key?('dlpuserid') && request.cookies.has_key?('dlppassword')
      end
      def authenticate!
        user = DLPUser.find_by_sql ["SELECT userid FROM user WHERE userid = ? AND MD5(CONCAT(password, ?)) = ?",
                                    request.cookies['dlpuserid'],
                                    ENV['VB_SALT'],
                                    request.cookies['dlppassword']]

        #MD5(CONCAT(password, 'VBF5598F9A')) == cookiePass

        if user.first
          success!(user.first)
        else
          super
        end
      end
    end
  end
end

