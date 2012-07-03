class Pushover
  cattr_accessor :API_KEY

  # this needs to be overridden in config/initializers/production.rb
  @@API_KEY = nil

  def self.push(user, device, params)
    if !@@API_KEY
      return
    end

    begin
      s = Sponge.new
      s.fetch("https://api.pushover.net/1/messages.json", :post, {
        :token => @@API_KEY,
        :user => user,
        :device => device
      }.merge(params))
    rescue => e
      Rails.logger.error "error sending to pushover: #{e.inspect}"
    end
  end
end
