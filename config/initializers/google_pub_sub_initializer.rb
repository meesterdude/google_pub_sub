require "google/cloud/pubsub"

Google::Cloud::PubSub.configure do |config|
  config.project_id  = Rails.configuration.google_pub_sub.project_id
  config.credentials = Rails.configuration.google_pub_sub.keyfile
end

class NoQueueExistsError < StandardError
end