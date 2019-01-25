#  MLB iOS Take Home Exercise

## Objective
The goal of this exercise is to demonstrate that given:
- a service endpoint, that returns structured data in JSON format
- a design

That you can build a working example that demonstrates the following:
- Retrieve serialized JSON data from an endpoint and parse it into a data structure
- Use that deserialized data in a visualized User Interface that presents the information to the user of the app in a meaningful way

## Problem Description
The Baseball Data backend team has provided a new endpoint that provides the scoreboard data for Major League Baseball, based on a given date parameter:

```
https://statsapi.mlb.com/api/v1/schedule?hydrate=team(league),venue(location,timezone),linescore&date=2018-09-19&sportId=1,51&language=en
```

Meanwhile, the design team has provided a mockup of what they would like the scoreboard view to look like:

![iOS Scoreboard Mock Up](iOSScoreboardMockup.png)


## Tasks
Create a User Interface that displays the information provided by the JSON endpoint with the following:
- A view displaying a view of all the games and their current score for a given date
- A means for the user to navigate to a specific date via a date picker accessible from the header shown in the mockup
- The list of games shall be sorted by the start time of the game as provided in the data
- Each game shall display:
  - the 2 teams playing, with away team above the home team
  - Each team's name and score
  - The state of the game:
  - For games not started, show the start time on the right-hand side
  - For games in progress, show the inning
  - For games completed, show `Final`
  - If a game was completed in more or less than the usual 9 innings, show `F/#` where the # is the number of innings played (e.g. `F/10` or `F/6`)
- Each game view should be tappable to display a detailed view of the game
  - **NOTE:** The contents of the detailed game view is optional and an exercise left up to the author to be as creative as desired

For this exercise you may IGNORE:
  - The team logos
  - The MLB logo in the header and the icon associated with tab icon
  - Any specific design considerations around colors, fonts or sizing as long as the data is shown on screen

  Ideally the implementation will be responsive to look reasonably the same and complete on iPad as well as iPhone, but as iPhone users are a
  vast majority of the overall user base, matching the iPhone mockup is the priority for this exercise
