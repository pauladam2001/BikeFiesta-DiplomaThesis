module Migrate
  # Populate Location table with all counties from Romania
  def self.get_counties
    link = "https://roloca.coldfuse.io/judete"
    h = HTTParty.get(link)

    h.each do |data|
      Location.create(name: data["nume"])
    end
  end
end