# README for MyMovieVault

![screen](http://i.imgur.com/6L2f1Wg.png)

This is a simple movie tracking app. A given user can create an account and then add movies they may be interested in watching later. They can filter but watched/unwatched, and title/note.

### Requirements
You will need:
1. Ruby (v.2.3.1)
2. Rails (v.5.0.0 or higher)
3. PostgreSQL


### Set up
1. Clone down the repo: `git clone https://github.com/bfpepper/retake_main`
2. cd into the repo: `retake_main`
3. Run `bundle install` to pull down all the necessary gems.
4. Assuming everything bundled properly, run `rake db:setup`.
5. Once the migrations complete, run `rspec` to make sure everything is all ready to go.

### Running the app
* You can run it locally once you run through the set up above by running `rails s`
* You can also visit the deployed app at https://calm-mountain-20892.herokuapp.com/
