module Clockwork

  module DatabaseEvents

    class Event < Clockwork::Event

      attr_accessor :sync_performer, :at

      def initialize(manager, period, job, block, sync_performer, options={})
        super(manager, period, job, block, options)
        @sync_performer = sync_performer
        @sync_performer.register(self, job)
      end

      def name
        job.name
      end

      def to_s
        name
      end

      def name_or_frequency_has_changed?(model)
        name_has_changed?(model) || frequency_has_changed?(model)
      end

      protected
      def name_has_changed?(model)
        name != model.name
      end

      def frequency_has_changed?(model)
        @period != model.frequency
      end
    end

  end
end