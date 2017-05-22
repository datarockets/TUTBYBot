class SubscriptionsSender
  def self.call
    establish_connection_with_db

    Chat::Subscription.active.each do |subscription|
      SubscriptionSender.new(subscription: subscription).send
    end
  end

  def self.establish_connection_with_db
    db_config = YAML::load(File.open('config/database.yml'))['default']
    ActiveRecord::Base.establish_connection(db_config)
  end
end
