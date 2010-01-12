module MEACControl
  class Device
    attr_reader :id
    attr_accessor :name

    def initialize(device_id, options = {})
      @id = device_id
      @name = options[:name] if options[:name]
    end
  end
end
