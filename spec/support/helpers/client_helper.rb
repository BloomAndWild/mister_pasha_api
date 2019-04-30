require "logger"

def configure_client
  MisterPashaApi::Client.configure do |config|
    logger = Logger.new(STDERR)
    logger.level = :debug

    config.base_url = ENV.fetch("SANDBOX_BASE_URL")
    config.api_key = ENV.fetch("SANDBOX_API_KEY")
    config.logger = logger
  end
end
