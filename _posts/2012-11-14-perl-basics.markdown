---
slug: perl-basics
title: Perl Basics
wordpress_id: 37
categories:
- Informatic Language
tags:
- Informatics
- Perl
---

``


## What is Perl?




Perl is an informatics language that is widely used in Bioinformatics, it is rather easy to use and very powerful for certain tasks like calculating the GC content of a sequence, translating DNA to RNA and more advanced stuff that I don't know yet.




## How do I install Perl?




If you work on a unix machine (Linux or Mac) then Perl is already installed, if you work on a windows machine you can download perl from here: [http://www.perl.org/get.html](http://www.perl.org/get.html).




## How does it work?




As in other programming language, in perl you start by writing a script in a text editor like gedit or Notepad++ and then you run this script in your terminal and if you worked well the computer will understand what you asked for and execute your command.

So write the following line in a text editor:



print "Hello World!\n";



Then save it under a name in a specific file, let's say 01.pl ; after saving it you will notice that the colours changed your text editor understood that you were speaking in perl language and labelled the different part of the command.

Now we have to open the terminal and go to the directory where you saved your script using the cd command (universal command work in all machine irrespective of your OS);



lionel@Lordi:~$ cd Documents/ 

lionel@Lordi:~/Documents$ perl 01.pl 

Hello World! 



So again first I went to the directory where the script was saved and then I launched it using the command “perl” followed by the name of the file, then press Enter and your first code executed with success.

The command we wrote told the computer to print “Hello World!” onto the screen and to go to the next line after the printing, this is done by the newline character “\n”.


## Scalar Variables;


These specials variables are container were we put one element/object, this can be one number, this can be an entire book, this can be a complex mathematical operation but this has to be ONE element.

So let's create a few variable and print them onto the screen:



$text = 'I love learning Perl!'; 

$number = 3; 

$operation = (45+56)/(34*6); 



print $text,"\n"; 

print $number,"\n"; 

print $operation,"\n";

A few things :

-Every line of code MUST be separated by semi colon “;” , this is the No 1 mistake in every script.

-Text must be put under quotes wether simple ' ' or double " " , text elements are called string.

-A scalar variable start with a dollar sign and is followed by the name of the variable, the name must start with a letter.

-To assign a value (wether a number, string or whatever) to a variable we use the equal sign “=”.



Let's run this code:

lionel@Lordi:~/Documents$ perl 01.pl 

I love learning Perl! 

3 

0.495098039215686 



Let's do a further example to understand the difference between single and double quotes:



$text = 'I love learning Perl!'; 



print "Every student said: $text \n"; 

print 'Every student said: $text \n'; 



$text2 = 'I \n love \n learning \n Perl!'; 

$text3 = "I \n love \n learning \n Perl!"; 



print $text2,"\n"; 

print $text3,"\n";



Which give:

lionel@Lordi:~/Documents$ perl 01.pl 

Every student said: I love learning Perl! 

Every student said: $text \nI \n love \n learning \n Perl! 

I 

love 

learning 

Perl! 



When we put double quotes in the first print statement, perl replace “$text” with the content that we stored in this variable, in the second print statement perl printed literally what we entered, this mean that even the newline character was interpreted literally and so printed onto the screen. Then directly after it came the third print statement where we ask to print the content of text2 which contain newline character but they are interpreted as text and printed onto the screen.

So to remember, every time you want to use newline character or invoke previously stored variables use double quotes otherwise use the single quote.




## Working with strings;




Two useful operators when working with strings: “.” the concatenation operator and “x” the repetition operator, let's say you want to store in a variable 35 A's and add them to a DNA sequence for example:



$dna = 'ATGCATGC'; 

$A = 'A' x 35; 

$dna_a = $dna.$A; 



print $dna_a,"\n";



So first we created a scalar variable containing a string (characters), then we created a second scalar variable that contain 35 A's and then we put them together, let's look at the output:



lionel@Lordi:~/Documents$ perl 01.pl 

ATGCATGCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 



We learned about the newline character: “\n” that tell the terminal to jump a line anytime it see one, but there are other special character, ready to meet them?



$dna = 'AtgTgATGCAG'; 



print $dna,"\t","\U$dna\E","\t","\L$dna\E","\n"; 

print "He said \"Perl is so great\"\n";



Here we defined a scalar variable containing a string, then we printed it three times separated by tab “\t”, one is printed as defined, the other is printed in upper case letter between “\U” and “\E” and the final one in lower case letter between “\L” and “\E”. These upper-lower case special character work between boundaries first you say where to start the upper-lower casing (\U or \L) and then you say where to stop it (\E). The second print statement is to introduce escaping: this is when you want some special characters to appear on the screen (like “, ' , # ,\ ….) and you don't want perl to interpret them as command, you need to escape them so that they are interpreted as characters. To do this you put a backslash symbol in front of them.



lionel@Lordi:~/Documents$ perl 01.pl 

AtgTgATGCAG ATGTGATGCAG atgtgatgcag 

He said "Perl is so great" 




## Substituting and Transliterating;




You wrote a letter to a certain Mr. John but you forgot to put the Mr. , what you can do is tell perl to subsitute every occurrence of “John” in a string with “Mr. John” ;



$text = 'And John turned and look, then John went to the pool and Lucie saw him, but jOhN was wearing sunglasses'; 

$text =~ s/John/Mr. John/; 

print $text,"\n"; 



$text = 'And John turned and look, then John went to the pool and Lucie saw him, but jOhN was wearing sunglasses'; 

$text =~ s/John/Mr. John/g; 

print $text,"\n"; 



$text = 'And John turned and look, then John went to the pool and Lucie saw him, but jOhN was wearing sunglasses'; 

$text =~ s/john/Mr. John/gi; 

print $text,"\n";



Before the explanations let's see what's the output:





lionel@Lordi:~/Documents$ perl 01.pl 

And Mr. John turned and look, then John went to the pool and Lucie saw him, but jOhN was wearing sunglasses 

And Mr. John turned and look, then Mr. John went to the pool and Lucie saw him, but jOhN was wearing sunglasses 

And Mr. John turned and look, then Mr. John went to the pool and Lucie saw him, but Mr. John was wearing sunglasses 



In the first block only the first John was substituted with Mr. John, in the second one the two John were replaced but not the jOhN, in the last one all were replaced. This function works like this:

$string =~ s/Pattern/Replacement/; the “=~” is called the binding operator; as a default setting perl only replace the first occurrence of the pattern, if we had a “g” perl will replace every occurrence; and if we had a “i” it will be case insensitive (you could write JOHN, john … in the pattern).



Every Biologists will need at some point to turn some DNA code into the complement RNA, this can be done by the transliterating operator that change the alphabet use, here is the code:



$DNA = 'ATGGCATTAGC'; 

$DNA =~ tr/ATGC/UACG/; 



print $DNA,"\n";



With this code every 'A' in the variable DNA will be turned into 'U', every 'T' into 'A' and so on..

So perl replace the first character in the Pattern zone by the first character in the Replacement zone, and so on. Again as with the substitute operator we have to use the binding operator. The output of this code is:



lionel@Lordi:~$ perl 01.pl 

UACCGUAAUCG 



The transliterating operator doesn't accept 'g' or 'i' , the difference between the tr/// and s/// operator is that the first change between alphabet so every occurrence in the Pattern zone will be turned with the corresponding character in the Replacement zone, the second one transform a Pattern into a Replacement in this case both are treated as a whole and not as separated characters.



A very useful aspect of s/// and tr/// is that they return the number of replacement, let's see this in action:



$text = 'And John turned and look, then John went to the pool and Lucie saw him, but jOhN was wearing sunglasses'; 

$count1 = ($text =~ s/john/Mr. John/gi); 

print $count1,"\n"; 



$DNA = 'ATGGCATTAGC'; 

$count2 = ($DNA =~ tr/ATGC/UACG/); 

print $count2,"\n"

    
     
    lionel@Lordi:~/Documents$ perl 01.pl 
    3 
    11




The variable is still transformed but now we have access to the number of time an element was transformed, we will use this propriety in later post.






## To sum up:


-Perl is widely use in Bioinformatics

-We can create scalar variable using '$' followed by a name

-We can assign value to a variable using '='

-A scalar variable contain only one element, it can be an entire book or one number

-There are several special characters: '\n' to jump a line, '\t' to make a tab, '\U .. \E' to turn characters into upper case and '\L .. \E' to turn into lower case.

-Strings (characters) must be put between quotes

-Single quotes are interpreted literally

-Double quotes allow you to invoke variables, use special characters

-We can add strings together using '.' and we can repeat characters using 'x'

-The substitute operator turn a pattern into its replacement, 'g' substitute every occurrence, and 'i' allow the substitution to be case insensitive

-The transliterating operator change the alphabet used.



Hope you enjoyed, next will come wonderful things like conditional blocks, loops, arrays, data input and output and much more.
