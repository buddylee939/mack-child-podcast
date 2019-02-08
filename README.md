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

- rename app.scss
- add css

```
$white: #FFFFFF;
$highlight: #d2674e;
$dark: #22292e;
$light: #EDEFF5;

body {
	font-family: 'Open Sans', sans-serif;
}

.wrapper_wide {
	width: 90%;
	margin: 0 auto;
}

.wrapper {
	width: 80%;
	margin: 0 auto;
}

.wrapper_skinny {
	width: 50%;
	margin: 0 auto;
}

.cf:before, .cf:after {
	content: " ";
	display: table;
}

.cf:after {
	clear: both;
}

#notice_wrapper {
	width: 100%;
	position: absolute;
	background: rgba(208,103,82, 0.85);
	z-index: 999;
	p {
		color: $white;
		text-align: center;
		font-weight: 700;
		font-size: 1.25rem;
		padding: 1.5rem 0;
	}
}

.button {
	color: $white;
	text-decoration: none;
	font-size: 1rem;
	padding: 1rem 2rem;
	border-radius: 2rem;
	outline: none;
	border: none;
  display: inline-block;
  min-width: 8.5rem;
}

.button_highlight {
	background: $highlight;
	transition: background .4s ease-in-out;
	&:hover {
		background: darken($highlight, 7.5%);
	}
}

.button_white {
	background: $white;
	color: $dark;
	transition: background .4s ease-in-out;
	&:hover {
		background: darken($white, 7.5%);
	}
}

.button_block {
	display: block;
	margin: 0 auto;
}

#main_header {
	color: $dark;
	background: $white;
	padding: 2.5rem 0;
	#logo {
		float: left;
		text-transform: uppercase;
		font-weight: 700;
		color: $dark;
		text-decoration: none;
	}
	nav {
		float: right;
		ul {
			list-style: none;
			margin: 0;
			li {
				display: inline;
				margin-left: 2.5rem;
				a {
					color: $dark;
					text-decoration: none;
				}
			}
		}
	}
}

#banner {
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center center;
	margin-bottom: 4rem;
	h1 {
		text-align: center;
		color: $white;
		font-size: 3rem;
		font-weight: 300;
		letter-spacing: 1px;
		margin: 0;
		padding: 8rem 0;
	}
}

.podcasts_banner {
	background-image: image-url("podcasts_banner.jpg");
}

.sign_in_banner {
	background-image: image-url("sign_in_banner.jpg");
}

.sign_up_banner {
	background-image: image-url("sign_up_banner.jpg");
}

.pagination:before, .pagination:after {
	content: " ";
	display: table;
}

.pagination:after {
	clear: both;
}

.pagination {
	text-align: center;
	margin: 1rem 0 5rem 0;
	a, .previous_page, .current, .next_page {
		padding: 0.75rem 1rem;
		margin: 0 .25rem;
		border-radius: .15rem;
		line-height: 1.25;
		text-decoration: none;
		background: #EDEFF5;
		font-weight: 700;
		font-size: .7rem;
		font-style: normal;
		color: $dark;
		&:hover {
			background: $highlight;
			color: $white;
		}
	}
	.current {
		background: $highlight;
		color: $white;
	}
	.disabled {
		color: #C0C0C0;
		&:hover {
			color: #C0C0C0;
			background: #EDEFF5;
		}
	}
}

.field {
	margin: .5rem 0 1.5rem 0;
}

input[type="email"], input[type="text"], input[type="password"], textarea {
	width: 100%;
	height: 2.5rem;
	padding: .25rem 1rem;
	background: $light;
	border: 1px solid darken($light, 5%);
	border-radius: .35rem;
	margin-top: .5rem;
}

textarea {
	min-height: 8rem;
	margin-top: .5rem !important;
}

#form {
	padding: 0 0 5rem 0;
}

@import 'normalize';
@import 'welcome';
@import 'podcasts';
```

- import background images from github

## Creating podcast users with devise

- install devise gem
- rails g devise:install
- add the flash messages to layout/app

```
<% if alert %>
	<div id="notice_wrapper">
		<p class="alert"><%= alert %></p>
	</div>
<% elsif notice %>
	<div id="notice_wrapper">
		<p class="notice"><%= notice %></p>
	</div>
<% end %>
```

- rails g devise:views
- rails g devise Podcast
- rails db:migrate
- update the links on the welcome/index page

```
<div id="background">
	<header class="cf">
		<div class="wrapper_wide">
			<a href="#" id="logo">Podcast.fm</a>
			<nav>
				<ul>
					<% unless podcast_signed_in? %>
						<li><%= link_to "Explore", "#" %></li>
						<li><%= link_to "Sign In", new_podcast_session_path %></li>
						<li><%= link_to "Create a Podcast", new_podcast_registration_path %></li>
					<% else %>
						<li><%= link_to "Dashboard", root_path %></li>
						<li><%= link_to "Explore", "#" %></li>
						<li><%= link_to "Sign Out", destroy_podcast_session_path, method: :delete %></li>
					<% end %>
				</ul>
			</nav>
		</div>
	</header>
	<div class="wrapper_skinny">
		<h1>Discover your new favorite<br> podcast, or create your own.</h1>
		<%= link_to "Create a Podcast", new_podcast_registration_path, class: "button button_highlight" %>
		<%= link_to "Explore", "#", class: "button button_white" %>
	</div>
</div>
```

## Customizing devise 

- rails g migration add_attributes_to_podcast title description:text itunes stitcher podbay
- rails db:migrate
- update the registration new form
- update the registration edit
- in application_controller, add the new fields for devise

```
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:title])
    devise_parameter_sanitizer.permit(:account_update, keys: [:title, :description, :itunes, :stitcher, :podbay]
    )
  end
end
```

## Podcasts controller and views

- rails g controller Podcasts index show
- add the routes

```
resources :podcasts, only: [:index, :show]
```

- add the podcasts loop to podcasts/index
- update podcasts controller index action

```
class PodcastsController < ApplicationController
  before_action :find_podcast, only: [:show, :dashboard]
  before_action :find_episode, only: [:show, :dashboard]

  def index
    # @podcasts = Podcast.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 12)
    @podcasts = Podcast.all.order("created_at DESC")
  end

  def show
  end

  def dashboard
  end

  private

  def find_episode
    # @episodes = Episode.where(podcast_id: @podcast).order("created_at DESC")
  end

  def find_podcast
    if params[:id].nil?
      @podcast = current_podcast
    else
      @podcast = Podcast.find(params[:id])
    end
  end
end  
```

- add the code to the podcasts/show
- update podcasts_path links

  