---
title       : Coursera Capstone Predictive Text App
subtitle    : 
author      : Nino White
job         : 
framework   : revealjs        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
revealjs    : {theme: default, transition: zoom}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
--- 

## Capstone Predictive Text Model

**By: Nino White**


<div style='text-align: center;'>
    <img height='250' src='./Text.jpg' />
</div>

<p>
<p>
<p>
*Date: April 15, 2015*


---

## What Does the App Do

**This is can be used to predict what a user will say next**

**Ttake input (text string) from a user and use an algorithm choose the next most likely word the user wanted to say**

- App can improve typing speed 
- Improved spelling and word accuracy

---

## The Process

*1. Randomly sample corpus: Choose any number of lines to read from each of corpus and combine to one large text file*

*2. Clean and Process Data: Involves removing punctuation, curse words, misspellings, and creating tokens of each string*

*3. Create n-gram: Process to combine groups of words together to form spoken phrases*

*4. Clean-up n-grams and write: Remove al low frequency ngrams and write file to csv to dramatically decrease size*

*5. Seperate n-grams: Seperate each of the n-gram tables so each string is in it's own column in the data frame*

*6. Algorithm: Create algorithm to look into column for matching text then return last word, and back-off when no match is found*

---

## The Prediction

**The Prediction works by:**

- Use input string to lookup n-gram combination

- look first at 4gram model to find a text match

- Trying to match combination of input and gram string

- if no match is found look at trigram until unigram

- If no matches are found return most common word

---

## How to use App:

- app can accessed here

- wait about 20 seconds for data to load

- just start start typing text in the input field

- most likely word will appear after evry input

<div style='text-align: center;'>
    <img height='300' src='./App.png' />
</div>

