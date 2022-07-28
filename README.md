# tidbits
Try **tidbits** [here](https://tidbitstime.herokuapp.com)! 💗

This web app is very positive and very purple. It takes a habit of mine I hold very dear and manifests it into a functioning application for all to use.

tidbits is based off the principle of *practicing gratitude*. Through the simple act of recounting a few things we're grateful for each day, we can reap numerous benefits such as:
* improved health
* improved outlook on life
* better relationships with our loved ones
* developing the ability to handle adversity

Using tidbits is simple. All you need is an account and you can start making as many entries of positivity as you'd like. Each entry takes *three* tidbits. No more, no less. This is meant to be an easily replicated practice while still requiring at least *some* of your effort and thought. In the future, tidbits might change to allow users to create larger entries.

## Development
tidbits was developed with Ruby on Rails, SCSS, and PostgreSQL as the database. It utilizes Cloudinary for image uploads. The app is deployed for free on Heroku, and its session authentication is handled using bcrypt. There was an attempt to integrate React, among many other things, but ultimately I decided to have a simple Rails app, at least for *this* iteration of tidbits.

## Usage
### Creating an account
To create an account, you can either click "Register" in the navigation bar, or the big "register now" button in the middle of the homepage. Note that if you log in, you will not see the homepage again until you log out.

Uploading an image for your avatar is optional. If you choose not to upload one, your first initial will be displayed as your avatar instead.

Upon completing a successful registration, you will be taken to your dashboard.

### Dashboard
In the left part of your dashboard, you will see your avatar and some basic stats about your account, such as how many tidbits you've posted, or how many followers you have. On the right, you will see your feed. This is where entries posted by people you've followed will show.

If your feed is empty, you will have a button that will take you to a random profile. Even once your feed fills up, this button will still remain in your dashboard, but moved to your left sidebar instead.

### Making a new entry of tidbits
Here is the best part of tidbits! In the top navigation bar, or using the button in your sidebar on your dashboard, you can click "Make a new entry".

You will be presented with three empty text fields. You cannot submit your entry until you've filled out each one with some tidbits! Once your entry is completed, you'll be able to see it displayed on its own page. If you go to your profile, you'll also see it there too.

#### Editing or deleting an entry
At the bottom of each entry's page, you will have options to edit or delete it. Choosing to edit it will take you to a page where you can make modifications to your entry and save the changes. Choosing to delete it will prompt an alert to confirm if you really want to delete your tidbits.

### Profiles
On your profile, you'll be able to see your avatar and some basic statistics, similar to your dashboard. You will also see all of your entries in chronological order from newest to oldest.

If you visit someone *else's* profile, you'll notice there's a button in their sidebar to "Follow" them. This will add their entries (if any) to your dashboard feed. You can unfollow someone at anytime, and as a result, their entries will also be removed from your feed.

### Hearts
The "likes" system in tidbits is called "hearts", because *love* is much stronger than *like*. There is a link at the bottom of every entry to "heart" it.

### Settings
At the top of your navigation bar, you can click "Settings" to change your display name, email, password, or avatar. You'll notice there's a "remove avatar" link. That... does nothing. It's a dummy link for show (just like the "Forgot password?" link on the log in page if you noticed). The alert that pops up when you click on it will very cutely tell you that. Someday I might get that working, but not now. 💃

### Admins
Profiles that belong to admins have small crowns at the top of their avatars. Admins have the ability to view a secret page that lists all of the users registered on tidbits, as well as some stats about them.