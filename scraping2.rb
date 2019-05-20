require 'open-uri'
require 'nokogiri'
require 'csv'

ingredient = 'chocolate'
url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?s=#{ingredient}"

html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)

html_doc.search('.m_titre_resultat a').each do |element|
  puts element.text.strip
  # puts element.attribute('href').value
end

csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
filepath    = 'results.csv'

CSV.open(filepath, 'wb', csv_options) do |csv|
  number = 1
  html_doc.search('.m_titre_resultat a').each do |element|
    puts element.text.strip
    title = element.text.strip
    csv << [number, title]
    number += 1
  end
end
