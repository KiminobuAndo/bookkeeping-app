# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  private

  def after_sign_in_path_for(resource)
    root_path
  end
end
