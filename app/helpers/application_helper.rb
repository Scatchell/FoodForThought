module ApplicationHelper
  def capitalize_first_letter word
    word.slice(0,1).capitalize + word.slice(1..-1)
  end
end
