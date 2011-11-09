require 'rubyvis'
load(File.dirname(__FILE__)+"/links_data.rb")
c=Rubyvis::Colors.category19()

vis = Rubyvis::Panel.new() do 
  width 900
  height 410
  bottom 90
  layout_arc do
    nodes $data.nodes
    links $data.links
    sort {|a,b| a.group==b.group ? b.link_degree<=>a.link_degree : b.group <=>a.group}

    link.line
    
    node.dot do
      shape_size {|d| d.link_degree + 4}
      fill_style {|d| c[d.group]}
      stroke_style {|d| c[d.group].darker()}
    end
    
    node_label.label
  end
end
vis.render();
puts vis.to_svg