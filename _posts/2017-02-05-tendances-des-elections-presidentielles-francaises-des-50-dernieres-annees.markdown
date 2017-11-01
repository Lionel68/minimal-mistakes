---
title: Tendances des élections présidentielles francaises des 50 dernières années
wordpress_id: 1976
categories:
- Opinion Posts
tags:
- élection
- french
---

[An english version for this article is available [here](http://wp.me/p2SacB-sm)]

Cette année (2017) les Français seront appelés à élire leur prochain président au mois d'avril. Il y a quelque temps j'ai découvert le site open data du gouvernement français où sont publiés de nombreux jeux de données publiques et où tout un chacun est invité à explorer et ré-utiliser ces jeux de données. Dans cet article je vais explorer les tendances spatiales et temporelles des élections présidentielles sous la Vème république en utilisant R, un super logiciel d'exploration et d'analyse de données. Les jeux de données et les scripts sont disponibles [ici](https://github.com/Lionel68/french_election) ainsi qu'au bas de cette page. Je vais commencer par un très bref aperçu des élections présidentielles en France telle qu'elles sont menées depuis 50 ans.


## L'élection présidentielle


Le président français est élu directement par l'ensemble des citoyens depuis 1965. L'élection est à deux tours, les deux candidats avec le plus important nombre de votes au premier tour sont départagés lors d'un second tour, le vainqueur de ce second tour devient le nouveau président. Le président était élu pour 7 ans entre 1965 et 2000, après cette date le mandat présidentiel fut raccourci à 5 ans. Tous les Français de plus de 18 ans et munis de 500 signatures d'élus (député, élu conseil régional ...) peuvent se présenter à l'élection. Environ 10 candidats sont présents au premier tour, le minimum de candidats était 6 en 1965, le maximum 16 en 2002. Si vous êtes intéressés je vous invite à visiter [ce wiki](https://fr.wikipedia.org/wiki/%C3%89lection_pr%C3%A9sidentielle_en_France#R.C3.A9sultats_depuis_1965) très détaillé.


Les principaux courant politiques en France sont : (i) Extrême Gauche, (ii) Socialistes, le principal parti de gauche, (iii) Divers petit partis de gauche, (iv) Écologiste, (v) Centristes, (vi) Divers partis de droite, (vii) Le principal parti de droite qui change de nom très souvent (RPR, UMP, LR) ce qui peut porter à confusion et (viii) Extrême droite qui regroupe des partis populistes et nationalistes comme le Front National.





## Tendances générales




Observons les variations temporelles dans la proportion de vote atteint par chaque courant politique présenté au-dessus. Ces proportions sont calculées en divisant le nombre de votants que reçoit chaque courant par le nombre d'électeurs inscrits. Le nombre d’abstentionnistes (Inscrits - Votants) est additionné à celui du nombre de vote blanc en une seule catégorie de vote protestataire.






![fig1](https://biologyforfun.files.wordpress.com/2017/02/fig1.png)


Quelques élections particulières méritent d'être mentionnées:






	
  * 


1969: de Gaulle démissionne après la victoire du non à un referendum qu'il soutenait. Des élections anticipées sont organisées auxquelles de Gaulle ne se présente pas. Les manifestations de Mai 68 influencent le scrutin (près de 20% de votes communiste) qui verra la victoire de Pompidou.




	
  * 


1974: Pompidou meurt et à nouveau des élections anticipées sont organisées. Les socialistes menés par Mitterrand arrivent en tête au premier tour mais un centriste (Giscard d'Estaing) gagne sur le fil le second tour (50.8 vs 49.2%)




	
  * 


2002: un nombre record de 16 candidats se présentent à l'élection, tout le monde s'attend à un nouveau duel socialiste / droite au second tour, la campagne électorale passionne peu. L'abstention au premier tour atteint un record à 30% et le candidat du FN (Le Pen père) se hisse au second tour en battant le candidat socialiste de 200 000 voix. Lors du second tour le candidat de la droite (Chirac) récolte plus de 80% des voix, du jamais vu.







Plus généralement quelques tendances apparaissent, par exemple les votes centristes et socialistes n'ont cessé de refluer ( à l'exception de 2007) depuis les années 1980. L’extrême droite a progressé avec régularité entre 1974 et 2002, cette progression montre un arrêt en 2007 où le candidat de la droite (Sarkozy) tient un discours pouvant attirer des électeurs du FN. La droite a maintenu une proportion de vote assez constante entre 1974 et 2002 aux alentours de 15%, dans les années 1960 les candidats de la droite ont reçu un très large soutien de la population (plus de 30%), et depuis 2002 le parti reçoit autour de 20% des votes. L'abstention a progressé avec le temps, surtout depuis le début des années 1990. Après le choc de l'élection de 2002 et une campagne très clivante, l'abstention chute sous les 20% en 2002. Lors des dernières élections la droite et les socialistes ont obtenu des scores quasi-identiques, mais l’extrême droite et l'abstention progressaient à nouveau.






## Tendances spatiales




Les données que j'ai utilisé sont disponibles par circonscriptions mais étant donné que celles-ci sont très variables au gré de ré-ajustements divers, j'ai agrégé les données au niveau des départements. Observons d'abord la distribution des votes abstentionnistes:




![fig2](https://biologyforfun.files.wordpress.com/2017/02/fig2.png)


Rien de particulièrement frappant ici, la couleur jaune représente une absence de données. Les départements corses furent crées après 1974 et les départements d’île de France reçoivent leur forme actuelle après 1965. Le seul point marquant c'est le fort taux d'abstention en Ille-et-Vilaine pour les élections de 1981, que s'est-il passé dans la tête des Rennais?




Des cartes similaires peuvent être crées pour chaque mouvement politique (voir candidats), je vais en faire une autre pour l’extrême droite:




![fig3](https://biologyforfun.files.wordpress.com/2017/02/fig31.png)


En 1965 l’extrême droite était surtout implantée le long de la Côte d'Azur et était très peu présente dans le centre et le nord de la France. Le Pen (père) crée le FN qui participe pour la première fois à une élection présidentielle en 1974, las il obtient moins de 1% de vote. En 1981 Le Pen (père) ne se présentera pas, mais en 1988 le FN obtient plus de 10% de vote et au bastion traditionnel de la Côte d'Azur viens s'ajouter le nord-est et plus particulièrement l'Alsace-Moselle. Les élections de 1995 et 2002 voient le succès du FN s'étendre à d'autres départements surtout le long du Rhône et dans le Nord avec des taux autour de 15%. L'élection de 2007 stoppe cette dynamique, mais elle repart en 2012 où on voit de nouveaux départements présentant un fort soutien au FN comme les départements de Champagne, de Lorraine et de Picardie.




Une dernière figure pour la route, agrégeant les données par région et montrant la dynamique pour les principaux courants politiques (plus abstention):






![fig4](https://biologyforfun.files.wordpress.com/2017/02/fig42.png)


Plein de choses à dire, j'en retient 4:






	
  * 


Les électeurs alsaciens étaient fan de de Gaulle, il a reçu plus de 50% des voix lors du premier tour en 64!




	
  * 


L’abstention a augmenté pour toutes les régions entre 1974 et 2002, mais cette augmentation est particulièrement marquante dans les régions du Nord et du Nord-Est comme la Picardie ou la Lorraine mais aussi l'Île-de-France




	
  * 


Les socialistes ont subi un important reflux de vote entre 1974 et 2002, le Nord-Pas-de-Calais votaient à plus de 40% socialiste en 1974, en 2002 plus que 10% des électeurs votaient pour eux.




	
  * 


L’extrême droite a progressé dans toutes les régions, en Alsace et PACA les votes FN semblent atteindre un plateau autour de 20% entre 1988 et 2002.







## Que nous réserve l'élection de 2017?




Bien malin qui sera répondre à cette question ... Les deux-trois tendances émergeant des élections passées peuvent un peu nous aider. Comme en 2002 la gauche se présente en ordre dispersé à l'élection, au moins 6 candidats de la gauche devraient se présenter. À droite un seul candidat majeur reste en lice après la première primaire de la droite qui a vu Sarkozy se faire battre par son ancien premier ministre (Fillon). À l’extrême droite, Le Pen (fille) a évincé Le Pen (père) du parti (il continuait à tenir des propos antisémites le bougre), afin de terminer le polissage de l'image du FN qui veut se présenter comme un parti respectable.




Qui a dit que la politique était ennuyeuse?




Script complet:

    
    ##############################
    #Exploring patterns in 40 years
    #of french presidential election
    ###########################
    
    #Data are fom:
    #Résultats des élections présidentielles 1965-2012, PRESIDENTIELLES1965-2012.zip [fichier informatique], 
    #Grenoble : Banque de Données Socio-Politiques, Paris : Ministère de l’Intérieur, France [producteurs], 
    #Centre de Données Socio-Politiques [diffuseur], 2014.
    
    #Original data available here: https://www.data.gouv.fr/fr/datasets/elections-presidentielles-1965-2012-1/
    #Modified data used in this post available here: 
    
    #Shapefiles are available here: http://gadm.org/
    #select France, R -SpatialPolygon and Level 2 data
    
    #load the libraries
    library(plyr)
    library(stringr)
    library(reshape2)
    library(tidyverse)
    library(sp)
    library(rgdal)
    library(viridis)
    
    #set working directory
    setwd("Desktop/Blog/Election/")
    #list files
    li<-list.files(pattern="cdsp")
    
    #loop through the files and format them
    dat%
        mutate(Abstention=(Inscrits-Votants)+Blancs)%>%
        rename(Dep_ID=`Code département`)%>%
        select(-(5:7))%>%
        gather(Candidats,Nombre,-(Dep_ID:Inscrits),-Year)%>%
        group_by(Dep_ID,Candidats,Year)%>%
        summarise(Nombre=sum(Nombre),Inscrits=sum(Inscrits))%>%
        mutate(Prop=Nombre/Inscrits)->tmp2
      tmp2$Candidats<-gsub(" \\(.*$","",tmp2$Candidats)
      tmp2$Dep_ID<-str_pad(tmp2$Dep_ID,2,side="left",pad="0")
      dat<-rbind(dat,tmp2)
    }
    #put candidate names in small caps
    dat$Candidats<-str_to_title(dat$Candidats)
    #correct one candidate name
    dat$Candidats[grep("Villier",dat$Candidats)]<-"de Villiers"
    #add the general political movement of each candidate
    cand_list<-read.table("courant.csv",sep=",",header = TRUE,stringsAsFactors = FALSE)
    #merge with the data
    dat2<-merge(dat,cand_list,by.x=c("Candidats","Year"),by.y=c("Name","Year")) #get total number of potential voters per year dat2%>%
      filter(Candidats=="Abstention")%>%
      group_by(Year)%>%
      summarise(Tot_inscrit=sum(Inscrits))->tot_inscrit
    
    
    dat2%>%
      group_by(Year,Courant)%>%
      summarise(Nombre=sum(Nombre))%>%
      left_join(tot_inscrit,by="Year")%>%
      mutate(Prop=Nombre/Tot_inscrit)->dat_time
    
    col_courant<-c("#333300","#ff9900","#99ccff","#ff99ff","#0000ff","#33cc33","#001a33","#ff0000","#ff6666")#choose better colors
    #plot per movement
    ggplot(dat_time,aes(x=Year,y=Prop,color=Courant))+geom_path(size=1.5)+
      scale_color_manual(values=col_courant)+labs(y="Proportion of voters")
    
    
    #load shapefile
    fr<-readRDS("FRA_adm2.rds")
    
    #re-arrange data for interation by courant into the polygon dataframe
    dat2$Courant<-gsub(" ","_",dat2$Courant)
    dat3<-dcast(dat2,formula = Dep_ID~Courant+Year,value.var = "Prop",fun.aggregate = sum)
    #merge to the spatial data
    fr2<-merge(fr,dat3,by.x="CCA_2",by.y="Dep_ID")
    #plot the spatial patterns of abstention over the years
    spplot(fr2,zcol=paste("Abstention",c(1965,1969,1974,1981,1988,1995,2002,2007,2012),sep="_"),col.regions=rev(viridis(100)),col="white",
           names.attr=c("1965","1969","1974","1981","1988","1995","2002","2007","2012"),main="Proportion of Abstention")
    #plot the spatial patterns of far right vote over the years
    spplot(fr2,zcol=paste("Extreme_Droite",c(1965,1974,1988,1995,2002,2007,2012),sep="_"),col.regions=rev(inferno(100)),col="white",
           names.attr=c("1965","1974","1988","1995","2002","2007","2012"),main="Proportion of vote for the Far Right")
    
    #look at temporal patterns per regions and focusing on the main courant
    dat2<-merge(dat2,fr@data[,c("NAME_1","NAME_2","CCA_2")],by.x="Dep_ID",by.y="CCA_2") #first get per region and year the total number of potential voter dat2%>%
      filter(Candidats=="Abstention")%>%
      group_by(Year,NAME_1)%>%
      summarise(Tot_inscrit=sum(Inscrits))->tot_inscrit_reg
    #then add this to the data and compute the proportions
    dat2%>%
      group_by(Year,NAME_1,Courant)%>%
      summarise(Nombre=sum(Nombre))%>%
      left_join(tot_inscrit_reg,by=c("Year","NAME_1"))%>%
      mutate(Prop=Nombre/Tot_inscrit)%>%
      filter(Courant%in%c("Abstention","Centriste","Droite","Extreme_Droite","Socialiste"))->dat_reg
    dat_reg$NAME_1<-gsub("-","-\n",dat_reg$NAME_1)
    #ggplot2 thene
    theme_el<-theme(legend.position = "bottom",panel.background = element_rect(fill="white",color=NA),
                    panel.grid.major.y = element_line(linetype="dashed",color="black"),
                    panel.border=element_rect(color="black",fill=NA),axis.text.x=element_text(size=7),
                    strip.background = element_rect(fill = "grey85",colour = "grey20"), legend.key = element_rect(fill = "white",colour = NA))
    #the plot
    ggplot(dat_reg,aes(x=Year,y=Prop,color=Courant))+
      geom_path(size=2)+facet_grid(Courant~NAME_1)+
      scale_x_continuous(breaks=c(1970,1990,2010))+
      theme_el



