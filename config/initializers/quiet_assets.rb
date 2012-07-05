# Be sure to restart your server when you modify this file.

Rails.application.assets.logger = Logger.new('/dev/null')
Rails::Rack::Logger.class_eval do
  def call_app_with_quiet_assets(env)
    if env['PATH_INFO'].index('/assets/') == 0
      @app.call(env)
    else
      call_app_without_quiet_assets(env)
    end
  end
  alias_method_chain :call_app, :quiet_assets
end
