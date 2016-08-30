require_relative '../api'
require 'yaml'

module Actions
  class BaseAction
    include API

    def initialize(bot:, id:, action:)
      @bot = bot
      @id = id
      @action = action
    end

    def messages
      @_messages ||= load_yaml(messages_path)
    end

    def events
      @_events ||= load_yaml(events_path)
    end

    def categories
      @_categories ||= load_yaml(categories_path)
    end

    def basic_response(action = @action)
      track_event events[action]
      send_response messages[action]
    end

    def track_event(event = nil)
      event = event || events[@action]
      @bot.track(event, @id, type_of_chat: @id)
    end

    def send_response(response)
      @bot.api.sendMessage(chat_id: @id, text: response)
    end

    private

      def load_yaml(file_path)
        YAML::load IO.read(file_path)
      end

      def messages_path
        "config/messages.yml"
      end

      def events_path
        "config/events.yml"
      end

      def categories_path
        "config/categories.yml"
      end

  end
end
