# DynamicSearch
DynamicSearch provides support for multi term searches to your rails models. At the
moment, I would recommend using at least rails 4.2 or higher for security reasons.

## Installation
Add this line to your application's Gemfile:  

```ruby
gem 'dynamic_search'
```

And then execute:  
```bash
bundle
```

Or install it yourself as:  
```bash
gem install dynamic_search
```

## Usage
1. Include the module to any model you want DynamicSearch functionality.
```ruby
include DynamicSearch
```

2. To use the search you can create a search box form in your view.  
```ruby  
<%= form_for :model_name, method: 'get' do |f| %>  
  <%= f.text_field :search, placeholder: "search" %>  
<% end %>  
```  
Then in your controller, you can call the search method on your model. You could also
specify the columns you want to search on. If you don't specify columns, DynamicSearch
will check against all of the columns on your model except foreign keys, id, and timestamps.

```ruby  
if params.has_key? :search  
  columns_array = ["first_name", "last_name", "username", "email"] 
  @results = Model.search(params[:search], columns_array) 
end  
```
From there I normally would paginate the results with Kaminari or WillPaginate.

*Optional*
Customize the search method in your model to specify how your search should work all the
time for that model, instead of just one view like above. In this case, you're telling the search method 
which columns you want included in your search every time for this model.

```ruby  
def search(search)  
  super(search, ["first_name", "last_name", "username", "email"])  
end  
```

## Contributing
If you find a bug, submit an issue or pull request if you've fixed it. Feel free to reach
out on twitter: [@jeremydwayne](https://www.twitter.com/jeremydwayne)

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
