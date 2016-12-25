module BrowserHelper
  def link_to_send_move(san)
    raw ("<a href=\"#\" onclick=\"controller.sendMove('#{san}'); return false;\">#{san}<a>")
  end
end
