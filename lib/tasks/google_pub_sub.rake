namespace :google_pub_sub do
  desc "populates googlepubsub topics as our defined queues"
  task setup: :environment do
  	pubsub = Google::Cloud::Pubsub.new
	existing_queues = pubsub.topics.collect { |t| t.name.split("/").last}
	Rails.configuration.google_pub_sub.queues.each do |new_queue|
		pubsub.create_topic new_queue unless new_queue.in?(existing_queues)
	end
	pubsub.create_topic 'morgue' unless 'morgue'.in?(existing_queues)
	morgue_topic = pubsub.get_topic("morgue")
	if morgue_topic.subscriptions.empty?
		morgue_topic.subscribe "holder"
	end
  end

end
