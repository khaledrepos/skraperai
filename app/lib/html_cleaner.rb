require 'nokogiri'
require 'json'
require 'yaml'
require 'active_support/core_ext/hash'
require 'active_support'

class HtmlCleaner



  def self.run(content)
    doc = Nokogiri::HTML.parse(content)
    
    # define and remove undesired tags
    to_be_removed = %w(nav style script head footer header noscript link meta iframe form button svg aside)
    doc.search(*to_be_removed).remove
    
    # preprocessing with python libraries
    escaped_doc = Shellwords.escape(doc.to_xhtml)
    clean_doc = `python ../preprocessing/main_inscriptis.py #{escaped_doc}`
    

    pp clean_doc
    return clean_doc
  end

end






# def to_output(doc)
#   File.open('output.json', 'w') do |f|
#     text = doc.to_xhtml #.gsub(/\n+/, "\n")

#     f.write(JSON.parse(Hash.from_xml(text).to_json));
#   end
# end




