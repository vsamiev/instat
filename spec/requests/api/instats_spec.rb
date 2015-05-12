require 'rails_helper'

describe 'Instat API' do
  before :each do
    @valid_xml_data = File.read(Rails.root.join("spec/factories/valid_players_data.xml"))
    @invalid_xml_data = File.read(Rails.root.join("spec/factories/invalid_players_data.xml"))
    @request_host = "http://api.example.com"
  end
  context "POST to create" do
    it "creates data when xml is valid" do
      post "#{@request_host}/incoming/", :data => @valid_xml_data
      expect(DataLoader).to have_enqueued_job(@valid_xml_data)
      expect(response).to be_succes
    end

    # as it runs in background we do not test it now
    # it "does not creates data when xml is not valid" do
    #   post "#{@request_host}/instats/", :data => @invalid_xml_data
    #   expect(response.code).to eq "422"
    # end
  end

  context "GET to show" do
    it "sends json when player exists" do
      @player = FactoryGirl.create(:player)
      @player.events.create(FactoryGirl.attributes_for(:event_1))
      @player.events.create(FactoryGirl.attributes_for(:event_2))
      @player.events.create(FactoryGirl.attributes_for(:event_3))
      @player.events.create(FactoryGirl.attributes_for(:event_4))

      get "#{@request_host}/players/3779.json"
      expect(response).to be_succes
      json = JSON.parse(response.body)

      expect(json["name"]).to eq "Yuriy Lodygin"
      expect(json["age"]).to eq 30
      expect(json["height"]).to eq "5 feet 9 inches"
      expect(json["weight"]).to eq "161 pounds"
      expect(json["avg_pos_x"]).to eq "17.43"
      expect(json["avg_pos_y"]).to eq "53.98"
      expect(json["events"].length).to eq 3
      expect(json["events"]["goal"].length).to eq 1
      expect(json["events"]["free_kick"].length).to eq 1
      expect(json["events"]["foul"].length).to eq 2

    end
    it "sends not found when player does not exist" do
      get "#{@request_host}/instats/3778.json"
      expect(response.code).to eq "404"
      expect(response.body).to eq ''
    end
  end

end
