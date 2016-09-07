module Webcore
  module ApplicationHelper
########################
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

	    options[:class] = '' unless options[:class]
	    options[:class] += " btn btn-primary"
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

	  def add_link(title =nil, url=nil, options={})
	    if(!title)
	      title = 'Add '+ucthing
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
	      title = 'Edit '+ucthing
	    end

	    if(!url)
	      url = url_for(action: 'edit', id: thingData['id'])
	    end

	    options[:class] = '' unless options[:class]
	    options[:class] += " btn btn-warning"
	    #options.class += " btn btn-success"
	    # hmmm, need to allow for html in title...

	    glink_to("pencil",title.html_safe, url, options)
	  end

	  def view_link(title =nil, url=nil, options={})
	    if(!title)
	      title = 'View '+ucthing
	    end

	    if(!url)
	      url = url_for(action: 'show', id: thingData['id'])
	    end

	    options[:class] = '' unless options[:class]
	    options[:class] += " btn btn-primary"

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
	      title = 'Delete '+ucthing
	    end

	    title = g("trash") + " "+title

	    if(!url)
	    # XXX TODO figure out how works with method..
	      url = url_for( method: 'delete', action: 'destroy', id: thingData['id'])
	    end

	    options[:class] = '' unless options[:class]
	    options[:class] += " btn btn-danger"
	    #options.class += " btn btn-success"
	    # hmmm, need to allow for html in title...
	    options['confirm'] = "Are you sure you want to remove this "+thing+"?" unless (options['confirm'] || options['confirm'] === false)

	    button_to(url, options){ title.html_safe }
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

	  def ucthing
	    thing.split.map(&:capitalize).join(' ')
	  end

	  def ucthings
	    ucthing.pluralize
	  end

	  def span(className='')
	    "<span class='#{className}'></span>"
	  end

	  def fa(faw)
	    "<i class='fa fa-"+faw+"'></i>"
	  end

	  def g(glyph)
	    "<span class='glyphicon glyphicon-"+glyph+"'></span>"
	  end

######################
	end
end
