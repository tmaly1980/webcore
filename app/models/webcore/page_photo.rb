require_dependency "webcore/webcore_record"
module Webcore
	class PagePhoto < Webcore::WebcoreRecord
		has_attached_file :photo, styles: {medium: "250x250>", thumb: "100x100>"}, default_url: "/images/:style/missing.png"
		validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
	end
end
