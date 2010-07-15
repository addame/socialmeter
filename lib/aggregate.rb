require 'json'

class Aggregate
  attr_accessor :dimension, :item, :aggs
  
  def to_json
     to_h.to_json
  end
  
  def to_h
   {:dimension =>@dimension, :item=>@item, :aggs=>@aggs }
  end
  
  # parse the nokogiri doc and extract the aggregation properties it contains
  def self.parse(agg_doc)
    a = self.new
    # extract the item and dimension names 
    [:item, :dimension].each do |arg|
      agg_doc.css(".#{arg.to_s}").each { |elem| 
        a.send("#{arg.to_s}=", elem.inner_text)
      }
    end    
   
    # extract aggregation values and the associated types (functions)
    a.aggs = [];agg_doc.css('.aggs > .func').each do |vs| 
      dimension_type  = vs[:class].gsub(/func /,'')
      dimension_value = vs.inner_text
      a.aggs << {:function=> dimension_type, :value => dimension_value}
    end
    #puts "aggregation object : #{a.aggs.to_s}"
    return a
  end  
end