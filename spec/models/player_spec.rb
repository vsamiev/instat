require 'rails_helper'

RSpec.describe Player, :type => :serializer do
  before :each do
    @player = FactoryGirl.create(:player)
    @player.events.create(FactoryGirl.attributes_for(:event_1))
    @player.events.create(FactoryGirl.attributes_for(:event_2))
    @player.events.create(FactoryGirl.attributes_for(:event_3))
    @player.events.create(FactoryGirl.attributes_for(:event_4))
    @serializer = PlayerSerializer.new @player
    @json_data = JSON.parse(@serializer.to_json)
  end

  it 'has a valid id' do
    expect(@json_data["id"]).to eq @player.id
  end

  it 'has a valid name' do
    expect(@json_data["name"]).to eq "Yuriy Lodygin"
  end

  it 'has a age' do
    expect(@json_data["age"]).to eq 30
  end

  it 'has a valid height' do
    expect(@json_data["height"]).to eq "5 feet 9 inches"
  end

  it 'has a valid weight' do
    expect(@json_data["weight"]).to eq "161 pounds"
  end

  it 'has a valid events' do
    expect(@json_data["events"]).to eq @serializer.events
  end
end
