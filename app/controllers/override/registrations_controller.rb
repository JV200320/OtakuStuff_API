class Override::RegistrationsController < DeviseTokenAuth::RegistrationsController

  def create
    super do |resource|
      resource.attach_avatar(params['image'])
      resource.update(image: url_for(resource.avatar))
    end
  end
end