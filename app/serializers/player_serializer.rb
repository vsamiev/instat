class PlayerSerializer < ActiveModel::Serializer

  root false
  attributes :id, :name, :age, :height, :weight, :events, :avg_pos_x, :avg_pos_y

  def name
    Russian.translit object.name + ' ' + object.surname
  end

  def age
    now = Time.now.utc.to_date
    now.year - object.birthday.year - (object.birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def height
    h = object.height
    feet = h.divmod(30.48)
    inch = feet[1]/2.54

    result = "#{feet[0].to_s} feet"
    if inch.to_i > 0
      result + ' ' + "#{inch.round} inches"
    else
      result
    end
  end

  def weight
    w = object.weight
    p = w / 0.45359
    "#{p.round} pounds"
  end

  def events
    {"goal" => goals, "free_kick" => free_kicks, "foul" => fouls}

    # [self.goals, self.free_kicks, self.fouls]
  end

  def goals
    events = object.events.where(action: 'goal')
    events.map { |e| {"id" => e.id.to_s, "minute" => e.minute} }
  end

  def free_kicks
    events = object.events.where(action: 'free_kick')
    events.map { |e| {"id" => e.id.to_s, "minute" => e.minute} }
  end

  def fouls
    events = object.events.where(action: 'foul')
    events.map { |e| {"id" => e.id.to_s, "minute" => e.minute} }
  end

  def avg_pos_x
    (Event.where(player_id: object.id).average(:pos_x)/10.0).round(2)
  end

  def avg_pos_y
    (Event.where(player_id: object.id).average(:pos_y)/10.0).round(2)
  end


end
