# Heroku deployment
Go to the [Heroku website](https://www.heroku.com) and create an account if you don't already have one.

## Installation via CLI
### Ubuntu
```shell
$ curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
```
You can also check if you've successfully installed Heroku by running:
```shell
$ heroku --version
heroku/7.60.2 linux-x64 node-v14.19.0
```

### Mac
```shell
$ brew tap heroku/brew
$ brew install heroku
```

## Logging in
```shell
$ heroku login -i
```
You will then be prompted to login using your Heroku account email and password.

## Setup
Heroku will automatically generate a project name for you unless you specify one. The name will be in the URL of your app. You can rename your project at any time.

To establish your project name, first navigate to your Rails project directory using `cd`. Make sure you are in the root directory of the app and then run:
```shell
~/project-name$ heroku create project-name
```
You can now navigate to your Heroku app at: `project-name.herokuapp.com`. You will also be able to see it listed in your list of apps on your [Heroku dashboard](https://dashboard.heroku.com/apps).

## Pushing code
You should see both `origin` and `heroku` listed if you run:
```shell
~/project-name$ git remote
origin  heroku
```
If you have any migrations or unseeded data, migrate and seed first by running:
```shell
~/project-name$ heroku run rails db:migrate
~/project-name$ heroku run rails db:seed
```
To then push code, run:
```shell
~/project-name$ git push heroku master
```
You can now refresh your app and see your changes.

## Testing
```shell
~/project-name$ heroku run rails console
```

## Running
Will open your Heroku app in your browser.
```shell
~/project-name$ heroku open
```