#  Install Requried Packages
install.packages("SnowballC")
install.packages("tm")
install.packages("twitteR")
install.packages("syuzhet")
install.packages("openssl")
install.packages("httpuv")
install.packages("rlang")

# Load Requried Packages
library("SnowballC")
library("tm")
library("twitteR")
library("syuzhet")
library("openssl")
library("httpuv")
library("rlang")

#developer Details
consumer_key <- 'i8tW2k6CedE3tXnKVmxFjvRrn'
consumer_secret <- 'KcBfND3kWWWdi7N0ElqcqfxrUErf8QFi2u5v4E30IvhbQNfd5E'
access_token <-"2870931260-sM4CszJR8WIbzqd3MqcLlwa7JFLWQQaI7sHv5kM"
access_secret <-"HShC3Y0n4YrBZlYFEcczCoc4O4KQ7cUVxcfqWhexuxbwi"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

#Tweets related to @DublinTenants handler
#Retrieve a specific user’s most recent posts on Twitter.
#user – A character string of a username.
#n – The number of messages to retrieve.
tweets <- userTimeline("DublinTenants", n=200)
n.tweet <- length(tweets)

tweets.df <- twListToDF(tweets) 
head(tweets.df)

tweets.df2 <- gsub("http.*","",tweets.df$text)

tweets.df2 <- gsub("https.*","",tweets.df2)

tweets.df2 <- gsub("#.*","",tweets.df2)

tweets.df2 <- gsub("@.*","",tweets.df2)


word.df <- as.vector(tweets.df2)

emotion.df <- get_nrc_sentiment(word.df)

emotion.df2 <- cbind(tweets.df2, emotion.df) 

head(emotion.df2)

#Positive Tweets
sent.value <- get_sentiment(word.df)
most.positive <- word.df[sent.value == max(sent.value)]
most.positive

#Negative Tweets
sent.value <- get_sentiment(word.df)
most.negative <- word.df[sent.value <= min(sent.value)] 
most.negative 


positive.tweets <- word.df[sent.value > 0]
negative.tweets <- word.df[sent.value < 0]
neutral.tweets <- word.df[sent.value==0]


print(neutral.tweets)

