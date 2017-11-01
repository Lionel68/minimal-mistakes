---
title: Importing 100 years of climate change into R
wordpress_id: 273
categories:
- R and Stat
tags:
- R
- time-series
---

This is a flashback post, I was working on species distribution shifts over the last 40 years last summer and recently [Rémi Genevest ](https://www1.montpellier.inra.fr/CBGP/?q=fr/content/genevest-r%C3%A9mi)contacted me asking me how I managed to import the [CRU TS 1.2](http://www.cru.uea.ac.uk/cru/data/hrg/timm/grid/CRU_TS_1_2.html) dataset into R. As always a more readable version of the code can be found [here](http://rpubs.com/hughes/16606).

At that time I used a not very elegant coding involving SpatialPixels and SpatilGridDataFrame, scrolling back to the [question](http://r-sig-geo.2731867.n2.nabble.com/Turning-SpatialPointsDataFrame-to-Raster-using-rasterize-td7582452.html) I asked to the R-sig-geo mailing list back then I stumbles across the answer from Robert Hijmans that I did not take into account at that time. Now one year after I found his answer going in the right direction and made some heavy change in the coding.

    
    #reading in CRU files into R
    library(raster)
    
    #for the CRU TS 1.2 download the .zip at http://www.cru.uea.ac.uk/cru/data/hrg/timm/grid/CRU_TS_1_2.html
    
    #the raster we get at the end, the data are monthly for all the years between 1901 and 2000
    temp<-brick(nrows=228,ncols=258,xmn=-11,xmx=32,ymn=34,ymx=72,nl=1200,crs=CRS("+proj=longlat +datum=WGS84"))
    
    #example using the temperature
    all_dat<-scan("/home/lionel/Documents/Master/CRU/obs.1901-2000.tmp",skip=5,what="list")
    
    #now turn the data into a matrix format with every line corresponding to a raster cell and the first two columns the column and row number of the cell
    xs<-all_dat[seq(2,37465029,1203)]
    xs<-gsub(",","",xs)
    xs<-as.numeric(xs)
    ys<-as.numeric(all_dat[seq(3,37465029,1203)])
    mat<-matrix(c(xs,ys),ncol=2,byrow=FALSE)
    #now add the temperature data from these cells for all month all year
    numb<-matrix(4:1203,ncol=1)
    numb<-apply(numb,1,function(x) seq(x[1],37465029,1203))
    mat<-cbind(mat,apply(numb,2,function(x) as.numeric(all_dat[x])))
    
    #reverse the rows number since they are numbered from bottom to top in CRU and from top to bottom in rasters
    ys_inv<-ys-((ys-113.5)-1)*2
    mat[,2]<-ys_inv
    
    #get the cell numbers of each box defined in the CRU dataset
    ce<-cellFromRowCol(temp,rownr=mat[,2],colnr=mat[,1])
    #attribute to these cells the temperature values
    values(temp)[ce,]<-mat[,3:1202]
    #divide by 10 to get the temperature in degree celsius
    values(temp)<-values(temp)/10
    #put names to the layers
    month<-c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Okt","Nov","Dec")
    years<-1901:2000
    names(temp)<-paste(rep(month,times=100),rep(years,each=12),sep="_")
    
    #the winter mean temperature between 1914 and 1918
    winter_1418<-calc(temp[[which(names(temp)%in%paste(rep(c("Dec","Jan","Feb"),times=5),rep(1914:1918,each=3),sep="_"))]],mean)
    plot(winter_1418)
    


[![raster1](http://biologyforfun.files.wordpress.com/2014/05/raster1.png)](http://biologyforfun.files.wordpress.com/2014/05/raster1.png)

    
    #the standard deviation in temperature for the years 1901 and 2000
    sd_100<-stack(calc(temp[[grep("1901",names(temp))]],sd),calc(temp[[grep("2000",names(temp))]],sd))
    plot(sd_100)


[![raster2](http://biologyforfun.files.wordpress.com/2014/05/raster2.png)](http://biologyforfun.files.wordpress.com/2014/05/raster2.png)

The only mathematical magic involve here is changing the row numbers. Then from this huge dataset we can do lots of neat thing, like we can see how cold did the soldier of the first world war were (first raster plot), or we can look at changes in standard deviation in temperature between the year 1901 and 2000 after one century of climate change.

If you use such data in your work do not forget to cite the owners: Mitchell, T.D., Carter, T.R., Jones, P.D., Hulme,M., New, M., 2003: A comprehensive set of high-resolution grids of monthly climate for Europe and the globe: the observed record (1901-2000) and 16 scenarios (2001-2100). Journal of Climate: submitted

And if you have some knowledge of similar dataset (monthly values over Europe) at a finer spatial resolution please contact me!




