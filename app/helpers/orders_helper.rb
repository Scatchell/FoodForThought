module OrdersHelper

  def bold_pluses string
    (string.gsub /\+/, '<strong style="font-size: 1.2em;">+</strong>').html_safe
  end
end
