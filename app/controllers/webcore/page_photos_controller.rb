require_dependency "webcore/webcore_controller"
module Webcore

class PagePhotosController < Webcore::WebcoreController

  def new #  Show upload form
    layout 'ajax'
    @page_photo = Webcore::PagePhoto.new
  end

  def create # Process upload
    logger.debug("file PARAMS=")
    logger.debug(params)
    @page_photo = Webcore::PagePhoto.new(photo: params[:file]);
    
    error = @page_photo.save ? nil : "Could not upload file: "+@page_photo.errors.join("<br/>")

    # realistically, we need to spend back html snippets via json
    respond_to do |format|
      format.html
      format.json { 
          render :json => {
            error: error,
            html: (!error ? render_to_string(partial: "edit.html.erb", locals: { page_photo: @page_photo }) : nil)
          }
        }
    end

  end

  def caption # Add/update caption for photo 
    @page_photo = Webcore::PagePhoto.find(params[:id])
    @page_photo.updateAttribute(:caption => params[:caption]) if params[:caption]
    respond_with @page_photo
  end
end

end