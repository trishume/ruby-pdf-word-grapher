require 'ostruct'

$text = File.read("Lotf.txt")
$granularity = 7

$data = OpenStruct.new({
  :nodes=>[
    OpenStruct.new({:node_value=>"piggy", :group=>3}),
    OpenStruct.new({:node_value=>"ralph", :group=>3}),
    OpenStruct.new({:node_value=>"simon", :group=>3}),
    OpenStruct.new({:node_value=>"jack", :group=>3}),
    OpenStruct.new({:node_value=>"roger", :group=>1}),
    OpenStruct.new({:node_value=>"sam", :group=>1}),
    OpenStruct.new({:node_value=>"pig ", :group=>2}),
    OpenStruct.new({:node_value=>"fire", :group=>2}),
    OpenStruct.new({:node_value=>"tribe", :group=>4}),
    OpenStruct.new({:node_value=>"lord of the flies", :group=>4}),
    OpenStruct.new({:node_value=>"glasses", :group=>2}),
    OpenStruct.new({:node_value=>"specs", :group=>2}),
    OpenStruct.new({:node_value=>"beast", :group=>4}),
    OpenStruct.new({:node_value=>"hunt", :group=>5}),
    OpenStruct.new({:node_value=>"kill", :group=>5}),
    OpenStruct.new({:node_value=>"dance", :group=>5}),
    OpenStruct.new({:node_value=>"fun", :group=>4}),
    OpenStruct.new({:node_value=>"rules", :group=>5}),
    OpenStruct.new({:node_value=>"shelter", :group=>2}),
    OpenStruct.new({:node_value=>"savage", :group=>4}),
    OpenStruct.new({:node_value=>"assembly", :group=>4}),
    OpenStruct.new({:node_value=>"rescue", :group=>5}),
    OpenStruct.new({:node_value=>"conch", :group=>2}),
    OpenStruct.new({:node_value=>"stick", :group=>2}),
    OpenStruct.new({:node_value=>"paint", :group=>2})
  ],
  :links=>[OpenStruct.new({:source=>5, :target=>3, :value=>1})]
})

def addlink(w1,w2)
  struct = nil
  $data.links.each do |l|
    if (l.source == w1 && l.target == w2) || (l.source == w2 && l.target == w1)
      struct = l
      break
    end
  end
  if struct == nil
   $data.links << OpenStruct.new({:source=>w1, :target=>w2, :value=>1})  
  else
    struct.value += 1
  end
end

def addlinks(w,words)
  words.each do |i|
    addlink(w,i)
  end
end

def occs(words)
  total = 0
  box = []
  this_box = 0
  $text.each_line do |line|
    this_box += 1
    if this_box > $granularity # dump box
      box = []
      this_box = 0
    end
    l = line.downcase
    words.each_with_index do |w,wi|
      if l.index(w.node_value) != nil && !box.include?(wi)
        addlinks(wi,box)
        box << wi
      end
    end
  end
end
occs($data.nodes)
$data.links.select! {|l| l.value >= 2}
#puts $data.links