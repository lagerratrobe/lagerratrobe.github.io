The R practitioners and data scientists that I speak with often work on mixed language teams and have at least a few colleagues using Python already.  They are always interested in finding ways to work more effectively with each other, but often are unaware of existing capabilities for incorporating Python into their own workflows. When they're aware of the possibility, often they are unsure **why** they should do so, or **what situations** lend themselves well to using Python instead of R. This post attempts to capture a use case in which an R user might find Python, via the reticulate R library, to be a useful tool.

## Some Assumptions

If you spend some time coding in R and you will soon come across the following advice...

-   **Looping in R is slow and should be avoided**
-   **Vectorized operations in R are fast and preferred**

Something that doesn't come up as often is that...

-   **Hashes (associative arrays) in R don't really exist**

In my experience, these assumptions are basically true. Yes, it's possible to work around the limitations in some cases, but as we'll see - it's not necessary. Instead, we can use Python and take advantage of the fact that...

-   **Python dictionaries are native and very fast**
-   **Python loops are (relatively) fast**

## Anagram Use Case

I've written in the past on the topic of solving anagrams because I think it's a coding problem that exercises many elements of a language and encourages creative thinking. In looking at a toy problem like this, useful concepts  emerge that extend themselves well to solving other problems. 

The problem can be described as follows.  Given a list of words...

    anemic
    cinema
    iceman
    harks
    Lois
    oils
    shark
    silo
    soil
    soli
    trout
    tutor

...find a way to identify all of the words which share the same letters.  For example...

```
- 'anemic', 'cinema', 'iceman'
- 'harks', 'shark'
- 'Lois', 'oils', 'silo', 'soil', 'soli'
- 'trout', 'tutor'
```

## Indexing as a Solution

An easy way to do this is to index all of the words and create a data structure in which the key is the sorted letters of each word and the values are all words that share those letters - in any combination. As it happens, this "index" looks exactly like a named list in R.

```
list(
'aceimn' = c("anemic", "cinema", "iceman"),
'ahkrs' = c("harks", "shark"),
'ilos' = c("lois", "oils", "silo", "soil", "soli"),
'orttu' = c("trout", "tutor")
)
```

Then, when we want to look up all the words that are anagrams of each other, all we have to do is query the list by using the key.  Like this...

```
key_list[['ilos']]

[1] "lois"  "oil's" "oils"  "silo"  "soil"  "soli" 
```

## The R Challenge

All well and good - we have a conceptual solution and now we just need to implement it.  Assuming our initial set of words live in a file somewhere, a naive R implementation that reads an input file and generates our named list might look something like this.

```
# RgetAnagrams.R

RgetAnagrams <- function(filename = NULL) {
  library(data.table)
  # Create a vector of all the words
  words <- fread(filename, 
                 col.names = c("word"),
                 header = FALSE,
                 stringsAsFactors = FALSE, 
                 encoding = "UTF-8")
  words <- words$word
  
  # Loop through the words, for each word,
  # generate a key and save word and key in key_list
  word_keys <- list()
  for ( i in 1:length(words) ) {
    word <- words[i]
    key <- sapply(word, function(x){paste0(sort(unlist(strsplit(tolower(x), ""))), collapse = "")})
    if ( key %in% names(word_keys) ) {
      word_keys[[key]] <- c(word_keys[[key]], word)
    } else {
      word_keys[[key]] <- word
    }
  }
  return(word_keys)
}
```

And we can test it and see that it behaves as we want.

```
> source("RgetAnagrams.R")
> anagrams <- RgetAnagrams("sample_dict.txt")
> anagrams[['ilos']]
[1] "Lois" "oils" "silo" "soil"
```

The problem is that this solution doesn't scale - at all.  When we use a data set that contains just over 1k words, it's not too bad.

```
> {
+   time_1 <- proc.time()
+   anagrams <- RgetAnagrams("sample_dict.txt")
+   print(proc.time() - time_1)
+ }
   user  system elapsed 
  0.084   0.000   0.083 
> 
```

If however, we point this function at a proper number of words, say just under 100k, we see the following performance.

```
> {
+   time_1 <- proc.time()
+   anagrams <- RgetAnagrams("dict.txt")
+   print(proc.time() - time_1)
+ }
   user  system elapsed 
173.203   0.000 173.105 
```

That's almost 3 minutes!  At this point, we would normally start to look for ways to optimize our code, or pre-process the data so that we don't have to run this operation... etc, etc, blah, blah, blah.  Yes, we could do that, but we don't have to.  

## The Python Solution

Instead, we can code an implementation in Python that does the same thing.  Our solution might look something like this function.

```
# pyGetAnagrams.py

def getAnagrams(file_name):
  import re
  # Read in the words
  with open(file_name) as word_file: 
    word_data = word_file.readlines()
  # Process all the words into their root signatures and matches 
  sig_dict = {}  
  for word in word_data:
    word = word.strip() 
    word = word.lower()
    signature = ''.join(sorted(word))
    if signature not in sig_dict: 
      sig_dict[signature] = [word]
    else:
      sig_dict[signature].append(word)
  return sig_dict
```

Then, from within our R code, we can call on the Python function using the `reticulate` R library.  The code will look very similar to our R code above.

```
> library(reticulate)
> source_python("pyGetAnagrams.py")
> {
+   time1 <- proc.time()
+   anagrams <- getAnagrams("dict.txt")
+   print(proc.time() - time1)
+ }
   user  system elapsed 
  0.301   0.008   0.306 
```

The performance difference is pretty significant.  From...

```
   user  system elapsed 
173.203   0.000 173.105 
```

to...

```
   user  system elapsed 
  0.301   0.008   0.306 
```

## Wrapping Up

In summary, the point of this article isn't to advocate that we change from using R to using Python for our day-to-day work.  There are still very compelling reasons why I continue to use R for most of the data related work that I do.  However, there are occasions when using Python might be a viable way to solve a problem more elegantly than in R.  Given the ease with which we can mix the 2 together in our R code, it makes sense to explore those possibilities when they come up.

`reticulate` is one of the [many](https://www.rstudio.com/about/rstudio-open-source-packages/) Open Source projects that Posit (formerly RStudio) contributes engineering time and resources to.  Additional information on using the `reticulate` can be found here, https://rstudio.github.io/reticulate/.  

