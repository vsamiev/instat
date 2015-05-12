class Event < ActiveRecord::Base

  attr_reader :minute

  belongs_to :player

  def self.save_events events
    result = Array.new
    events.each do |event|

      player_record = Player.find_by(id: event["@player_id"])

      if player_record
        event = player_record.events.create(id: event["@id"],
                                            action: event["@action"],
                                            half: event["@half"],
                                            second: event["@second"],
                                            pos_x: pos_to_int(event["@pos_x"]),
                                            pos_y: pos_to_int(event["@pos_y"]))

        result << event.attributes
      end
    end
    result
  end

  def self.pos_to_int pos
    p = pos.split(',')
    if p.length == 2
      (p[0].to_i*10) + p[1].to_i
    else
      (p[0].to_i*10)
    end
  end

  def minute
    (second/60.0).round
  end

end
