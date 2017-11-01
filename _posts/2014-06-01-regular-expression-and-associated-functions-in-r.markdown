---
title: Regular expression and associated functions in R
wordpress_id: 287
categories:
- R and Stat
tags:
- Perl
- R
---

When working with strings regular expressions are an extremely powerful tool to look for specific patterns in the strings. In informatics a string is several characters put together, this can be words, sentences, or DNA code. Regular expression were developed in the fifties (thanks to Jeff Newmiller comment) by computer scientists (https://en.wikipedia.org/wiki/Regular_expression) and I discovered them using Perl (http://www.perl.org/). They have also been implemented in various other programming languages due to their nice functionalities. Here I will present the functions in R that use regular expression and will present some general use of regular expression in ecology. As always a cleaner version of the post is available at: http://rpubs.com/Lionel/19068


    
    #regular expression functions, there are 7 functions that can use regular expression
    ?grep
    


These functions will look for a certain pattern in the provided string(s), that may be a vector of strings.

    
    
    # example using grep
    words <- c("abc", "Cde", "Truc", "Machin")  #a vector of string
    grep("c", words)  #looking for 'C' in each element of the vector, this return the index of the element in the vector containing the pattern ('C')
    grep("c", words, value = TRUE)  #same but return the element of the vector containing the pattern
    # by default grep is case-sensitive, can be turned to case-insensitive
    grep("C", words, ignore.case = TRUE)
    # example using grepl
    grepl("c", words)  #return a vector of logical indicating if the pattern was found in the elements of the vector
    # example using sub and gsub, these two function replace the pattern by a
    # replacement value specified by the user
    species <- c("Rattus_domesticus", "Formica_rufa", "Germanium_pratense_germanica")
    sub("_", " ", species)  #sub will only replace the first occurence of the pattern in the string
    gsub("_", " ", species)  #gsub will replace all occurences
    # example using regexpr and gregexpr
    species <- c("Onthophagus_vacca", "Copris_hispanus", "Carabus_hispanus_hispanus")
    regexpr("hisp", species)  #regexpr return the position in the string of the first occurence of the pattern as well as the length of the pattern matched
    gregexpr("hisp", species)  #gregexpr will return the position of all matched occurence of the pattern
    regexec("hisp", species)  #similar as regexpr but with a different output formatting
    



As seen in the few examples above when we have a clear idea of what the pattern is that we want to match we can just use it for the pattern argument in the functions. However sometimes we do not know the exact form of the pattern or we want to match at one time several closely related strings, this is where regular expressions come into play. They are an abstracted way to represent the different element (letters, digits, space …) present in the strings.


    
    
    # the regular expression help page in R
    ?regex
    # regular expression with 5 different strings
    words <- c("Bonjour", "Bienvenue", "Au revoir", "A la bonne heure", "2 heures")
    #'\\w' will match any letters (a-z) present in the strings
    grep("\\w", words)  #there are letters in all elements of the string
    # now if we want to keep only elements having exactly 7 letters we use:
    grep("\\w{7}", words)
    # we can also match digits using '\\d', space '\\s' and their negation:
    # '\\W','\\D','\\S' could you guess what the coming regular expression
    # will match?
    grep("\\w{2}\\W\\w+", words, value = TRUE)
    # by placing '^' we match from the beginning of the string, similarly $ will
    # match the end
    grep("^\\w{2}\\W\\w+$", words, value = TRUE)
    # a last one using '\\d'
    grep("\\d\\W\\w+", words, value = TRUE)
    



Several comments, using {n} will look for a string where the item is matched n times, {n,} matched n or more times, {n,m} matched at least n times but no more than m times. We can also use + for matching an item one or more times and * for matching zero or more times. Have a look at ?regex where everything is explained in length.

Now I used regular expression most of the time to specifically format labels or species names, this is where gsub in combination with regular expression become very handy. For example:


    
    
    # We have three labels with a plot ID BX followed by a genus species
    # information with 3 letters each (Poatri = Poa trivialis), we would like to
    # have the first letter for the genus and the species as upper-case
    species <- c("B1_Poatri", "B2_PlaLan", "B3_lAtPRA")
    # in sub and gsub we can put part of the pattern between parentheses to call
    # it in the replacement argument
    gsub(".{5}(\\w{1}).*", "\\1", species)
    # now we use the argument perl=TRUE to use the \\U and \\L special
    # symbols that set the following letters to upper and lower-case
    # respectively
    gsub("(.{3})(\\w{1})(\\w{2})(\\w{1})(\\w{2})", "\\1\\U\\2\\L\\3\\U\\4\\L\\5", 
        species, perl = TRUE)
    



Here is the end of this first overview of regular expression in R, I used them quite often for formatting strings when I don't want to spend hours with calc. There are many subtleties not covered here (UTF-8 mode, perl mode …) but these informations should be enough to get everyone started.
