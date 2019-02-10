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

## Add episode model and associations

- rails g model Episode title description:text podcast:references  
- rails db:migrate
- add the has many to podcast.rb

```
has_many :episodes
```

- rails g controller Episodes
- update routes

```
  resources :podcasts, only: [:index, :show] do
    resources :episodes
  end
```

- update episodes controller
- create the episodes: new/edit/show/form partial
- in episodes controller, add the show to filter the current episode so it doesnt appear in the list with the current episode

```
 def show
    @episodes = Episode.where(podcast_id: @podcast).order("created_at DESC").limit(6).reject { |e| e.id == @episode.id }
  end
```

## Add dashboard and edit, destroy episodes

- add the dashboard method to the podcasts controller

```
  def dashboard
  end
```

- add the devise authenticated route for once when logged in, this is for once we are logged in, the root_path becomes the dashboard and not the welcome/index

```
Rails.application.routes.draw do
  devise_for :podcasts

  resources :podcasts, only: [:index, :show] do
    resources :episodes
  end

  authenticated :podcast do
    root 'podcasts#dashboard', as: "authenticated_root"
  end

  root 'welcome#index'
end

```

- in podcasts controller, add an if conditional to the podcasts controller, 

```
  def find_podcast
    if params[:id].nil?
      @podcast = current_podcast
    else
      @podcast = Podcast.find(params[:id])
    end
  end
```

- create a podcasts/dashboard file

```
<%= render 'layouts/header'; %>

<div id="podcast_show">
  <div id="show_banner">
    <div class="wrapper_skinny">
      <h1><%= @podcast.title %></h1>
    </div>
  </div>

  <div id="links">
    <div class="wrapper_skinny">
      <ul>
        <li class="current">Episodes</li>
        <li><%= link_to "New Episode", new_podcast_episode_path(@podcast) %></li>
        <li><%= link_to "Account Settings", edit_podcast_registration_path %></li>
        <li><%= link_to "View Podcast", podcast_path(current_podcast) %></li>
      </ul>
    </div>
  </div>

  <div id="episodes">
    <div class="wrapper_skinny">
      <ul class="cf">
        <% @episodes.each do |episode| %>
          <li class="cf">
            <div class="episode_thumbnail">
              <a href="episode.html">
                <%#= image_tag episode.episode_thumbnail.url(:medium) %>
              </a>
            </div>
            <div class="episode_overview">
              <h2><%= link_to episode.title, podcast_episode_path(@podcast, episode) %></h2>
              <p class="description"><%= truncate(episode.description, lenght: 160) %></p>
              <div class="authorized_links">
                <%= link_to "Edit", edit_podcast_episode_path(@podcast, episode) %>
                <%= link_to "Delete", podcast_episode_path(@podcast, episode), method: :delete, data: {confirm: "Are you sure?"} %>
              </div>
            </div>
          </li>
        <% end %>
      </ul>
    </div>
  </div>
</div>

<%#= will_paginate @episodes, previous_label: "Previous", next_label: "Next" %>
```

## Add authentication to podcasts

- update episodes controller to add authentication except show

```
 class EpisodesController < ApplicationController
  before_action :authenticate_podcast!, except: [:show]
  before_action :require_permission
  before_action :find_podcast
  before_action :find_episode, only: [:show, :edit, :update, :destroy]

```

- to not allow one podcast creator to add new episodes to another podcasts, in episodes controller add the require permission method

```
 class EpisodesController < ApplicationController
  before_action :authenticate_podcast!, except: [:show]
  before_action :require_permission
  before_action :find_podcast
  before_action :find_episode, only: [:show, :edit, :update, :destroy]
  private
  def require_permission
    @podcast = Podcast.find(params[:podcast_id])
    if current_podcast != @podcast
      redirect_to root_path, notice: "Sorry, you're not allowed to view that page"
    end
  end

```

## Paperclip - I'm gonna use active storage

```
2 Setup
Active Storage uses two tables in your application’s database named active_storage_blobs and active_storage_attachments. After creating a new application (or upgrading your application to Rails 5.2), run rails active_storage:install to generate a migration that creates these tables. Use rails db:migrate to run the migration.
```

- edit episode and podcast models

```
class Episode < ApplicationRecord
  has_one_attached :episode_image
  belongs_to :podcast
end
class Podcast < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :episodes
  has_one_attached :podcast_image
end
```

- update episodes controller params

```
  def episode_params
    params.require(:episode).permit(:title, :description, :episode_image)
  end
```

- update the episodes form

```
	<div class="field">
		<%= f.label :episode_image %><br>
		<%= f.file_field :episode_image %>
	</div>
```

- update the image show

```
<%= image_tag @episode.episode_image, class: "current_episode_thumbnail" %>
``` 

- add the podcast image to the params in application controller

```
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:title, :podcast_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:title, :description, :itunes, :stitcher, :podbay, :podcast_image]
    )
  end
```

## Store assets on Amazon S3 - we need to do it a different way, with credentials etc

- not needed, i don't think

## Add mp3 uploads and mp3 player

- to see the image file name in rails console

```
 e.episode_image.filename
```

- update episode.rb

```
has_one_attached :mp3_file
```

- update the episode form partial

```
	<div class="field">
		<%= f.label :mp3_file %><br>
		<%= f.file_field :mp3_file %>
	</div>

```  	

- update the episode params in episode controller

```
  def episode_params
    params.require(:episode).permit(:title, :description, :episode_image, :mp3_file)
  end
```

- add the font-awesome rails gem and import scss on app.scss

```
@import "font-awesome";
```

- add jquery-rails gem
- add the jquery.jplayer.min.js file from the jplayer website to the js folder
- update the app.js

```
//= require jquery
//= require rails-ujs
//= require jquery.jplayer.min
//= require activestorage
//= require turbolinks
//= require_tree .
```

- add the jp scss

```
	#episode_content {
		padding: 4rem 0;
		margin-bottom: 4rem;
		border-bottom: 1px solid lighten($dark, 75%);
		.current_episode_thumbnail {
			display: block;
			margin: 0 auto 2rem auto;
			width: 10rem;
			max-width: 100%;
			border-radius: .35rem;
		}
		h2 {
			font-size: 1.5rem;
			text-align: center;
		}
		.description {
			text-align: center;
			font-size: .9rem;
			line-height: 1.7;
			color: lighten($dark, 25%);
		}
		a {
			text-decoration: none;
		}
		.jp-jplayer,.jp-audio {
    width: 70%;
    margin: 3rem auto .5rem auto;
		}
		.jp-title {
	    font-size: 12px;
	    text-align: center;
	    color: #999;
		}
		.jp-title ul {
	    padding: 0;
	    margin: 0;
	    list-style: none;
		}
		.jp-gui {
	    position: relative;
	    background: $highlight;
	    transition: background .4s ease-in-out;
	    border-radius: 3px;
	    overflow: hidden;
	    margin-top: 10px;
		}
		.jp-controls {
	    padding: 0;
	    margin: 0;
	    list-style: none;
	    font-family: "FontAwesome";
		}

		.jp-controls li {
	    display: inline;
		}

		.jp-controls a {
	    color: #fff;
		}
		.jp-play,.jp-pause {
	    width: 60px;
	    height: 40px;
	    display: inline-block;
	    text-align: center;
	    line-height: 43px;
	    border-right: 1px solid lighten($highlight, 10%);
		}

		.jp-controls .jp-play:hover,.jp-controls .jp-pause:hover {
	    background-color: darken($highlight, 10%);
		}

		.jp-mute,.jp-unmute {
	    position: absolute;
	    right: 59px;
	    top: -3px;
	    width: 20px;
	    height: 40px;
	    display: inline-block;
	    line-height: 46px;
		}

		.jp-mute {
	    text-align: left;
		}
		.jp-time-holder {
	    color: #FFF;
	    font-size: 12px;
	    line-height: 14px;
	    position: absolute;
	    right: 90px;
	    top: 14px;
		}
		.jp-progress {
	    background-color: darken($highlight, 25%);
	    border-radius: 20px 20px 20px 20px;
	    overflow: hidden;
	    position: absolute;
	    right: 22%;
	    top: 15px;
	    width: 65%;
		}

		.jp-play-bar {
	    height: 12px;
	    background-color: #fff;
	    border-radius: 20px 20px 20px 20px;
		}

		.jp-volume-bar {
	    position: absolute;
	    right: 10px;
	    top: 17px;
	    width: 45px;
	    height: 8px;
	    border-radius: 20px 20px 20px 20px;
	    background-color: darken($highlight, 25%);
	    overflow: hidden;
		}

		.jp-volume-bar-value {
	    background-color: #fff;
	    height: 8px;
	    border-radius: 20px 20px 20px 20px;
		}
	}
```

- add the jpayer html to the show page

```
			<div id="jquery_jplayer_1" class="jp-jplayer"></div>
      <div id="jp_container_1" class="jp-audio">
        <div class="jp-type-single">
          <div class="jp-gui jp-interface">
            <ul class="jp-controls">
              <li><a href="javascript:;" class="jp-play" tabindex="1">&#61515;</a></li>
              <li><a href="javascript:;" class="jp-pause" tabindex="1">&#61516;</a></li>
              <li><a href="javascript:;" class="jp-mute" tabindex="1" title="mute">&#61480;</a></li>
              <li><a href="javascript:;" class="jp-unmute" tabindex="1" title="unmute">&#61478;</a></li>
            </ul>

            <div class="jp-progress">
              <div class="jp-seek-bar">
                <div class="jp-play-bar"></div>
              </div>
            </div>

            <div class="jp-time-holder">
              <div class="jp-current-time"></div>
            </div>

            <div class="jp-volume-bar">
              <div class="jp-volume-bar-value"></div>
            </div>

            <div class="jp-no-solution">
              <span>Update Required</span>
              To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
            </div>
          </div>
        </div>
      </div>
		</div>
	</div>
```

- and add a script at the bottom with the url blob link

```
<script>
	$(document).ready(function(){
	  $("#jquery_jplayer_1").jPlayer({
	    ready: function () {
	      $(this).jPlayer("setMedia", {
	        mp3: "<%= rails_blob_url(@episode.mp3_file) %>",
	      });
	    },
	    swfPath: "/js",
	    supplied: "mp3"
	  });
	});
</script>
```

- [using jPlayer](http://jplayer.org/)

## Add pagination and other goodies

- add will paginate gem
- update podcasts controller methods

```
  def index
    @podcasts = Podcast.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 12)
  end

  def show
  end

  def dashboard
  end

  private

  def find_episode
     @episodes = Episode.where(podcast_id: @podcast).order("created_at DESC").paginate(:page => params[:page], :per_page => 5)
  end
```

- to seed the podcasts and episodes with files, in environments/dev add

```
config.active_job.queue_adapter = :inline
```

- in the seed file

```
20.times do |p|
 pod = Podcast.create!(
    title: "Podcast no:#{p}",
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis aliquam quidem, ipsum in quos. Dolorem alias, aliquid culpa magni quaerat incidunt non earum odit, cupiditate minima amet, numquam voluptatum reprehenderit!",
    email: "abby#{p}@example.com",
    itunes: "#",
    stitcher: "#",
    podbay: "#",
    password: 'asdfasdf',
    password_confirmation: 'asdfasdf', 
  )
 pod.podcast_image.attach(
  io: File.open('app/assets/images/logo6.jpg'), 
  filename: 'logo6.jpg', 
  content_type: 'image/jpg'
 )

end

puts '20 podcasts created'

100.times do |e|
  ep = Episode.create!(
    title: " Episode #{e}",
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Architecto voluptatem ipsum sapiente, maxime! Nostrum eos, odio asperiores quis incidunt molestias.",
    podcast_id: rand(1..20)
  )
  ep.mp3_file.attach(
    io: File.open('app/assets/images/1-01 Survival.mp3'), 
    filename: '1-01 Survival.mp3', 
    content_type: 'audio/mpeg'
  )
  ep.episode_image.attach(
    io: File.open('app/assets/images/logo1.jpg'), 
    filename: 'logo1.jpg', 
    content_type: 'image/jpg'    
  )
end

puts '100 episodes created'

```  

- **you might have to close postgres app and exit out of the page**
- css for pagination

```

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
```

- add a script to the layouts/app to fade out the flash messages

```
<script>
	$(document).ready(function(){
		setTimeout(function() {
			$('#notice_wrapper').fadeOut("slow", function() {
				$this.remove();
			});
		}, 4500 );
	});
</script>
```

# The End