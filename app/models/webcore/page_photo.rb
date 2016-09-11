require_dependency "webcore/webcore_record"
module Webcore
	class PagePhoto < Webcore::WebcoreRecord
		has_attached_file :photo, styles: {large: "800x500>", medium: "400x250>", thumb: "160x100>"}, default_url: "/images/:style/missing.png"
		validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
		validates :photo, attachment_presence: true
	end
end
