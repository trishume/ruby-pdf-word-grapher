require 'gchart'

$text = File.read("Lotf.txt")
$granularity = 300

def occs(word)
  total = 0
  occurs = []
  this_box = 0
  box_total = 0
  $text.each_line do |line|
    this_box += 1
    if this_box > $granularity # dump box
      occurs << box_total
      box_total = 0
      this_box = 0
    end
    l = line.downcase
    l.scan(word) {box_total += 1}
  end
  return occurs
end

words = ["simon","hunt","glasses","fun","savage","tribe","lord of the flies","rules","shelter"]
colors = ["FF0000,EE7600,0000FF,00FF00,002222,ee00ee,CC1100,660066,447744,444477,774444"]
legend = words.map {|w| "occurences of #{w}"}
legend << "occurences of pig"
data = words.map {|w| occs(w)}
data << occs("pig").map {|x| x/2}
url = Gchart.line(:size => '900x300', 
            :title => "Occurences of Words in Lord of the Flies",
            :line_colors => colors,
            :legend => legend,
            :axis_with_labels => ['y'],
            :data => data)
            
puts "GChart: #{url}"