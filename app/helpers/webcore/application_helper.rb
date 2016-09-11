module Webcore
  module ApplicationHelper

	#################################
	# View Helpers
	def display_date(field)
		content_tag(:p, field.mond, class: 'date') # Standardize format with CSS
	end

	def validation_errors
		return [] unless thingData && thingData.errors.any?
		thingData.errors.full_messages
	end

	def title_field(f, name='title', options={})
		options[:class] = '' unless options[:class]
		options[:class] += ' input-lg'
		options[:hide_label] = true
		options[:placeholder] = ucthing+' Title' unless options[:placeholder]

		f.text_field(name,options)
	end

	def summary_field(f, name='summary', options={})
		options[:rows] = 6 unless options[:rows]
		options[:placeholder] = ucfirstthing+' summary... (optional)'
		options[:class] ||= 'bold double'
		options[:hide_label] ||= true
		options["data-maxlength"] = 250

		f.text_area name, options
	end

	def content_field(f, name='content', options={})
		#options[:class] = '' unless options[:class]
		# XXX TODO rich text editor
		#options[:rows] = 25 unless options[:rows]
		options[:hide_label] = true
		options[:class] = options[:class].to_s + " redactor"

		f.text_area(name,options)
	end

	def save_button(f)
		f.submit class: 'btn btn-success'
	end

	  def get_crumbs()
	  	return if !@crumbs
	    items = @crumbs.stringify_keys.map do |title,url|
	        atag = url ? content_tag(:a, title, {href: url}) : title
	        content_tag(:li, atag.html_safe, class: (!url ? "active":"")) 
	    end
	    content_tag(:ul, items.join("\n").html_safe, class: 'breadcrumb')
	  end

	  def crumbs(tree={})
	    @crumbs = tree
	  end

	  def settings_link(title =nil, url=nil, options={})
	    if(!title)
	      title = 'Settings'
	    end

	    if(!url)
	      url = url_for(action: 'edit')
	    end

	    options[:class] = options[:class].to_s + " btn btn-primary"
	    #options.class += " btn btn-success"
	    # hmmm, need to allow for html in title...
	    
	    glink_to("cog",title, url, options)
	  end

	  def glink_to(glyph, title=nil,url=nil,opts={})
	    icon = (glyph.starts_with?"fa-") ? fa(glyph) : g(glyph)
	    if(opts.is_a? String)
	      opts = {class: opts}
	    end
	    link_to((icon+" "+title).html_safe,url,opts)
	  end

	  def back_link(title, url, options={})

	    options[:class] = '' unless options[:class]
	    options[:class] += " btn btn-default"
	    
	    glink_to("chevron-left",title, url, options)
	  end

	  def add_link(title =nil, url=nil, options={})
	    if(!title)
	      title = 'Add'# '+ucthing
	    end

	    if(!url)
	      # XXX
	      url = url_for(action: 'new')
	    end

	    options[:class] = '' unless options[:class]
	    options[:class] += " btn btn-success"
	    #options.class += " btn btn-success"
	    # hmmm, need to allow for html in title...
	    

	    glink_to("plus",title, url, options)
	  end

	  def edit_link(title =nil, url=nil, options={})
	    if(!title)
	      title = 'Edit'# '+ucthing
	    end

	    if(!url)
	      url = url_for(action: 'edit', id: thingData['id'])
	    end

	    options[:class] = options[:class].to_s + " btn btn-warning"
	    #options.class += " btn btn-success"
	    # hmmm, need to allow for html in title...

	    glink_to("pencil",title.html_safe, url, options)
	  end

	  def view_link(title =nil, url=nil, options={})
	    if(!title)
	      title = 'View'# '+ucthing
	    end

	    if(!url)
	      url = url_for(action: 'show', id: thingData['id'])
	    end

	    options[:class] = options[:class].to_s + " btn btn-default"

	    glink_to("file",title, url, options)
	  end

	  def index_link(title =nil, url=nil, options={})
	    if(!title)
	      title = 'All '+ucthings
	    end

	    if(!url)
	      url = url_for(action: 'index')
	    end

	    options[:class] = '' unless options[:class]
	    options[:class] += " btn btn-primary"
	    #options.class += " btn btn-success"
	    # hmmm, need to allow for html in title...

	    glink_to("chevron-left",title, url, options)
	  end

	  def delete_link(title =nil, url=nil, options={})
	    if(!title)
	      title = 'Delete'# '+ucthing
	    end

	    title = g("trash") + " "+title

	    if(!url)
	    # XXX TODO figure out how works with method..
	      url = { :action => 'destroy', :id => thingData['id'] }
	    end

	    # Uses a mini-form. Form needs to be inline and confirm needs to halt if cancel.
	    button_to(url, :method => 'delete', class: 'btn btn-danger', 
	    	data: { confirm: "Are you sure you want to remove this "+thing+"?" },
	    	form_class: 'inline button_to'){ title.html_safe }
	  end

	  # Remove escaping.
	      def Xlink_to(name = nil, options = nil, html_options = nil, &block)
	        html_options, options, name = options, name, block if block_given?
	        options ||= {}

	        html_options = convert_options_to_data_attributes(options, html_options)

	        url = url_for(options)
	        html_options["href".freeze] ||= url

	        content_tag("a".freeze, name || url, html_options, false, &block)
	      end


		def layout(layout = nil, ext = [:html])
			if(layout)
				controller.class.send(:layout, layout)
			else
	    		layout = controller.send(:_layout, ext)
	    		if layout.instance_of? String
	      			layout
	    		else
	      			File.basename(layout.identifier).split('.').first
	    		end
	    	end
	  	end

	  def is_admin?
	      true # FOR NOW XXX
	   end

	  def thingVar
	  # NewsPost => news_post
	    controller.model_name.underscore
	  end

	  def thingData
	    instance_variable_get("@"+thingVar)
	  end

	  def thing
	    controller.model_name.underscore.humanize.downcase
	  end

	  def ucfirstthing
	  	thing.capitalize
	  end

	  def ucthing
	    thing.split.map(&:capitalize).join(' ')
	  end

	  def ucthings
	    ucthing.pluralize
	  end

	  def span(className='')
	    ("<span class='#{className}'></span>").html_safe
	  end

	  def fa(faw)
	    ("<i class='fa fa-"+faw+"'></i>").html_safe
	  end

	  def g(glyph)
	    ("<span class='glyphicon glyphicon-"+glyph+"'></span>").html_safe
	  end

#################################
	end
end
