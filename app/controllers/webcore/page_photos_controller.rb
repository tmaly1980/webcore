require_dependency "webcore/webcore_controller"
module Webcore

class PagePhotosController < Webcore::WebcoreController
  def reprocess
    Webcore::PagePhoto.find_each { |p| p.photo.reprocess! }
    redirect_to root_path, notice: 'Success recompiling page photo thumbs'
  end

  def edit
    @page_photo = Webcore::PagePhoto.find(params[:id])
    render :layout => !request.xhr? # No layout, AJAX html returned (modal)
  end

  def new #  Show upload form
    @page_photo = Webcore::PagePhoto.new
    render :layout => !request.xhr? # No layout, AJAX html returned (modal)
  end

  def update
    @page_photo = Webcore::PagePhoto.find(params[:id])
    process_upload
  end

  def create # Process upload
    @page_photo = Webcore::PagePhoto.new(permit_params)
    process_upload
  end

  def permit_params
    params.require(:page_photo).permit(:photo) # if ever multiple, needs :photo => []
  end

  def process_upload
    @page_photo.photo = params[:page_photo][:photo] # Weird hack, don't know why. validators somewhere remove?
    # this might need some tweaking so updates go thru permitted

    error = @page_photo.save() ? nil : "Could not upload file: "+@page_photo.errors.full_messages.join(". ")
    logger.debug("POSTSAVE")

    # realistically, we need to spend back html snippets via json
    respond_to do |format|
    format.html { 
      if error
        flash[:alert] = error
        render 'new' 
      else
        redirect_to page_photos_path 
      end
    }
      format.json { 
          render :json => {
            error: error,
            html: (!error ? render_to_string(partial: "edit_thumbs.html.erb", locals: { page_photo: @page_photo }) : nil)
          }
        }
    end

  end

  def caption # Add/update caption for photo 
    @page_photo = Webcore::PagePhoto.find(params[:id])
    @page_photo.updateAttribute(:caption => params[:caption]) if params[:caption]
    respond_with @page_photo
  end

  def destroy
    # HOPEFULLY rails sees the _method = delete and knows what to do
    @page_photo = Webcore::PagePhoto.find(params[:id])
    @page_photo.destroy

    # caller uses ajax and updates #PagePhoto
    respond_to do |format|
      format.html { render partial: "edit.html.erb", locals: { page_photo: nil } }
      format.json { 
        render :json => {
          html: render_to_string(partial: "edit.html.erb", locals: { page_photo: nil } )
        }
      }
    end
  end
end

end