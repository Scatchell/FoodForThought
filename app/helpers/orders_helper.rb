module OrdersHelper

  def bold_pluses string
    (string.gsub /\+/, '<strong style="font-size: 1.2em;">+</strong>').html_safe
  end

  def capitalize_first_letter word
    word.slice(0,1).capitalize + word.slice(1..-1)
  end
end
