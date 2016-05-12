class NewsImportWorker
  include Sidekiq::Worker

  def perform(source_url)
  end
end
