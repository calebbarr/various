require 'open-uri'
require 'nokogiri'


#functions
def get_page(url)
  return Nokogiri::HTML(open(url))
end

def extract_tokens(page)
  return (page/
  "//*[not(self::script or self::style or self::link)]/text()")
  .to_a
  .flat_map{|xml| xml.to_s.split(/\s+/) }
end

def get_counts(tokens)
  counts = {}
  tokens.each{ |token| 
    counts[token] = counts.key?(token) ? counts[token] + 1 : 1
  }
  return counts.sort_by{|k,v| v}.reverse
end

def output(results)
  results.each { |result|
    puts result[0]+": "+result[1].to_s
  }
end


  
# script level code
url = ARGV[0]
output(
  get_counts(
    extract_tokens(
      get_page(
        url))))
