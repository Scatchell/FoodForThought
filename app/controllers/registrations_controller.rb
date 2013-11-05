class RegistrationsController < Devise::RegistrationsController
  def update_resource(resource, params)
    puts 'over-ridden registrations controller'
    resource.update_without_password(params)
    #todo respond to js format with empty page so it doesn't try to render something and display an ajax error
  end


  def method_missing(method_name, *args, &block)
    super.send(method_name)
  end
end