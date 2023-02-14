module Migrate
  # Populate Location table with all counties from Romania
  def self.get_counties
    link = "https://roloca.coldfuse.io/judete"
    h = HTTParty.get(link)

    h.each do |data|
      Location.create(name: data["nume"])
    end
  end

  # Get abbreviation for each county from Romania
  def self.get_short_for_counties
    link = "https://roloca.coldfuse.io/judete"
    h = HTTParty.get(link)

    h.each do |data|
      location = Location.where(name: data["nume"]).first
      location.short = data["auto"]
      location.save
    end
  end
end