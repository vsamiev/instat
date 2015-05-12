class Instat < ActiveRecord::Base
  def self.save_data xml
    if xml_data = self.parse_xml(xml)
      
      players = Player.save_players xml_data["players"]["player"] if xml_data.has_key?("players") and xml_data["players"]

      events = Event.save_events xml_data["events"]["event"] if xml_data.has_key?("events") and xml_data["events"]

      {"players" => players, "events" => events}
    else
      false
    end
  end

  def self.parse_xml xml
    parser = Nori.new
    data_hash = parser.parse xml
    if data_hash["data"]
      data_hash["data"]
    else
      false
    end
  end
end
