module ApplicationHelper
  @@nav_links = %w{sample demo navair business}
  @@nav_names = ["Sample Work", "Chess Demo", "NAVAIR", "Business Solutions"]
  @@nav_hash = Hash[@@nav_links.zip @@nav_names]
  def navbar(current)
    result = '<ul class="nav navbar-nav">'
    @@nav_links.each_index do |x|
      if @@nav_links[x] == current
        result+= '<li class="active">'
      else
        result+= '<li>'
      end
      result += "<a href=\"#{@@nav_links[x]}\">#{@@nav_names[x]}</a></li>"
    end
    result += '</ul>'
    return raw(result)
  end
  def title(current)
    return current ? "Steve Ortiz: #{@@nav_hash[current]}" : "Steve Ortiz"
  end
end
