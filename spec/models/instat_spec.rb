require 'rails_helper'

describe Instat do
  context "Valid data" do

    it "saves valid xml data" do

      # Read xml data from file
      # then prepare hashes of data to compare saved results

      valid_player_xml = File.read(Rails.root.join("spec/factories/valid_players_data.xml"))

      parser = Nori.new
      xml_data = parser.parse(valid_player_xml)
      players = xml_data["data"]["players"]["player"]
      events = xml_data["data"]["events"]["event"]

      # clean keys of input data to compare
      data_hash_origin = Array.new
      players.each do |player|
        data_hash_origin << Hash[player.map { |k, v| [k.to_s.delete("@"), v] }]
      end
      events.each do |event|
        data_hash_origin << Hash[event.map { |k, v| [k.to_s.delete("@"), v] }]
      end

      # save data
      result = Instat.save_data(valid_player_xml)

      data_hash_created = Array.new
      result["players"].each do |player|
        player["birthday"] = player["birthday"].to_time.strftime("%d.%m.%Y")
        player["id"] = player["id"].to_s
        player["height"] = player["height"].to_s
        player["weight"] = player["weight"].to_s
        data_hash_created << player.except("updated_at", "created_at")
      end
      result["events"].each do |event|
        event["id"] = event["id"].to_s
        event["player_id"] = event["player_id"].to_s
        event["half"] = event["half"].to_s
        event["second"] = event["second"].to_s
        event["pos_x"] = (event["pos_x"].to_f/10.0).to_s.gsub('.', ',')
        event["pos_y"] = (event["pos_y"].to_f/10.0).to_s.gsub('.', ',')
        data_hash_created << event.except("updated_at", "created_at")
      end
      expect(data_hash_origin).to eq data_hash_created
    end

    it "saves valid xml data with players only" do
      valid_player_xml = File.read(Rails.root.join("spec/factories/valid_players_only.xml"))
      result = Instat.save_data(valid_player_xml)
      expect(result["players"].length).to eq 6
    end

    it "saves valid xml data with events only" do

      player = FactoryGirl.create(:player)
      player.events.create(FactoryGirl.attributes_for(:event_1))
      player.events.create(FactoryGirl.attributes_for(:event_2))

      valid_events_xml = File.read(Rails.root.join("spec/factories/valid_events_only.xml"))
      result = Instat.save_data(valid_events_xml)

      expect(result["events"].length).to eq 2

    end

    it "saves valid xml data with new player data" do
      valid_player_xml = File.read(Rails.root.join("spec/factories/valid_new_player.xml"))
      expect{
          Instat.save_data(valid_player_xml)
      }.to change(Player, :count).by(1)
    end

    it "updates valid xml data with exists player data" do

      player = FactoryGirl.create(:player)
      valid_player_xml = File.read(Rails.root.join("spec/factories/valid_exists_player.xml"))

      Instat.save_data(valid_player_xml)

      player.reload
      expect(player.height).to eq 185
      expect(player.weight).to eq 82
    end

  end

  context "Invalid data" do
    it "does not save invalid xml data" do
      invalid_player_xml = File.read(Rails.root.join("spec/factories/invalid_players_data.xml"))
      expect(Instat.save_data(invalid_player_xml)).to eq false
    end
  end
end