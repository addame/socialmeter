require 'nokogiri'
require 'someter'  


string_to_parse = <<END_STR 
<div>
<!--taste rating dimension-->
<span class="someter dimension" id="taste">
	<span class="type">integer</span><!--optional if
        step_to_best, min and max are specified-->
	<span class="min">0</span>
	<span class="max">10</span>
	<span class="best">10</span><!--optional-->
	<span class="worst">0</span><!--optional-->
	<span class="step_to_best">+1</span><!--optional-->
	<span class="step_to_worst">-1</span><!--optional-->
</span>

<!--dressing rating dimension-->
<span class="someter dimension" id="dressing">
	<span class="type">integer</span><!--optional if
        step_to_best, min and max are specified-->
	<span class="min">0</span>
	<span class="max">10</span>
	<span class="best">10</span><!--optional-->
	<span class="worst">0</span><!--optional-->
	<span class="step_to_best">+1</span><!--optional-->
	<span class="step_to_worst">-1</span><!--optional-->
</span>

<!--dough rating dimension-->
<span class="someter dimension" id="dough">
	<span class="type">integer</span><!--optional if
        step_to_best, min and max are specified-->
	<span class="min">0</span>
	<span class="max">3</span>
	<span class="best">0</span><!--optional-->
	<span class="worst">3</span><!--optional-->
	<span class="step_to_best">+1</span><!--optional-->
	<span class="step_to_worst">-1</span><!--optional-->
</span>

<!--looking rating dimension-->
<span class="someter dimension" id="looking">
	<span class="type">string</span><!--optional if
        step_to_best, min and max are specified-->
    <span class="values">
        <span class="value">ugly</span>
        <span class="value">not to bad</span>
        <span class="value">good</span>
        <span class="value">very good</span>
    </span>
	<span class="best">very good</span><!--optional-->
	<span class="worst">ugly</span><!--optional-->
</span>

<div class="someter aggregates">
    <span class="item">L'Amourita Pizza</span>
    <span class="dimension">taste</span>    
    <span class="aggs">
        Taste: average
        <span class="func average">6</span>		
        based on
        <span class="func ratings">24</span>,
        maximum
        <span class="func max">8</span>
	</span>	
</div>
<div class="someter aggregates">
    <span class="item">L'Amourita Pizza</span>
    <span class="dimension">dressing</span>        
    <span class="aggs">
        Dressing: average
        <span class="func average">7</span>		
        based on
        <span class="func ratings">24</span>,
        maximum
        <span class="func max">10</span>
	</span>
</div>
<div class="someter aggregates">
    <span class="item">L'Amourita Pizza</span>
    <span class="dimension">dough</span>        
    <span class="aggs">
        Dough: average
        <span class="func average">1</span>		
        based on
        <span class="func ratings">24</span>,
        maximum
        <span class="func max">3</span>
	</span>
</div>
<div class="someter aggregates">
    <span class="item">L'Amourita Pizza</span>
    <span class="dimension">looking</span>        
    <span class="aggs">
        Looking: average
        <span class="func average">good</span>		
        based on
        <span class="func ratings">24</span>,
        maximum
        <span class="func max">very good</span>
	</span>
</div>
</div>
END_STR

def test 
  doc = Nokogiri::HTML(string_to_parse) 
 
  doc.css('.aggs > .func').each { |vs| 
    # remove func
    puts vs[:class].gsub(/func /,'')
    puts  vs.inner_text
  } 
  
end

def write_to_file(message)
  File.open('test.txt', 'a') do |f2|
    f2.puts message
  end
end


sm = SoMeter.new(:string =>string_to_parse)

#puts sm.to_js
write_to_file sm.to_js

#class Salut
#  def hello s
#    puts s
#  end
#end
#
#s = Salut.new
#
#s.send(:hello, 'Bonjour, comment ca va ?')