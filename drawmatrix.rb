require 'rubyvis'
load(File.dirname(__FILE__)+"/links_data.rb")
color=Rubyvis::Colors.category10


vis = Rubyvis::Panel.new() do 
  width 693
  height 693
  top 90
  left 90
  layout_matrix do
    nodes $data.nodes
    links $data.links
    sort {|a,b| b.group<=>a.group }
    directed (false)
    link.bar do
      fill_style do |l|
        lv = (l.link_value * 10) + 150
        #lv = lv - 50 if lv > 255
        hexnum = lv > 255 ? 255 : lv
        huenum = l.target_node.group == l.source_node.group ? 200 : 90
        
        col = Rubyvis.color("hsl(#{huenum},150,#{255-hexnum})")
        colhex = '#' + col.r.to_s(16).rjust(2,'0') + col.g.to_s(16).rjust(2,'0') + col.b.to_s(16).rjust(2,'0')
        
        invhex = (255 - hexnum).to_s(16)
        str = '#' + invhex + invhex + invhex
        colhex
      end
      antialias(false)
      line_width(1)
    end
    node_label.label do 
      text_style {|l| color[l.group]}
    end
  end
end
vis.render()
puts vis.to_svg