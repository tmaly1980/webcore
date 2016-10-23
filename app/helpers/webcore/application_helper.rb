module Webcore
  module ApplicationHelper

	#################################
	# View Helpers
	def upload_button(f, label, field, params)
		("<label class='btn btn-success btn-file'>"+label+ f.file_field_without_bootstrap(field, params).html_safe+"</label>").html_safe
	end

	def alertbox(text,className='info')
		("<div class='margin10 alert alert-"+className+"'>"+text+"</div>").html_safe
	end

	def info(text)
		alertbox(text,'info')
	end
	def success(text)
		alertbox(text,'success')
	end
	def danger(text)
		alertbox(text,'danger')
	end
	def warning(text)
		alertbox(text,'warning')
	end

	def spanify(text) # only if content exists
		return '' if text.blank?
		("<span>"+text+"</span>").html_safe
	end

	def nl2br(content)
		content.gsub(/(?:\n\r?|\r\n?)/, '<br/>')
	end

	##################
	# Date formatting - user.created_at.strftime(format_mond)
	def format_mond
		"%b %-d" # Jun 13
	end
	def format_mdy
		"%m/%d/%y" # 10/24/80
	end
	def format_mdyear
		"%m/%d/%Y" # 10/24/1980
	end


	def years(dob)
		years = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
	end

	def age!(dob)
		adoptable_age = age(dob)
		if(!adoptable_age)
			'Unknown age'
		else
			adoptable_age
		end
	end

	def age(dob) # Shows months if less than a year
	  return nil if dob.blank?
	  now = Time.now.utc.to_date

	  years_months = date_diff(dob,now)
	  years = years_months[0]
	  months = years_months[1]

	  if(years == 1)
	  	return years + " year old"
	  elsif(years > 1)
	  	return years + " years old"
	  elsif (months == 1)
	  	return months + " month old"
	  elsif (months > 1)
	  	return months + " months old"
	  else
	  	return "< 1 month old"
	  end
	end

	def date_diff(date1,date2)
  		month = (date2.year * 12 + date2.month) - (date1.year * 12 + date1.month)
  		month.divmod(12)
	end

	def array_to_hash(array) # Takes plain list and turns into both keys and values (as-is), for dropdowns
		Hash[ array.map { |k| [k,k] } ]
	end

	def yesnobool
		['No','Yes']
	end
	def yesno
		{'No'=> 'No','Yes'=>'Yes'}
	end
	def yesnoblank
		{'': ' - ', 'No'=>'No','Yes'=>'Yes'}
	end
	def yesnona
		{'': '- N/A -', 'No'=>'No','Yes'=>'Yes'}
	end

	#############
	def page_photo_edit(f,data=nil) # Caller STILL needs to define #PagePhotoId as hidden object, for update
		data = thingData unless data;
		render partial: 'webcore/page_photos/edit_wrapper', locals: { form: f, page_photo: data.try(:page_photo) }
	end

	def page_photo_view(data=nil)
		data = thingData unless data;
		render partial: 'webcore/page_photos/view', locals: { page_photo: data.try(:page_photo) }
	end

	def display_date(field)
		content_tag(:p, field.mond, class: 'date') # Standardize format with CSS
	end

	def validation_errors
		return [] unless thingData && thingData.errors.any?
		thingData.errors.full_messages
	end

	def progress(text="&nbsp;",percent=100,id='progress',hidden=true)
		("<div id='"+id+"' "+(hidden ? " style='display:none;'":"")+ " class='progress'>"+
			"<div class='progress-bar progress-bar-success progress-bar-striped active' style='width: "+percent.to_s+"%;'> "+
			text+" </div>"+
		"</div>").html_safe
	end

	def merge_options(options={}, adding)
		SimpleForm::FormBuilder::merge_options(options,adding)
	end

	#ActionView::Helpers::FormBuilder.class_eval do
	SimpleForm::FormBuilder.class_eval do
	# HELL YEAH, love rails

	  def thing # OWN COPY
	    #controller.model_name.underscore.humanize.downcase
	    object_name.humanize.downcase
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

		def merge_options(options={}, adding) # Handles appending to class, etc
	        if adding
	          adding.merge(options) do |key, oldval, newval|
	            case key.to_s
	            when "class"
	              Array(oldval) + Array(newval)
	            when "data", "aria"
	              oldval.merge(newval)
	            else
	              newval
	            end
	          end
	        else
	          options
	        end
		end
		

		def title(field='title',options={})
			#return name

			options[:class] = '' unless options[:class]
			options[:class] += ' input-lg'
			options[:label] = false
			options[:required] = 'required'
			options[:placeholder] = ucthing+' Title' unless options[:placeholder]

			self.field(field,options)
		end

		def summary(field='summary',options={})
			options[:rows] = 6 unless options[:rows]
			options[:placeholder] = ucfirstthing+' summary... (optional)'
			options[:class] ||= 'bold double'
			options[:label] = false
			options["data-maxlength"] = 250

			self.field field, options
		end

		def content(field='content',options={})
			#options[:class] = '' unless options[:class]
			# XXX TODO rich text editor
			#options[:rows] = 25 unless options[:rows]
			options[:label] = false
			options[:class] = options[:class].to_s + " editor"
			script = content_tag(:script, ("$(document).ready(function() { $('.editor').redactor(); })").html_safe)
			self.field(field,options)+script # using 'redactor' tag is inconsistent, sometimes doesnt load...
		end


		def save(text = nil, options={})
			self.success text, options
		end
		def success(text = nil, options={})
			options = merge_options(options, { class: 'btn btn-success'} )
			self.submit_cancel text, options
		end
		def primary(text = nil, options={})
			options = merge_options(options, { class: 'btn btn-primary'} )
			self.submit_cancel text, options
		end
		def info(text = nil, options={})
			options = merge_options(options, { class: 'btn btn-info'} )
			self.submit_cancel text, options
		end
		def warning(text = nil, options={})
			options = merge_options(options, { class: 'btn btn-warning'} )
			self.submit_cancel text, options
		end
		def danger(text = nil, options={})
			options =merge_options(options, { class: 'btn btn-danger'} )
			self.submit_cancel text, options
		end

		def submit_cancel(*args, &block)
			template.content_tag :div, :class => "form-group padding10" do
				options = args.extract_options!

				# class
				options[:class] = [options[:class], 'btn-primary'].compact

				args << options

				# with cancel link
				if cancel = options.delete(:cancel)
					submit(*args, &block) + '&nbsp;&nbsp;'.html_safe + template.link_to('Cancel', cancel, class: 'text-danger')
				else
					submit(*args, &block)
				end
			end
		end

		def datepicker(field, options = {})
			options[:as] = 'string'
			options[:class] = 'datepicker'
			options[:size] = 12

			self.field(field,options)
		end

		def form_group(field, options = {})
			options[:wrapper] = :vertical_input_group
			input_options = options.reject{ |k| [:wrapper, :before, :after, :div].include? k }
			input_options[:class] = '' unless input_options[:class]
			input_options[:class] += ' form-control'

			self.field field, options do
				str = ''
				if options[:before]
	      			str << "<span class='input-group-addon'>"+options[:before]+"</span>"
				end

				str << self.input_field(field, input_options)
				
				if options[:after]
	      			str << "<span class='input-group-addon'>"+options[:after]+"</span>"
				end
				str.html_safe
		    end
		end

		# ***** use f.field INSTEAD of f.input *****
		# Wrapper for input fields, supporting 'div' to style class and 'class' to style inputs
		def field(field, options = {}, &block) 
			options[:input_html] = {} unless options[:input_html]
			options[:prompt] = false unless options[:prompt].present? # default to no empty field.
			
			[:id, :size, :maxlength, :class].each do |k| # Map attributes
				if options[k]
					options[:input_html][k] = options[k]
					options.delete(k)
				end
			end

			if options[:div] === false
				options[:wrapper] = false
			elsif options[:div]
				if options[:div].instance_of? Hash
					options[:wrapper_html] = options[:div]
				else
					options[:wrapper_html] = {} unless options.try(:wrapper_html)
					options[:wrapper_html][:class] = options[:div]
				end
				options.delete(:div)
			end

			self.input(field,options, &block) 
		end
	end

	# def input_group(f,field, options={})
	# 	f.input :hostname, wrapper: :vertical_input_group, options do 
	# 		(options.before ? "<span class='input-group-addon'>"+options.before+"</span>":"") + 
	#         f.input_field fie, class: "form-control right_align", required: true %>
			
	# 	end
 #      <span class="input-group-addon">.<%= @default_domain %></span>
    	
	# end

	def share(title)
		("<div class='pull-left paddingright10'>"+
			social_share_button_tag(title)+
		"</div>").html_safe
	end

	def browser_title
      title_parts = []
      if @browser_title
      	title_parts.push @browser_title
      elsif @page_title
      	title_parts.push @page_title
      end
      if(@currentSite.try(:title))
      	title_parts.push(@currentSite.title)
      end
      title_parts.join(" | ")
  	end

	  def get_crumbs() # either call crumbs(hash) or set @crumbs
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

	  def gblink_to(glyph, title=nil,url=nil,opts={},btnclass='primary')
	    opts[:class] = '' unless opts[:class]
	    opts[:class] += " btn btn-"+btnclass

	  	glink_to(glyph, title,url,opts)
	  end	  

	  def blink_to(title=nil,url=nil,opts={},btnclass='primary')
	    opts[:class] = '' unless opts[:class]
	    opts[:class] += " btn btn-"+btnclass

	  	link_to(title,url,opts)
	  end

	  def back_link(title='Back', url=nil, options={})

	    options[:class] = '' unless options[:class]
	    options[:class] += " btn btn-default"
	    url = { action: 'index' } unless url
	    
	    glink_to("chevron-left",title, url, options)
	  end

	  def add_link!(title=nil,url=nil,options={})
	  	if(!title)
	  		title = 'Add '+ucthing;
	  	end
	  	add_link(title,url,options)
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

  	  def edit_link!(title=nil,url=nil,options={})
	  	if(!title)
	  		title = 'Edit '+ucthing;
	  	end
	  	edit_link(title,url,options)
	  end

	  def edit_link(title =nil, url=nil, options={})
	    if(!title)
	      title = 'Edit'# '+ucthing
	    end

	    if(!url)
	      url = url_for(action: 'edit', id: thingData['id'])
	    end

	    options[:class] = "btn btn-warning"  unless options[:class]
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

	    options[:class] = " btn btn-default" unless options[:class]

	    glink_to("file",title, url, options)
	  end

	  def index_link(title =nil, url=nil, options={})
	    if(!title)
	      title = 'All '+ucthings
	    end

	    if(!url)
	      url = url_for(action: 'index')
	    end

	    options[:class] = "btn btn-default" unless options[:class]

	    glink_to("chevron-left",title, url, options)
	  end

	  def delete_link!(title=nil,url=nil,options={})
	  	if(!title)
	  		title = 'Delete '+ucthing;
	  	end
	  	delete_link(title,url,options)
	  end

	  def logout(title='Logout',url=nil, options={})
		    options[:method] = 'delete' # Gets working properly
		    url = "/users/logout" unless url
		    link_to(title.html_safe, url, options)
	  end


	  def delete_link(title =nil, url=nil, options={})
	    if(!title)
	      title = 'Delete'# '+ucthing
	    end

	    title = g("trash") + " "+title

	    if(!url)
	      url = thingData
	    end

	    options[:title] = "Delete "+thing
	    options[:class] = ' btn btn-danger' unless options[:class] 
	    options[:method] = 'delete' # Gets working properly
		options[:confirm] = "Are you sure you want to remove this "+thing+"?"
	    
	    link_to(title.html_safe, url, options)
	    #	form_class: 'inline button_to'){ title.html_safe }
	    #
	    # Uses a mini-form. Form needs to be inline and confirm needs to halt if cancel.
	    #button_to(url, :method => 'delete', class: options[:class],
	    #	data: { confirm: "Are you sure you want to remove this "+thing+"?" },
	    #	form_class: 'inline button_to'){ title.html_safe }
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

	  def max_width(id,width)
	  	("<style>#"+id.to_s+" { max-width: "+width.to_s+"px; }</style>").html_safe
	  end



#################################
	def months
		[
		'01'=>'01 - January',
		'02'=>'02 - February',
		'03'=>'03 - March',
		'04'=>'04 - April',
		'05'=>'05 - May',
		'06'=>'06 - June',
		'07'=>'07 - July',
		'08'=>'08 - August',
		'09'=>'09 - September',
		'10'=>'10 - October',
		'11'=>'11 - November',
		'12'=>'12 - December',
		]
	end
	def states
		[
	    'AL'=>'Alabama',
	    'AK'=>'Alaska',
	    'AZ'=>'Arizona',
	    'AR'=>'Arkansas',
	    'CA'=>'California',
	    'CO'=>'Colorado',
	    'CT'=>'Connecticut',
	    'DE'=>'Delaware',
	    'DC'=>'District of Columbia',
	    'FL'=>'Florida',
	    'GA'=>'Georgia',
	    'HI'=>'Hawaii',
	    'ID'=>'Idaho',
	    'IL'=>'Illinois',
	    'IN'=>'Indiana',
	    'IA'=>'Iowa',
	    'KS'=>'Kansas',
	    'KY'=>'Kentucky',
	    'LA'=>'Louisiana',
	    'ME'=>'Maine',
	    'MD'=>'Maryland',
	    'MA'=>'Massachusetts',
	    'MI'=>'Michigan',
	    'MN'=>'Minnesota',
	    'MS'=>'Mississippi',
	    'MO'=>'Missouri',
	    'MT'=>'Montana',
	    'NE'=>'Nebraska',
	    'NV'=>'Nevada',
	    'NH'=>'New Hampshire',
	    'NJ'=>'New Jersey',
	    'NM'=>'New Mexico',
	    'NY'=>'New York',
	    'NC'=>'North Carolina',
	    'ND'=>'North Dakota',
	    'OH'=>'Ohio',
	    'OK'=>'Oklahoma',
	    'OR'=>'Oregon',
	    'PA'=>'Pennsylvania',
	    'RI'=>'Rhode Island',
	    'SC'=>'South Carolina',
	    'SD'=>'South Dakota',
	    'TN'=>'Tennessee',
	    'TX'=>'Texas',
	    'UT'=>'Utah',
	    'VT'=>'Vermont',
	    'VA'=>'Virginia',
	    'WA'=>'Washington',
	    'WV'=>'West Virginia',
	    'WI'=>'Wisconsin',
	    'WY'=>'Wyoming',
		]
	end

#################################
	end
end
