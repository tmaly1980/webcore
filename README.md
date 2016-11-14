# Webcore
Provides basic common view/template helpers across web applications and convenience modifications (monkey patching) to SimpleForm.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'webcore', :git => 'git://github.com/tmaly1980/webcore.git'
```

And then execute:
```bash
$ bundle
```

Simple mount the gem as an engine, and it'll automatically include it's helper, load dependencies, etc:

In your app's config/routes.rb:

```  
mount Webcore::Engine, at: "/webcore" 
```

In your app/controllers/application_controller.rb:

```
  helper Webcore::ApplicationHelper
```

## Usage

In your views, access these helpers:

### Bootstrap-style alert boxes:

Info-style:
```
<%= info(text) %>
```

Success:
```
<%= success(text) %>
```

Warning:
```
<%= warning(text) %>
```

Danger:
```
<%= danger(text) %>
```

### Date formatting helpers for strftime:

"Jun 13"
```
post.created_at.strftime(format_mond) 
```

"10/15/81"
```
post.created_at.strftime(format_mdy) 
```

"10/15/1981"
```
post.created_at.strftime(format_mdyear) 
```

Calculate age, show months if less than a year
``` 
age(dob) 
```

Calculate age, show "Unknown age" if nil
``` 
age!(dob) 
```

### Common options for dropdowns (using SimpleForm):

No, Yes (as boolean)
``` 
f.input(:field_name, collection: yesnobool) 
```

No, Yes (as string)
``` 
f.input(:field_name, collection: yesno) 
```

Blank ( - ), No, Yes
``` 
f.input(:field_name, collection: yesnoblank) 
```

Generate list of months in format of "01 - January":
``` 
f.input(:month, collection: months) 
```

Generate list of US states
``` 
f.input(:state, collection: states) 
```


### Various helpers:

Convert array list to key-value hash for select dropdowns, ie ['Dogs','Cags'] => { "Dogs" => "Dogs", "Cats" => "Cats" }
``` 
array_to_hash(array) 
```

Show a bootstrap-style progress bar:
``` 
<%= progress("Text", percent, id, hide) %> 
```

Generate browser head title, based on @browser_title, @page_title or @currentSite.title
``` 
<%= browser_title %>
```

Generate bootstrap-style breadcrumbs bar, based on stack in @crumbs

Set:
``` 
@crumbs = { "Home"=>"/", "All Adoptables"=>"/adoptables", @adoptable.name =>nil } 
```
Display:
``` 
<%= get_crumbs() %> 
```

Outputs:
``` 
<ul class='breadcrumb'>
	<li><a href='/'>Home</a></li>
	<li><a href='/adoptables'>All Adoptables</a></li>
	<li>Name</li>
</ul>
```

### Various style buttons (bootstrap, with glyphicon):

Settings (blue button with cog, url defaults to 'edit' action):
``` 
<%= settings_link(title, url, options) %> 
```

Link with glyphicon (bootstrap or font-awesome if prefixed with fa-), optional text:
``` 
glink_to(glyph, title=nil, url=nil, [opts]) 
```

Bootstrap-style button with glyphicon:
``` 
gblink_to(glyph, title=nil, url=nil, [opts]) 
```

Bootstrap-style button:
``` 
blink_to(title=nil, url=nil, opts, button_class='primary') 
```

Add button (green success button, with plus icon, defaults to 'new' action):
``` 
add_link(title=nil,url=nil,[options]) 
```

Edit button (orange warning, pen icon, defaults to 'edit' action):
``` 
edit_link(title='Edit',url,[options]) 
```

View button (default/white, page icon, defaults to 'view' action):
``` 
view_link(title='View', url, options) 
```

Delete button (danger, trash icon, hidden form post with delete method)
``` 
delete_link(title='Delete',url, options) 
```

User logout button (posts to /users/logout by default):
``` 
logout(title='Logout', url=nil, options) 
```

### Convenience generic accessors to name of current object and data (if show/edit) - for our buttons/etc

For NewsPost object/controller:

news_post:
``` 
thingVar 
```

@news_post:
``` 
thingData 
```

news post:
``` 
thing 
```

News post:
``` 
ucfirstthing 
```

News Post:
``` 
ucthing 
```

News Posts:
``` 
ucthings 
```

### Glyph icons:

Font awesome icons:
``` 
fa('user') 
```
Produces:
``` 
<i class='fa fa-user'></i> 
```

Bootstrap glyphicon:
``` 
g('cog') 
```
Produces:
``` 
<span class='glyphicon glyphicon-cog'></span> 
```

## SimpleForm modifications (monkey-patched)

Assumes context:
``` 
<%= simple_form_for(object) do |f| %> 
```

Bootstrap-style title field (no label, placeholder only, large text):
``` 
f.title(:field_name, options) 
```

Summary textarea (varchar, bold and double spaced)
``` 
f.summary(field='summary',options) 
```

WYSIWYG editor content (redactor)
``` 
f.content(field='content',options) 
```

Save button (bootstrap style, success style):
``` 
f.save(text='Save') 
```

Success button (bootstrap/green)
``` 
f.success(text='Submit', options) 
```

Blue/primary button:
``` 
f.primary(text='Submit',options) 
```

Info (light blue) button:
``` 
f.info(text='Submit',options) 
```

Warning (orange) button:
``` 
f.warning(text='Submit',options) 
```

Danger (red) button (ie for delete):
``` 
f.danger(text='Submit', options) 
```

Implement a bootstrap style form group with text/icon before and/oror after input field:
``` 
f.form_group(:hostname, :before => 'http://', :after => ".subdomain.com") 
```

### Monkey patching of SimpleForm::input, additional syntax:

Set wrapper div class/attributes (instead of setting deeper 'wrapper_html'):
``` 
f.input(:field, :div => "col-md-6") 
```
``` 
f.input(:field, :div => { class: "col-md-6", id: 'fieldContainer' }) 
```



## Contributing
Feel free to contribute!

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
