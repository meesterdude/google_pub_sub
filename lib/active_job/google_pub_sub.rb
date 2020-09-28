require "google/cloud/pubsub"
module ActiveJob
	class GooglePubSub
		def self.enqueue(serialized_job, queue: 'default')
			pubsub = Google::Cloud::Pubsub.new
			pub_queue = pubsub.topic(queue)
			if pub_queue.nil?
				raise(NoQueueExistsError, "The specified queue '#{queue}' is not present in Google pub/sub. Did you run the setup rake task?")
			end
			ActiveSupport::Notifications.instrument "pubsub.enqueue", this: :data do
        pub_queue.publish serialized_job.to_json
      end
		end

		def self.enqueue_at(*)
			raise NotImplementedError, "this feature not implemented"
		end
	end
end