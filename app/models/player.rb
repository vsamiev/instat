class Player < ActiveRecord::Base

  has_many :events

  def self.save_players players
    result = Array.new

    players_array = players.kind_of?(Array) ? players : [players]


    players_array.each do |player|

      player_record = Player.find_or_create_by(id: player["@id"])

      player_record.update(name:      player["@name"],
                           surname:   player["@surname"],
                           birthday:  player["@birthday"],
                           height:    player["@height"],
                           weight:    player["@weight"])

      result << player_record.attributes
    end
    result
  end

end
