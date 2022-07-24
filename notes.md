# Rails with PostgreSQL

Notice that the model name `Song` is capitalized and in singular form.

```
rails generate model Song title:text album_id:integer artist_id:integer
```

Check `db` files, and if everything is correct, then run `rails db:migrate`.

Then run `rails db` and then `\d` to check tables before you create the model `Artist`.

```
rails generate model Artist name:text image:text
```

Check then migrate, then create the next models `Album`, `Genre`, `Mixtape`, and `User`, also checking along the way.

```
rails generate model Album title:text image:text
```

```
rails generate model Genre name:text
```

```
rails generate model Mixtape title:text user_id:integer
```

```
rails generate model User email:text
```

## Establishing one-to-many associations

In `song.rb` model:

```rb
class Song < ApplicationRecord
    belongs_to :artist, :optional => true
    belongs_to :album, :optional => true
end
```

In `artist.rb` model:

```rb
class Artist < ApplicationRecord
    has_many :songs
end
```

In `album.rb` model:

```rb
class Album < ApplicationRecord
    has_many :songs
end
```

In `user.rb` model:

```rb
class User < ApplicationRecord
    has_many :mixtapes
end
```

In `mixtape.rb` model:

```rb
class Mixtape < ApplicationRecord
    belongs_to :user, :optional => true
end
```

## Setting up join table

Note that in `create_mixtapes_songs`, it's in alphabetical order.

```
rails generate migration create_mixtapes_songs mixtape_id:integer song_id:integer
```

Turn off the `id` column in a join table by adding `:id => false`:

```rb
class CreateMixtapesSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :mixtapes_songs, :id => false do |t|
      t.integer :mixtape_id
      t.integer :song_id
    end
  end
end
```

Next, run `rails db:migrate`
Then:

```
rails generate migration create_genres_songs genre_id:integer song_id:integer
```

Add `:id => false` to this join table as well, then run `rails db:migrate`.

## Establishing many-to-many associations

In `mixtape.rb`, add `has_and_belongs_to_many :songs`:

```rb
class Mixtape < ApplicationRecord
    belongs_to :user, :optional => true
    has_and_belongs_to_many :songs
end
```

Do similarly in `song.rb`:

```rb
class Song < ApplicationRecord
    belongs_to :artist, :optional => true
    belongs_to :album, :optional => true
    has_and_belongs_to_many :mixtapes
    has_and_belongs_to_many :genres
end
```

Repeat the process in `genre.rb`:

```rb
class Genre < ApplicationRecord
    has_and_belongs_to_many :songs
end
```

## Seeding

In `seeds.rb`:

```rb
User.destroy_all
u1 = User.create :email => "jonesy@ga.co", :password => "chicken"
u2 = User.create :email => "cragisy@ga.co", :password => "chicken"
puts "#{ User.count } users created."

Song.destroy_all
s1 = Song.create :title => "MANIAC"
s2 = Song.create :title => "Unknown Mother Goose"
s3 = Song.create :title => "TRIANGLE"
s4 = Song.create :title => "Panopticon"
puts "#{ Song.count } songs created."

Album.destroy_all
l1 = Album.create :title => "ODDINARY"
l2 = Album.create :title => "DEMAGOG"
l3 = Album.create :title => "NOW: WHO WE ARE FACING"
l4 = Album.create :title => "ai/SOlate"
puts "#{ Album.count } albums created."

Artist.destroy_all
a1 = Artist.create :name => "Stray Kids"
a2 = Artist.create :name => "hitorie"
a3 = Artist.create :name => "Tatsuya Kitani"
a4 = Artist.create :name => "GHOST9"
puts "#{ Artist.count } artists created."

Genre.destroy_all
g1 = Genre.create :name => "J-rock"
g2 = Genre.create :name => "J-pop"
g3 = Genre.create :name => "J-core"
g4 = Genre.create :name => "K-pop"
g5 = Genre.create :name => "Electronic"
puts "#{ Genre.count } genres created."

Mixtape.destroy_all
m1 = Mixtape.create :title => "Driving Songs"
m2 = Mixtape.create :title => "Cooking Music"
m3 = Mixtape.create :title => "Code Jams"
m4 = Mixtape.create :title => "Vibin"
puts "#{ Mixtape.count } mixtapes created."

# Assocations ################################################
puts "Albums and songs"
l1.songs << s1
l4.songs << s2
l3.songs << s3
l2.songs << s4

puts "Artists and songs"
a1.songs << s1
a2.songs << s2
a4.songs << s3
a3.songs << s4

puts "Genres and songs"
s1.genres << g4 << g5
s2.genres << g1 << g2
s3.genres << g4 << g5
s4.genres << g1 << g2
g1.songs << s2 << s4

puts "Mixtapes and songs"
m1.songs << s1 << s2 << s3 << s4
m2.songs << s1 << s1 << s1 << s1
m3.songs << s2 << s4 << s2 << s4

puts "Mixtapes and users"
u1.mixtapes << m1 << m2
u2.mixtapes << m3 << m4
```

Once you've checked the seed data is correct, run:

```
rails db:seed
```

## Connecting through one table in between

**(OPTIONAL)** In `artist.rb`, add `has_many :genres, :through => :songs`:

```rb
class Artist < ApplicationRecord
    has_many :songs
    has_many :genres, :through => :songs
end
```

## Adding passwords

Following the convention of `password_digest`, run:

```
rails generate migration add_password_digest_to_users password_digest:string
```

Check the file, then migrate.

Uncomment line 26 in `Gemfile` which should look like this:

```
gem 'bcrypt', '~> 3.1.7'
```

then run `bundle`.

Add `has_secure_password` in `user.rb` model:

```rb
class User < ApplicationRecord
    has_secure_password
    has_many :mixtapes
end
```

## Initial paths

In `routes.rb`, add:

```rb
root :to => "pages#home"
resources :users, :only => [:new, :create]
```

## User registration

Define `new` and `create` in `users_controller.rb`:

```rb
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
```

This saves the user to memory in Ruby first, and checks if account creation is successful before redirecting or rendering the page over again.

Next, in `new.html.erb` in `views/users`, add the following form:

```erb
<h1>Sign Up</h1>
<% if @user.errors.any? %>
    <ol>
        <% @user.errors.full_messages.each do |msg| %>
            <li><%= msg %></li>
        <% end %>
    </ol>
<% end %>

<%= form_for @user do |f| %>
    <%= f.label :email %>
    <%= f.email_field :email %>

    <%= f.label :password %>
    <%= f.password_field :password %>

    <%= f.label :password_confirmation %>
    <%= f.password_field :password_confirmation %>

    <%= f.submit "Sign up!" %>
<% end %>
```

In order to validate users and ensure an email isn't ever used more than once, handle the logic in the `user.rb` model, _not_ the controller (this follows the principle of "fat models and thin controllers"). Add the following line into the `User` class:

```rb
validates :email, :uniqueness => true, :presence => true
```

## Signing in

In `routes.rb`, add:

```rb
get "/login" => "session#new"
post "/login" => "session#create"
delete "/login" => "session#destroy"
```

This means you need a new controller named `Session`, which you can note is in singular form unlike the other controllers. In terminal, run:

```
rails generate controller Session new
```

In `new.html.erb` in your `session` view folder, you will need to use `form_tag` instead of `form_for` which does not have a form helper and uses different tags because it makes a `POST` request. The form is as follows:

```erb
<h1>Log In</h1>
<%= form_tag login_path do %>
    <%= label_tag :email %>
    <%= email_field_tag :email %>

    <%= label_tag :password %>
    <%= password_field_tag :password %>

    <%= submit_tag "Sign in" %>
<% end %>

<p>If you don't already have an account, sign up <%= link_to "here", new_user_path %>.</p>
```

In order to create a session in the server's memory, you will now have to edit `session_controller.rb` to define the `create` action where you will:

1. Find the user by email
2. If the password matches, remember the user and go to the homepage
3. If not, it will redirect to the login page where an error will be displayed.

```rb
def create
  user = User.find_by :email => params[:email]
  if user.present? && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect_to root_path
  else
    flash[:error] = "Sorry, login failed."
    redirect_to login_path
  end
end
```
`flash` differs from `session` as it helps to show things only one time, which will be useful when you want to display the error on the page itself. In order to display the error, add the following *before* the form in the `new.html.erb` file of the `session` folder:
```erb
<% if flash[:error].present? %>
    <h2><%= flash[:error] %></h2>
<% end %>
```

In order to get the user from the database if they're signed in, write the following in `application_controller.rb`:
```rb
class ApplicationController < ActionController::Base
    before_action :fetch_user

    def fetch_user
        @current_user = User.find_by :id => session[:user_id] if session[:user_id].present?
        session[:user_id] = nil unless @current_user.present?
    end
end
```

You will also want to add a feature that automatically signs the user in when they sign up *successfully*. In the `create` action in `users_controller.rb`, but before redirecting, add:
```rb
session[:user_id] = @user.id
```

## Logging out
In `session_controller.rb`, define the `destroy` action:
```rb
def destroy
  session[:user_id] = nil
  redirect_to login_path
end
```
Your navigation in `application.html.erb` can be edited with logic to detect the current session like so:
```erb
<nav>
  <%= link_to "Home", root_path %>

  <% if @current_user.present? %>
    | <%= link_to "Logout #{ @current_user.email }", login_path, :method => "delete" %>
  <% else %>
    | <%= link_to "Sign up", new_user_path %>
    | <%= link_to "Sign in", login_path %>
  <% end %>
</nav>
```
You can now create an account or login if there is no current user, or log out if you are logged in.

## Creating mixtapes
The only functionality when you can login. Add the following to `routes.rb`:
```rb
resources :mixtapes, :only => [:new, :create]
```
You can now add to the navigation in `application.html.erb` a link to "Create mixtape":
```erb
<%= link_to "Create mixtape", new_mixtape_path %>
```
To create a new controller for Mixtapes, run:
```
rails generate controller Mixtapes new
```
You will now have a `mixtapes` folder in `views`, where you can edit `new.html.erb` to have a form:
```erb
<h1>New mixtape</h1>
<%= form_for @mixtape do |f| %>
    <%= f.label :title %>
    <%= f.text_field :title %>

    <%= f.submit %>
<% end %>
```
Edit the actions in `mixtapes_controller.rb`, noting that `@current_user.mixtapes << mixtape` in `create` will establish ownership.
```rb
class MixtapesController < ApplicationController
  def new
    @mixtape = Mixtape.new
  end

  def create
    mixtape = Mixtape.create mixtape_params
    @current_user.mixtapes << mixtape
    redirect_to root_path
  end

  private
  def mixtape_params
    params.require(:mixtape).permit(:title)
  end
end
```
To make sure that a user can't create a mixtape unless they're logged in, define a method that will check for a user in `application_controller.rb`:
```rb
def check_for_login
  redirect_to login_path unless @current_user.present?
end
```
In order to have this work to control actions for mixtapes (not the entire site), add the following to the beginning of the `MixtapesController` class in `mixtapes_controller.rb`:
```rb
before_action :check_for_login
```

## Administration permissions
In `application_controller.rb`, define a `check_for_admin` action:
```rb
def check_for_admin
  redirect_to login_path unless (@current_user.present? && @current_user.admin?)
end
```
In `routes.rb`, add `:index` to your routes for `:users:`:
```rb
resources :users, :only => [:new, :create, :index]
```
In `users_controller.rb`, define the `index` action:
```rb
def index
  @users = User.all
end
```
In the same file, you also want to check the current logged in user for administrative privileges, but *only* for the index route. You can add to the beginning of the `UsersController` class:
```rb
before_action :check_for_admin, :only => [:index]
```
Create a `index.html.erb` file in the `users` views folder that contains a list of registered email addresses:
```erb
<h1>All users</h1>
<h2><%= @users.count %> registered users</h2>
<ul>
    <% @users.each do |user| %>
        <li><%= user.email %></li>
    <% end %>
</ul>
```
In order to establish actual admin privileges, you will need to add a new column to the `users` table:
```
rails generate migration add_admin_to_users admin:boolean
```
Make sure the default value for the boolean is false *before* you run the migration. In your new migration file, add this:
```rb
:boolean, :default => false
```
In the `application.html.erb`, you can add the following to navigation which will check if the user is an admin or not:
```erb
<%= link_to "All users", users_path if @current_user.admin? %>
```
In order to make a user an admin, it's easier to edit the `seeds.rb` file directly. You can add `:admin => true` to any user you would like to make an admin, such as the first user:
```rb
u1 = User.create :email => "jonesy@ga.co", :password => "chicken", :admin => true
```
You can then reseed your data by running `rails db:seed`.