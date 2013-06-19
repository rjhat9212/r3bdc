class ServiceArea::ServiceAvailable
  attr_accessor :zip_code
  attr_accessor :status
  attr_accessor :description

  def initialize(*opts)
    opts.each{ |h| h.each{|k,v| self.send("#{k.to_s}=",v)  if self.respond_to?("#{k.to_s}=")} }
  end
  @@data = [
      ServiceArea::ServiceAvailable.new(zip_code:'98115',status:'Available',description:'This area is currently storing customer goods and accepting new clients.'),
      ServiceArea::ServiceAvailable.new(zip_code:'98104',status:'Available',description:'This area is currently storing customer goods and accepting new clients.'),
      ServiceArea::ServiceAvailable.new(zip_code:'32828',status:'Available',description:'This area is currently storing customer goods and accepting new clients.'),
      ServiceArea::ServiceAvailable.new(zip_code:nil,status:'Coming Soon',description:'We currently do not have storage facilities in your area, but we are coming soon!'),
  ]
  @@zips = {}.tap{|h| @@data.each{|s| h[s.zip_code] = s }}
  class << self
    def find_by_zip_code(zip_code)
      return @@zips[zip_code] if @@zips[zip_code]
      return @@zips[nil]
    end

  end

end