#playing with igraph
gg<-graph_from_adjacency_matrix(matrix(1,20,20),diag = FALSE,mode="undirected")


png("igraph1.png",width=800,height=800)
par(bg="violetred4",mar=c(1,1,1,1))
plot.igraph(gg,layout=layout_in_circle,vertex.size=0,vertex.label=NA,vertex.color=NA)
dev.off()

gg<-graph_from_adjacency_matrix(matrix(1,25,25),diag = FALSE,mode="undirected")

png("igraph2.png",width=800,height=800)
par(bg="snow1",mar=c(1,1,1,1))
plot.igraph(gg,layout=layout_in_circle,vertex.size=0,vertex.label=NA,vertex.label.cex=2,vertex.shape="none",edge.color="darkgoldenrod3")
dev.off()


gg<-graph_from_adjacency_matrix(matrix(1,10,10),diag = FALSE,mode="undirected")
gg2<-graph_from_adjacency_matrix(matrix(1,15,15),diag = FALSE,mode="undirected")
gg3<-graph_from_adjacency_matrix(matrix(1,20,20),diag = FALSE,mode="undirected")

xy2 <- layout_in_circle(gg2)
xy2 <- apply(xy2,2,function(x) 0.75 * (x - 1) + 0.75)

xy3 <- layout_in_circle(gg3)
xy3 <- apply(xy3,2,function(x) 0.5 * (x - 1) + 0.5)

png("igraph3.png",width=800,height=800)
par(bg="snow2",mar=c(1,1,1,1))
plot.igraph(gg,layout=layout_in_circle,vertex.size=0,vertex.label=NA,vertex.label.cex=2,vertex.shape="none",edge.color="chocolate")
plot.igraph(gg2,layout=xy2,vertex.size=0,vertex.label=NA,vertex.label.cex=2,vertex.shape="none",edge.width=0.95,edge.color="gold",add=TRUE,rescale=FALSE)
plot.igraph(gg3,layout=xy3,vertex.size=0,vertex.label=NA,vertex.label.cex=2,vertex.shape="none",edge.width=0.75,edge.color="yellow",add=TRUE,rescale=FALSE)
dev.off()
