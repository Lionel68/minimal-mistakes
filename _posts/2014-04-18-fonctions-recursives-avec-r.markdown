---
title: Fonctions récursives (avec R)
wordpress_id: 269
categories:
- Informatic Language
tags:
- Nerdy
---

Les fonctions récursives sont des fonctions qui s'appellent elle mêmes lors de leurs exécution voir: https://fr.wikipedia.org/wiki/Fonction_r%C3%A9cursive.

Un des challenges posé par Cédric sur son site: http://cedric-pupka.com/?p=117 , nous mets au défi de crée une fonction factorielle qui est récursive.

Voici une solution en R:

    
    #factoriel récursive
    f<-function(x){
      tmp<-1
      if(x>0){
        tmp<-f(x-1)*x
      }
      return(tmp)
    }
    #example
    f(5)
    #test
    factorial(5)  
    


Comprendre le comment du pourquoi que sa marche est plutôt compliqué et brûle les neurones, j'imagine sa comme des poupées russe, lorsqu'on appelle f(3), la fonction
va appelée f(2) qui elle même appelle f(1).

Merci pour le challenge Cédric.
