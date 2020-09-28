# frozen_string_literal: true

module ActiveJob
  module QueueAdapters

    class GooglePubSubAdapter
      def enqueue(job) #:nodoc:
        ActiveJob::GooglePubSub.enqueue(job.serialize, queue: job.queue_name)
      end

      def enqueue_at(*) #:nodoc:
        raise NotImplementedError, "this feature not implemented for this adapter"
      end
    end
  end
end