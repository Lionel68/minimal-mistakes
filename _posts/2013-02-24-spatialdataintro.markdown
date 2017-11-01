---
title: Using Spatial Data in R;
wordpress_id: 102
categories:
- R and Stat
tags:
- R
- Spatial Data
---

Nowadays more and more spatial data analysis are performed in Biology due to the ever expanding information freely available on the internet, as for example the GBIF web facility giving access to species records, and also to the questions linked to global change: what is a species niche? Why are there more species in the tropics and how will they react to climate change… All of these questions carry some spatial background and a class of software allow spatial analysis the Geographic Information Systems (GIS), some or for free: SAGA, GRASS QGIS, some have very expensive license: ArcGIS, MapInfo, and others have incorporated spatial data in their methods: R. This post is an introduction to the spatial classes in R and basic operation that can be done on them.


## Spatial Points Basics:


Let's jump right into some code and comment afterwards on it;

    
    <code># load the library
    library(sp)
    # create a vector of Longitude coordinates
    Long <- 10 + rnorm(n = 10, mean = 3, sd = 6)
    # create a vector of Latitude coordinates
    Lat <- 40 + rnorm(n = 10, mean = 3, sd = 6)
    # bring them together in a data frame
    coords <- as.data.frame(cbind(Long, Lat))
    points <- coords
    
    # turn this data frame into a Spatial Point object
    coordinates(points) <- ~Long + Lat
    summary(points)
    </code>
    <code>## Object of class SpatialPoints
    ## Coordinates:
    ##         min   max
    ## Long  2.982 21.16
    ## Lat  32.995 50.21
    ## Is projected: NA 
    ## proj4string : [NA]
    ## Number of points: 10
    </code>
    <code># another way to do it
    points <- SpatialPoints(coords)
    
    # let's explore the few properties of Spatial Points object
    bbox(points)  #give the range of the coordinates
    </code>
    <code>##         min   max
    ## Long  2.982 21.16
    ## Lat  32.995 50.21
    </code>
    <code>proj4string(points)  #give the geographic projection !Big Topic!
    </code>
    <code>## [1] NA
    </code>
    <code>coordinates(points)  #give the Longitude/Latitude coordinates
    </code>
    <code>##         Long   Lat
    ##  [1,] 16.021 41.92
    ##  [2,] 13.341 50.21
    ##  [3,] 16.225 40.17
    ##  [4,] 16.679 44.66
    ##  [5,] 18.927 49.31
    ##  [6,] 15.495 34.91
    ##  [7,]  8.562 32.99
    ##  [8,] 21.160 40.36
    ##  [9,] 11.275 50.17
    ## [10,]  2.982 47.54
    </code>
    <code>
    # let's add some data
    spdf <- SpatialPointsDataFrame(points, data.frame(Height = rpois(10, 5), Sex = c(rep("Male", 
        5), rep("Female", 5))))
    summary(spdf)
    </code>
    <code>## Object of class SpatialPointsDataFrame
    ## Coordinates:
    ##         min   max
    ## Long  2.982 21.16
    ## Lat  32.995 50.21
    ## Is projected: NA 
    ## proj4string : [NA]
    ## Number of points: 10
    ## Data attributes:
    ##      Height         Sex   
    ##  Min.   :1.00   Female:5  
    ##  1st Qu.:2.25   Male  :5  
    ##  Median :4.50             
    ##  Mean   :3.90             
    ##  3rd Qu.:5.00             
    ##  Max.   :6.00
    </code>
    <code>
    # by using the @data we can do normal data frame operation
    subset(spdf, spdf@data$Sex == "Male")
    </code>
    <code>##          coordinates Height  Sex
    ## 1 (16.0206, 41.9241)      1 Male
    ## 2 (13.3412, 50.2071)      5 Male
    ## 3 (16.2249, 40.1712)      4 Male
    ## 4 (16.6789, 44.6597)      6 Male
    ## 5 (18.9267, 49.3124)      2 Male
    </code>
    <code>
    # some ploting using the data information
    #?spplot
    spplot(spdf, zcol = "Sex")
    </code>
    <code>plot(spdf, col = spdf$Height, pch = as.numeric(factor(spdf$Sex, labels = c(1, 
        2))))
    </code>


A Spatial points object is defined by three elements, a list of X and Y coordinates, in the package sp the X always corespond to the longitude and the Y to the latitude; a bounding box (bbox) which defines the range of the coordinates and a projection. Only the first element is recquired to build a Spatial Points object. The projection components is critical since many coordinates systems exists (LongLat/Mercatour/AlbertEquals/Moolweide) and when loading/comparing/writing spatial data in R we must always make sure to use the correct projection. See here for a complete list of the projection supported in R: [here](http://www.remotesensing.org/geotiff/proj_list/)


## Some Mapping;


Loads of datasets exists on the web to download free spatial data, like [here](http://gadm.org/) for global boundaries of administratives area or [here](http://spatial-analyst.net/wiki/index.php?title=Global_datasets) for a wide range of maps.

    
    <code># download french administrative boundaries and load them into R
    download.file("http://www.filefactory.com/file/6lxmbggy8fc7/n/FRA_adm1_RData", 
        destfile = "FrenchMap.RData")
    load("FrenchMap.RData")
    summary(gadm)
    </code>
    <code>## Object of class SpatialPolygonsDataFrame
    ## Coordinates:
    ##      min   max
    ## x -5.144  9.56
    ## y 41.334 51.09
    ## Is projected: FALSE 
    ## proj4string :
    ## [+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0]
    ## Data attributes:
    ##       PID            ID_0        ISO               NAME_0         
    ##  Min.   :1213   Min.   :79   Length:22          Length:22         
    ##  1st Qu.:1218   1st Qu.:79   Class :character   Class :character  
    ##  Median :1224   Median :79   Mode  :character   Mode  :character  
    ##  Mean   :1224   Mean   :79                                        
    ##  3rd Qu.:1229   3rd Qu.:79                                        
    ##  Max.   :1234   Max.   :79                                        
    ##       ID_1         NAME_1           NL_NAME_1          VARNAME_1        
    ##  Min.   :11.0   Length:22          Length:22          Length:22         
    ##  1st Qu.:25.2   Class :character   Class :character   Class :character  
    ##  Median :47.5   Mode  :character   Mode  :character   Mode  :character  
    ##  Mean   :51.4                                                           
    ##  3rd Qu.:73.8                                                           
    ##  Max.   :94.0                                                           
    ##     TYPE_1           ENGTYPE_1        
    ##  Length:22          Length:22         
    ##  Class :character   Class :character  
    ##  Mode  :character   Mode  :character  
    ##                                       
    ##                                       
    ## 
    </code>
    <code>plot(gadm)
    </code>
    <code># control the axes label sizes
    plot(gadm, axes = TRUE, cex.axis = 0.8)
    # make a point at the coordinates of Paris (48.8567, 2.3508 from
    # wikipedia)
    paris <- SpatialPoints(coords = matrix(c(2.3508, 48.8567), ncol = 2), proj4string = CRS("+proj=longlat +datum=WGS84 +no_defs +towgs84=0,0,0"))
    plot(paris, add = TRUE, col = "red", shape = 1)
    </code>


Here ends this short introduction with a few links to very interesting tutos on the topic:

[frederico sanchez web page](https://sites.google.com/site/rodriguezsanchezf/news/usingrasagis)
[geostat summer course](http://geostat-course.org/)
