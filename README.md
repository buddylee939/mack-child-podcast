# Steps 

- rails new mack-child-podcast -d postgresql
- added gems for heroku

```
group :development do
	gem 'sqlite3'
end

group :production do
	gem 'pg'
	gem 'rails_12factor'
end
```

- bundle install --without production
- rails g controller Welcome index
- in routes

```
root 'welcome#index'
```

- copy over the html

```
<div id="background">
	<header class="cf">
		<div class="wrapper_wide">
			<a href="#" id="logo">Podcast.fm</a>
			<nav>
				<ul>
					<li><%= link_to "Explore", podcasts_path %></li>
					<li><%= link_to "Sign In", new_podcast_session_path %></li>
					<li><%= link_to "Create a Podcast", new_podcast_registration_path %></li>
				</ul>
			</nav>
		</div>
	</header>
	<div class="wrapper_skinny">
		<h1>Discover your new favorite<br> podcast, or create your own.</h1>
		<%= link_to "Create a Podcast", new_podcast_registration_path, class: "button button_highlight" %>
		<%= link_to "Explore", podcasts_path, class: "button button_white" %>
	</div>
</div>
```

- 