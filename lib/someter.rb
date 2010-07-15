# crawl a webpage and extract review data and transforms it to json

require 'nokogiri'
require 'dimension'
require 'review'
require 'aggregate'
require 'json'

class SoMeter
  
  attr_accessor :reviews, :url, :string, :doc
  
  def initialize(options) 
    @url = options[:url] unless options[:url].nil? 
    @string = options[:string] unless options[:string].nil? 
    if(!@url.nil?)
      @doc = nokogiri_doc
    elsif(!@string.nil?)
      @doc = Nokogiri::HTML(@string.force_encoding('utf-8'))
    end
    so_meter_it
  end
  
  def print_reviews  
  end

  def print_review(index)  
      
  end  
  
  def to_json
    @reviews.to_json
  end
 
  def print
    puts @reviews[:dimensions].to_s
    puts @reviews[:aggregates].to_s
  end
  
  
  private 

  def so_meter_it
    @reviews = {}
    #@reviews[:dimensions] = dimensions 
    #puts "@reviews[:dimensions] = #{@reviews[:dimensions]}"
    @reviews[:aggregates] = aggregates 
    #puts "@reviews[:aggregates] = #{@reviews[:aggregates]}"
  end
  
 
  
  def dimensions
    dims = []
    @doc.css('.someter.dimension').each { |dim| 
      dims << Dimension.parse(dim) 
     }
     return dims
  end

  def aggregates 
    aggs = []
    @doc.css('.someter.aggregates').each { |agg| 
      aggs << Aggregate.parse(agg) 
    }
    return aggs
  end
  
  def nokogiri_doc
    f = open(@url)
    f.rewind
    Nokogiri::HTML(f.readlines.join("\n").force_encoding('utf-8'))
  end
    
end