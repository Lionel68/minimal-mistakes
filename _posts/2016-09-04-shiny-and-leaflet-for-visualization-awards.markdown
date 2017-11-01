---
title: Shiny and Leaflet for Visualization Awards
wordpress_id: 872
categories:
- Biological Stuff
tags:
- ecology
- R
---

Next week will be the [meeting of the German (and Swiss and Austrians) ecologists](http://gfoe-2016.de/) in Marburg and the organizing team launched a visualization contest based on spatial data of the stores present in the city. [Nadja](http://toek.wzw.tum.de/index.php?id=106) [Simons](https://twitter.com/Tritotanus) and I decided to enter the contest, our idea was to link the store data to the city bus network promoting a sustainable and safe way of movement through the town (we are ecologists after all).

We used [leaflet](https://cran.r-project.org/web/packages/leaflet/index.html) to prepare the map and plot the bus lines, bus stops and stores. On top of that because all this information is rather overwhelming to grasp (more than 200 stores and 50 bus stops), we implemented a [shiny](https://cran.r-project.org/web/packages/shiny/index.html) App to allow the user to restrict its search of the best Bars in Marburg.

All the code is on [GitHub ](https://github.com/Lionel68/VizAward/)and the App can accessed by clicking [here](https://gfoe2016.shinyapps.io/VizAward_HS/).

Go there, enjoy, and if you want to learn a bit about the process of developing the App come back here.



First a few words on what is so cool about leaflet:



	
  * There is a [lot of maps](http://leaflet-extras.github.io/leaflet-providers/preview/index.html) available

	
  * With the AwesomeMarker plugin, available in the github repo of the package, you can directly tap into three awesome libraries for icons: [font awesome](http://fontawesome.io/icons/), [glyphicons](http://getbootstrap.com/components/#glyphicons) and [ionicons](http://ionicons.com/)

	
  * Leaflet understand HTML code, we used it to provide a clickable link to the bus timetables

	
  * Using groups makes it easy to interactively add or remove group of objects from the map


Having this was already nice, but putting it into a shiny App was even more exciting. Here are some of the main points:

	
  * A very important concept in shiny is the concept of [reactivity](http://shiny.rstudio.com/articles/reactivity-overview.html), the way I understood it is that a reactive object is a small function that will get updated every time the user input some elements, see [this](https://uasnap.shinyapps.io/ex_leaflet/) nice tutorial for more on this.

	
  * Our idea of the App was that stores should appear when the mouse is passed over their nearest bus stop. The issue there is that the stores must then disappear if the mouse moves out. The trick is to create a set of reactiveValues that are NULL as long as the event (mouse passes over a bus stop) does not occure AND return to NULL when the event is finished (mouse moves out), helped by [this](http://stackoverflow.com/questions/35266730/r-leaflet-cran-how-to-register-clicking-off-a-marker?rq=1) post, we were able to implement what we wanted.

	
  * Shiny gives you a lot of freedom to create and customize the design of the App, what I found very cool was the possibility to have tabs.


Be sure to check the [leaflet tutorial](https://rstudio.github.io/leaflet/) page, 90% of my questions were answered there, also check out the [many articles](http://shiny.rstudio.com/articles/) on shiny.

See you in Marburg if you'll be around!


