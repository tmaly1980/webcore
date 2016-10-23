require_dependency "webcore/webcore_controller"
module Webcore

class XXXUsersController < Webcore::WebcoreController

  def dump_session # Cant be named the same as 'session'
    respond_to do |format|
      format.html { render :text => session.id+session.to_hash.to_yaml }
    end
  end
end

end