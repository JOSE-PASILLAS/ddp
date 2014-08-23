library(shiny)
library(UsingR)
library(caret)
data(reaction.time)

process<-function(features) {
  #reaction<-reaction.time[,c(as.numeric(features),4)]
  reaction<-subset(reaction.time,select=c(features,"time"))
 
  set.seed(123)
  nsample<-sample(1:nrow(reaction), 18)
  train_set<-reaction[-nsample,]
  test_set<-reaction[nsample,]
  #print(head(test_set))
  #train$Sex<-as.numeric(train$Sex)
  modFit<-train(time~.,method="rpart",data=train_set)
  fit<-modFit$finalModel
  
  #pred<-predict(modFit,test_set[,-ncol(reaction)]) 
 
  pred<-predict(modFit,subset(reaction,select=features))
 
  mse<-mean((pred-test_set$time)^2)
  #return(mse)
  return(list(mse=mse, data=head(test_set),model=fit))
  
}

shinyServer(function(input, output) {
  output$inputValue<-renderPrint({input$features})
  output$cbvalue<-renderPrint({input$cb})
  output$mse<-renderPrint({process(input$cb)[1]})
  output$model<-renderPrint({process(input$cb)[3]})
  output$test<-renderPrint({process(input$cb)[2]})
})