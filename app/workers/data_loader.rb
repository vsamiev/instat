class DataLoader
  include Sidekiq::Worker

  def perform(data)
    Instat.save_data(data)
  end
end