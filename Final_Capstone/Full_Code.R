## Read files and create connection
file_path = "C:/Documents and Settings/nwhite/Desktop/en_US/en_US.blogs.txt"
blogcon <- file(file_path, "r")
file_path1 = "C:/Documents and Settings/nwhite/Desktop/en_US/en_US.news.txt"
newscon <- file(file_path1, "r")
file_path2 = "C:/Documents and Settings/nwhite/Desktop/en_US/en_US.twitter.txt"
twittercon <- file(file_path2, "r")

## Reads sepcifid line number from con object
blogsample <- readLines(file_path, 30000)
newssample <- readLines(file_path1, 30000)
twittersample <- readLines(file_path2, 30000)

## Combine corpus into one large file of the text
corpus <- c(blogsample, newssample, twittersample)

## Convert to lowercase
corpus <- tolower(corpus)

## Remove Punctuation
library(tm)
corpus <- removePunctuation(corpus, preserve_intra_word_dashes = TRUE)

## Create tokens of strings
corpustokens <- scan_tokenizer(corpus)

## Count the number of tokens/words in corpora
length(corpustokens)

## Establish profanity list
profanity <-  c('anal',
                'arse',
                'ballsack',
                'bastard',
                'biatch',
                'blowjob',
                'blow job',
                'bollock',
                'bollok',
                'boner',
                'boob',
                'bugger',
                'buttplug',
                'clitoris',
                'coon',
                'cunt',
                'dildo',
                'dyke',
                'feck',
                'fellate',
                'fellatio',
                'felching',
                'fuck',
                'fudgepacker',
                'flange',
                'Goddamn',
                'homo',
                'jerk',
                'jizz',
                'knobend',
                'labia',
                'lmao',
                'lmfao',
                'muff',
                'nigger',
                'nigga',
                'poop',
                'prick',
                'pube',
                'queer',
                'sh1t',
                'slut',
                'smegma',
                'spunk',
                'tit',
                'tosser',
                'twat',
                'wank',
                'whore',
                'wtf ')

## Remove profanity from text
corpustokens1 <- removeWords(corpustokens, profanity)


## Remove letters classified as tokens
corpustokens1 <- removeWords(corpustokens1, c("[b-h]","[j-z]"))

## Remove empty strings created by tokenization
tobeRemoved <- which(corpustokens1=="")
corpustokens1 <- corpustokens1[-tobeRemoved]

## intall dplyr package
library(dplyr)

## create data frame of all tokens
corpusdf <- data_frame(Word = corpustokens1)

## Sort dataframe in descending order
corpusdf1 <- corpusdf %>% count(Word) %>% arrange(desc(n)) %>% rename(Frequency = n)
corpusdf1[1:20,]

## Creating ngrams
library(stylo)
corpusngram1 <- make.ngrams(corpustokens1, ngram.size = 1)
corpusngram2 <- make.ngrams(corpustokens1, ngram.size = 2)
corpusngram3 <- make.ngrams(corpustokens1, ngram.size = 3)
corpusngram4 <- make.ngrams(corpustokens1, ngram.size = 4)

## tabling ngram4 model
corpusngram4table <- data_frame(corpusngram4)
corpusngram3table <- data_frame(corpusngram3)
corpusngram2table <- data_frame(corpusngram2)
corpusngram1table <- data_frame(corpusngram1)

## Create table in descending order of ngram tables
corpusngram4table2 <- corpusngram4table %>% count(corpusngram4) %>% arrange(desc(n))

corpusngram3table2 <- corpusngram3table %>% count(corpusngram3) %>% arrange(desc(n))

corpusngram2table2 <- corpusngram2table %>% count(corpusngram2) %>% arrange(desc(n))

corpusngram1table2 <- corpusngram1table %>% count(corpusngram1) %>% arrange(desc(n))

## subset data frame to get size smaller
gg <- subset(corpusngram4table2, corpusngram4table2$n > 1)
kk <- subset(corpusngram3table2, corpusngram3table2$n > 1)
ff <- subset(corpusngram2table2, corpusngram2table2$n > 1)
dd <- subset(corpusngram1table2, corpusngram1table2$n > 1)


## Write ngram files to csv
write.csv(gg, "temp.csv")
write.csv(kk, "temp1.csv")
write.csv(ff, "temp2.csv")
write.csv(dd, "temp3.csv")

## Read in ngram files
corpusngram4table <- read.csv("C:/Documents and Settings/nwhite/Desktop/Capstone Project/4-13 Testing/temp.csv")
corpusngram3table <- read.csv("C:/Documents and Settings/nwhite/Desktop/Capstone Project/4-13 Testing/temp1.csv")
corpusngram2table <- read.csv("C:/Documents and Settings/nwhite/Desktop/Capstone Project/4-13 Testing/temp2.csv")
corpusngram1table <- read.csv("C:/Documents and Settings/nwhite/Desktop/Capstone Project/4-13 Testing/temp3.csv")
# 
# ## Remove x column imported from read.csv
corpusngram4table$X <- NULL
corpusngram3table$X <- NULL
corpusngram2table$X <- NULL
corpusngram1table$X <- NULL
# 
# ## Break each word in ngrams into separate columns
library(tidyr)
library(dplyr)

corpus_4gram_sep <- corpusngram4table %>% separate(col = corpusngram4, into=c("word1", "word2", "word3", "word4"), sep=" ")

corpus_3gram_sep <- corpusngram3table %>% separate(col = corpusngram3, into=c("word1", "word2", "word3"), sep=" ")

corpus_2gram_sep <- corpusngram2table %>% separate(col = corpusngram2, into=c("word1", "word2"), sep=" ")

corpus_1gram_sep <- corpusngram1table %>% separate(col = corpusngram1, into=c("word1"), sep=" ")
# 
# ## Predict next word; change input value to and check next word by entering checkSentence()
# 
input <- "we are the"

checkSentence <- function(sentence=""){
  lists_of_words <- strsplit(input, split=" ")
  words <- unlist(lists_of_words)
  words22 <- c("jjj","hhh",words)
  
  corpus_4gram_sep2 <- corpus_4gram_sep %>% filter(word1 == words22[length(words22)-2], word2 == words22[length(words22)-1], word3 == words22[length(words22)]) %>% arrange(desc(n))
  results = corpus_4gram_sep2$word4[1:3]
  
  if ( !all(is.na(results))  ) { 
    return(results[!is.na(results)])             
  }  
  
  corpus_3gram_sep2 <- corpus_3gram_sep %>% filter(word1 == words22[length(words22)-1], word2 == words22[length(words22)]) %>% arrange(desc(n))
  results = corpus_3gram_sep2$word3[1:3]
  
  if ( !all(is.na(results)) ) {
    return(results[!is.na(results)])
  }  
  
  corpus_2gram_sep2 <- corpus_2gram_sep %>% filter(word1 == words22[length(words22)]) %>% arrange(desc(n))
  results = corpus_2gram_sep2$word2[1:3]
  
  if ( !all(is.na(results)) ) {
    return(results[!is.a(results)])
  }  
  
  return(c("the", "to", "you"))
}
# 
# ## Creating Word Cloud ##
# 
library(wordcloud)
library(tm)
stopWords <- stopwords("en")
nn <- subset(corpusngram1table, !(corpusngram1table$corpusngram1 %in% stopWords))
nn1 <- nn[1:50,]

layout(matrix(c(1,2), nrow = 2), heights = c(1,4))
par(mar = rep(0,4))
plot.new()
text(x = .5, y = .05, "Test Common Corpus Non-StopWords")
wordcloud(nn1$corpusngram1, nn1$n, scale=c(3,0.5), random.order = FALSE, random.color = FALSE, main = "Title", colors = brewer.pal(8,"Dark2"))
# 
# ## End process of Wordcloud
# 
# ## Creating Plots
# 
library(ggplot2)
ggplot(data=corpusngram4table[1:10,], aes(x=corpusngram4, y=n)) + geom_histogram(stat="identity", fill ="blue") + ggtitle("Top 10 Blog 4Grams") + theme(axis.text.x = element_text(angle = 35))

ggplot(data=corpusngram3table[1:10,], aes(x=corpusngram3, y=n)) + geom_histogram(stat="identity", fill ="red") + ggtitle("Top 10 Corpus TriGrams") + theme(axis.text.x = element_text(angle = 35))

ggplot(data=corpusngram2table[1:10,], aes(x=corpusngram2, y=n)) + geom_histogram(stat="identity", fill ="green") + ggtitle("Top 10 Corpus BiGrams") + theme(axis.text.x = element_text(angle = 35))
