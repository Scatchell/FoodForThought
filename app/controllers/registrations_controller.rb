class RegistrationsController < Devise::RegistrationsController
  def update_resource(resource, params)
    puts 'over-ridden registrations controller'
    resource.update_without_password(params)
  end


  def method_missing(method_name, *args, &block)
    super.send(method_name)
  end
end