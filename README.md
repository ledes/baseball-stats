# README

### Heroku app
[link to heroku app](https://peaceful-river-51682.herokuapp.com)


### Description
I have decided to go with the approach of creating the classes `Player`(with subclass `Hitter`) and `Statistics`(this one includes the season year attribute).


This way we wont have duplicated players if we want to have more than one season in the system, and the query for the api would be more simple than having more tables involved.


For this initial implementation we don't need `League` or `Division`, even though it would be useful to have the architecture to implement future features like filtering by division or teams.If that is needed at some point, they could be nested on top of the players.


I'm considering that the page will always show the data for one particular season.
For future implementations, if all the seasons have to be displayed at the same time or a total, there should be a way to add each of the stats for each player for each season.


I did some research about the different formulas for the requested attributes. I don't know much about baseball but I think they should be right. I checked some of the results online and they match.


At the beginning I though the SB attribute was referred to `Stolen Bases / (Stolen Bases + Caught Stealing)` but I corrected it to just use the metric `steals`.


### Technical Specifications
* Ruby on Rails
* Ruby (2.3.0)
* PostgreSQL
* ReactJs (react-rails)
* SASS
* Rspec


### Features
* Design ready to add more seasons
* Sort columns in `DESC` or `ASC` order
* Custom pagination from pages 1 to 10
* For every action (shorting, or pagination) the page makes an api call to the back end and updates the statistics
* Only the necessary attributes are sent to the UI
* The api always return a maximum of 25 statistics


### Back end
There are 2 tables: `Players`, `Statistics`. There is a subclass for `Hitters` just in case the app wants to be used for other type of players. Hitters and statistics are loaded in the seed file, that reads the provided XML file. Before the creation of a statistic, the model will generate the calculations for the `AVG` and `OPS` column.

* Each Player has many Statistics

* Each Statistic belongs to a player

![Imgur](http://i.imgur.com/I7fLXH6.jpg)


The backend is connected to the react front end trough an Api that feeds the data from the controller.

### Front end
The entire front end has been built with react by using the gem `react-rails`.
The main component is `statisticsApp` and contains the state. The rest of components get the state from `statisticsApp` as props.
I made a reusable component (`sortableTable`) that can be used in other apps or in for other future features for this app.


### Use in development
In order to use this app in development:
 * Make sure to use `ruby 2.3.0` and have PostgreSQL running
 * Download the repo and access the folder with the rails app
 * `bundle install`
 * `rake db:create && rake db:migrate && rake db:seed`
 * `rails s`

### Test
This app has tests for the models using Rspec. In order to run them type in
terminal while you are in the project folder `rspec spec`.
