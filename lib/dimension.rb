require 'nokogiri'
require 'json'

class Dimension
  attr_accessor :name, :type, :values, :best, :worst, :min, :max, :step_to_best,
    :step_to_worst
  
  def to_json
    h = to_h
    h.to_json
  end
  
  def to_h
    h = {}
    h[:type]=@type unless @type.nil?
    h[:values]=@values unless @values.nil? or @values.empty?
    h[:best]=@best unless @best.nil?
    h[:worst]=@worst unless @worst.nil?
    h[:min]=@min unless @min.nil?
    h[:max]=@max unless @max.nil?
    h[:step_to_best]=@step_to_best unless @step_to_best.nil?
    h[:step_to_worst]=@step_to_worst unless @step_to_worst.nil?
    {@name=>h}
  end
  
  # parse the nokogiri doc and extract the dimension propreties it contains
  def self.parse(dim_doc)
    d = self.new
    
    # extract dimension name
    d.name = dim_doc[:id]
    
    # extract dimension type
    dim_doc.css('.type').each { |t| d.type =  t.inner_text}
    
    # extract dimension type
    d.values = [];dim_doc.css('.values > .value').each { |vs| d.values << vs.inner_text}
    
    # extract the remaining properties of the dimension
    [:type, :best, :worst, :min, :max, :step_to_best,:step_to_worst].each do |arg|
      dim_doc.css(".#{arg.to_s}").each do |elem| 
        d.send("#{arg}=", elem.inner_text)
      end
    end
    #puts "dimension object : #{d.name.to_s}"
    return d    
  end
  
end