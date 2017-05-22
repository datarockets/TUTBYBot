class Chat::DeterministicPrediction
  attr_reader :chat

  def initialize(chat:)
    @chat = chat
  end

  def calculate
    '/' + command
  end

  def command
    if type == 'currencies' || type == 'top'
      type
    elsif type == 'news'
      payload
    else
      type + " " + payload
    end
  end

  def type
    most_common_type_with_requests.first
  end

  def payload
    most_common_payload || ""
  end

  private

  def most_common_payload
    sorted_requests_by_payload.first
  end

  def sorted_requests_by_payload
    grouped_requests_by_payload.sort_by do |grouped_block|
      grouped_block[1].size
    end.reverse.first
  end

  def grouped_requests_by_payload
    most_common_requests.group_by(&:payload)
  end

  def most_common_requests
    most_common_type_with_requests.second
  end

  def most_common_type_with_requests
    @_most_common_type_with_requests ||= sorted_requests_by_type_count.first
  end

  def sorted_requests_by_type_count
    grouped_requests_by_type.sort_by do |grouped_block|
      requests = grouped_block[1]

      requests.size
    end.reverse
  end

  def grouped_requests_by_type
    chat.requests.group_by(&:type)
  end
end
