module Webcore
  class WebcoreController < ApplicationController
    protect_from_forgery with: :exception
  end
end
