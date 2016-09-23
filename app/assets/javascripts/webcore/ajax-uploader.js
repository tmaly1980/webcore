(function($) {
	// handle ajax-based file uploads whose result content updates on page
	// just assign a url to data-upload
	// possibly a target for result in data-update or data-append
	// triggers callback upload.success, for custom processing


	$.fn.ajaxUploader = function(options) {
		var file = this;
		if(!$(file).attr('id'))
		{
			$(file).attr('id', 'file'+Math.floor((Math.random() * 10000) + 9999));
		}
		var file_id = $(file).attr('id');
		var url = options.upload;

		// Add progressbar and error box, if needed
		var container = $(file).parent();
		var progress = $(container).find(".progress");
		var messager = $(container).find(".alert");

		if(!progress.size())
		{
			progress = $("<div style='display: none;' class='progress'>"+
				"<div class='progress-bar progress-bar-success progress-bar-striped active width100p'> &nbsp; </div>"+
				"</div>"
				);
			$(container).prepend(progress);
		}
		if(!messager.size())
		{
			messager = $("<div style='display: none;' class='alert alert-danger'></div>");
			$(container).prepend(messager);
		}

		$(file).fileupload({
			url: url,
			dataType: 'json',
			type: 'POST',
			//singleFileUploads: false, // we need to call album.create once only
			add: function(e,data) {
				console.log("UPLOAD ADD");
				messager.html("").hide();
				progress.show();
				data.submit();
			},
			fail: function(e, data) {
				console.log("UPLOAD FAIL");
				messager.html('Upload failed. Please try again.').show();
				progress.hide();
			},
			done: function(e, data) {
				console.log("UPLOAD DONE");
				console.log(data.result);
				progress.hide();
				messager.html('').hide();
				if(data.result.error)
				{
					messager.html(data.result.error).show();
					$(file).trigger('upload.error', data.result);
				} else { // if error, abort everything else.
					console.log("OPTIONS=");
					console.log(options);
					console.log("HTML="+data.result.html);

					if(data.result.redirect)
					{
						window.location = data.result.redirect;
					} else if(data.result.html) {
						var update = null;
						if(update = options.update) //  Where JSON .html results go, if anywhere.
						{
							console.log("UPDATING "+update);
							$(update).html(data.result.html);
						} else if(update = options.append) { //  Where JSON .html results go, if anywhere.
							console.log("APPENDING "+update);
							$(update).append(data.result.html);
						}

						// If upload is inside a modal and target is outside, close the modal.
						var modal = $(file).closest('.modal');
						if(update && modal.size() && !$(update).closest('.modal').size())
						{
							modal.dialogclose();
						}
					}
					$(file).trigger('upload.success', data.result);		
				}
			}
		});
	};

	$(document).ready(function() { // auto-bind to files with data-upload set
		$('input[type=file][data-upload]').each(function() {
			var options = $(this).data(); // pass via data- bindings
			console.log("OPTS=");
			console.log(options);
			$(this).ajaxUploader(options);
		});

	});

})(jQuery);