module ApplicationHelper
  def capitalize_first_letter word
    word.slice(0, 1).capitalize + word.slice(1..-1)
  end

  def display_class_for div_name
    if div_name == :notice
      'alert alert-dismissable alert-success'
    elsif div_name == :error
      'alert alert-danger'
    else
      'alert alert-warning'
    end
  end

  def other_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
      #{sentence}
      <ul>#{messages}</ul>
    HTML

    content_tag :div, html.html_safe, class: display_class_for(:error)
  end
end
