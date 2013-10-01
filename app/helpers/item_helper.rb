module ItemHelper
  def display_class_for div_name
    if div_name == :notice
      'alert alert-dismissable alert-success'
    elsif div_name == :error
      'alert alert-danger'
    end
  end
end
