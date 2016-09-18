(function($) {
	$(document).delegate('*[data-toggle="lightbox"]', 'click', function(e) {
		e.preventDefault();
		$(this).ekkoLightbox({
			type: 'image',
			onContentLoaded: function() { // Fit image height to less than window
				console.log("LOADED INTENRAL");
				

				var container = $('.ekko-lightbox-container');
		        var image = container.find('img');
		        var windowHeight = $(window).height();
		        if(image.height() + 200 > windowHeight) {
		           image.css('height', windowHeight - 150);
		           var dialog = container.parents('.modal-dialog');
		           var padding = parseInt(dialog.find('.modal-body').css('padding'));
		           dialog.css('max-width', image.width() + padding * 2 + 2);
		        }
		        console.log(this.$element);

		        this.$element.trigger('onContentLoaded', this); // allow other custom behaviors...
			}

		});
	});
})(jQuery);