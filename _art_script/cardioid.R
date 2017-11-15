#create 4 ways cardioid using segments

#the function
cardioid <- function(n=25,radius=1,cex.pt=1,cst=0,add=FALSE){
  #the number of point on the circle
  n_p <- 2 * n
  #the angle of the points
  thetas <- (2 * pi * (1:n_p / n_p)) + cst
  #the coords of the points
  xy <- data.frame(x=radius * cos(thetas),y=radius*sin(thetas))
  #the points to connect
  ll <- data.frame(from=c(1:n,n + (1:n)),to=c(2 * 1:n,2 * 1:n))
  #the output
  out <- list(xy,ll)
  if(!add){
    print(plot(y~x,xy,asp=1,xlab='',ylab='',xaxt='n',yaxt='n',pch=16,bty='n',cex=cex.pt))
  }
  print(segments(xy[ll$from,1],xy[ll$from,2],xy[ll$to,1],xy[ll$to,2],lwd=25/n))
  return(out)
}

png('cardioid.png',width=800,height=800)
cardioid(n=50)
cardioid(n=50,cst=pi/2,add=TRUE)
cardioid(n=50,cst=pi,add=TRUE)
cardioid(n=50,cst=3*pi/2,add=TRUE)
dev.off()

png('cardioid3.png',width=800,height=800)
cardioid(n=200)
cardioid(n=150,cst=pi/2,add=TRUE)
cardioid(n=100,cst=pi,add=TRUE)
cardioid(n=50,cst=3*pi/2,add=TRUE)
dev.off()

png('cardioid4.png',width=800,height=800)
cardioid(n=200)
cardioid(n=200,cst=pi,add=TRUE)
dev.off()

