module ApplicationHelper
  def title
    base_title = 'Collablearn'
    if @title.nil?
      base_title
    else
      "#{@title} - #{base_title}"
    end
  end

  # This is for using devise in other forms
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end