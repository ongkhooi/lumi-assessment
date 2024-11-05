publishers = [
  {
    name: "SAYS",
    rss_url: "https://says.com/my/rss",
    website_url: "https://says.com/my",
    language: "English"
  },
  {
    name: "Utusan",
    rss_url: "https://www.utusan.com.my/feed/",
    website_url: "https://www.utusan.com.my",
    language: "BM"
  },
  {
    name: "Berita Harian",
    rss_url: "https://beritaharian.my/feed/",
    website_url: "https://beritaharian.my",
    language: "BM"
  }
]

# Seed the publishers
publishers.each do |publisher_data|
  Publisher.find_or_create_by!(name: publisher_data[:name]) do |publisher|
    publisher.rss_url = publisher_data[:rss_url]
    publisher.website_url = publisher_data[:website_url]
    publisher.language = publisher_data[:language]
  end
end

puts "Seeded publishers successfully."