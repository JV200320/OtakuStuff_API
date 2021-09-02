class Override::RegistrationsController < DeviseTokenAuth::RegistrationsController

  def create
    super do |resource|
      resource.attach_avatar(params['image'])
      url = url_for(resource.avatar) if resource.avatar.attached?
      resource.update(image: url)
    end
  end
end