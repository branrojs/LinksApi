class LinkJob < ActiveJob::Base
  queue_as :default
  require 'open-uri'
  require 'uri'

  def perform(url)
    @link = Link.where(['url = ?', url])
    page_title = ''
    open(url) do |f|
      doc = Nokogiri::HTML(f)
      page_title = doc.at_css('title').text
    end
    puts "Title is #{page_title}"
    Link.update(@link[0]['id'], title: page_title)
    puts "Link updated with Title"
  end
end