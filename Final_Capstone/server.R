library(shiny)

## Read in ngram files
corpusngram4table <- read.csv("C:/Users/nwhite/Desktop/Shiny_Capstone/temp.csv")
corpusngram3table <- read.csv("C:/Users/nwhite/Desktop/Shiny_Capstone/temp1.csv")
corpusngram2table <- read.csv("C:/Users/nwhite/Desktop/Shiny_Capstone/temp2.csv")
corpusngram1table <- read.csv("C:/Users/nwhite/Desktop/Shiny_Capstone/temp3.csv")

## Remove x column imported from read.csv
corpusngram4table$X <- NULL
corpusngram3table$X <- NULL
corpusngram2table$X <- NULL
corpusngram1table$X <- NULL

## Break each word in ngrams into separate columns
library(tidyr)
library(dplyr)

## Creating data frame for wordcloud
library(wordcloud)
library(tm)
stopWords <- stopwords("en")
nn <- subset(corpusngram1table, !(corpusngram1table$corpusngram1 %in% stopWords))
nn1 <- nn[1:50,]

shinyServer(
  function(input, output) {
          
          output$plot2 <- renderPlot({
                  layout(matrix(c(1,2), nrow = 2), heights = c(1,4))
                  par(mar = rep(0,4))
                  plot.new()
                  wordcloud(nn1$corpusngram1, nn1$n, scale=c(3,1.5), random.order = FALSE, random.color = FALSE, main = "Title", colors = brewer.pal(8,"Dark2"))
          })

          output$plot3 <- renderPlot({
            ggplot(data=corpusngram4table[1:10,], aes(x=corpusngram4, y=n)) + geom_histogram(stat="identity", fill ="blue") + theme(axis.text.x = element_text(angle = 35))
          })

          output$plot4 <- renderPlot({
            ggplot(data=corpusngram3table[1:10,], aes(x=corpusngram3, y=n)) + geom_histogram(stat="identity", fill ="red") + theme(axis.text.x = element_text(angle = 35))
          })

          output$plot5 <- renderPlot({
            ggplot(data=corpusngram2table[1:10,], aes(x=corpusngram2, y=n)) + geom_histogram(stat="identity", fill ="green") + theme(axis.text.x = element_text(angle = 35))
          })
          
    
    checkSentence <- function(sentence=""){
      lists_of_words <- strsplit(input$id1, split=" ")
      words <- unlist(lists_of_words)
      words22 <- c("jjj","hhh",words)
      
      corpus_4gram_sep2 <- corpus_4gram_sep %>% filter(word1 == words22[length(words22)-2], word2 == words22[length(words22)-1], word3 == words22[length(words22)]) %>% arrange(desc(n))
      results = corpus_4gram_sep2$word4[1]
      
      if ( !all(is.na(results))  ) { 
        return(results[!is.na(results)])             
      }  
      
      corpus_3gram_sep2 <- corpus_3gram_sep %>% filter(word1 == words22[length(words22)-1], word2 == words22[length(words22)]) %>% arrange(desc(n))
      results = corpus_3gram_sep2$word3[1]
      
      if ( !all(is.na(results)) ) {
        return(results[!is.na(results)])
      }  
      
      corpus_2gram_sep2 <- corpus_2gram_sep %>% filter(word1 == words22[length(words22)]) %>% arrange(desc(n))
      results = corpus_2gram_sep2$word2[1]
      
      if ( !all(is.na(results)) ) {
        return(results[!is.na(results)])
      }  
      
      return(c("the"))
    }
    
    
    prediction <- reactive({
      lookup_string <- input$id1
      checkSentence()
    })
    output$words <- renderText({
    paste(prediction())
    })
  }
)


