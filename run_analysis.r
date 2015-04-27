AL<-read.table("./UCI HAR Dataset/activity_labels.txt") # get the activity labels
      Feats<-read.table("./UCI HAR Dataset/features.txt")     #get the features
      Subs<-read.table("./UCI HAR Dataset/train/subject_train.txt")  # read training subjects
      Subs<-rbind(Subs,read.table("./UCI HAR Dataset/test/subject_test.txt"))  #add test subjects
      Subs<-as.factor(Subs$V1)
      AC<-read.table("./UCI HAR Dataset/train/y_train.txt")       #read in the Activity codes
      AC<-rbind(AC, read.table("./UCI HAR Dataset/test/y_test.txt"))
      AC<-as.factor(AC$V1)
      data<-read.table("./UCI HAR Dataset/train/x_train.txt")     #Read in the data
      data<-rbind(data, read.table("./UCI HAR Dataset/test/x_test.txt"))
      
      
      # Subset out all columns with mean or std
      m_std<-grep("mean|std",Feats[ ,2])
      MFeats<-Feats[m_std,]
      data_m_std<-data[,m_std]
      
      
      #Attach the Activity codes to the data
      data_m_std<-cbind(AC, data_m_std)
      #Attach the subjects to the data
      data_m_std<-cbind(Subs, data_m_std)
      
      names<-as.character(MFeats$V2)#change FEATS to characters
      names<-c("Subjects", "Activity", names)  # add Subject and Activity to the begining of the names
      colnames(data_m_std)<-names  # attach the names to the columns of the data set
      
##Properly grouped and means calculated    
     
      ans<-group_by(data_m_std,Subjects,Activity) %>% summarise_each(funs(mean))
