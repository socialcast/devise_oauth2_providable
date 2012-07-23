class ProtectedController < ApplicationController
  before_filter :authenticate_user!
  def index
    render :nothing => true, :status => :ok
  end
end
