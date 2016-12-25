module ApplicationHelper
  # note: this used to have several page links, but I'm only keeping the demo here
  @@nav_links = %w{demo}
  @@nav_names = ["Chess Demo"]
  @@nav_hash = Hash[@@nav_links.zip @@nav_names]
  def navbar(current)
    result = '<ul class="nav navbar-nav">'
    @@nav_links.each_index do |x|
      if @@nav_links[x] == current
        result += "<li class=\"active\"><a href=\"#\">#{@@nav_names[x]}</a></li>"
      else
        result += "<li><a href=\"#{@@nav_links[x]}\">#{@@nav_names[x]}</a></li>"
      end
    end
    result += '</ul>'
    return raw(result)
  end
  def title(current)
    return current ? "Steve Ortiz: #{@@nav_hash[current]}" : "Steve Ortiz"
  end
end
