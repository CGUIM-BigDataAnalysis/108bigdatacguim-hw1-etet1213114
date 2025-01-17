library(jsonlite)
library(dplyr)
install.packages("readr")
library(readr)

Salary_104 <- read_csv("C:/Users/user/Desktop/Salary_104.csv")
Salary_104$`大學-薪資`<- gsub("—|…"," ",Salary_104$`大學-薪資`)
Salary_104$大職業別 <- gsub("部門","",Salary_104$大職業別)
Salary_104$大職業別 <- gsub("醫療保健服務","醫療保健",Salary_104$大職業別)
Salary_104$大職業別 <- gsub("教育服務業","教育業",Salary_104$大職業別)
Salary_104$大職業別 <- gsub("營造業","營造工程",Salary_104$大職業別)


Salary_107<- read_csv("C:/Users/user/Desktop/Salary_107.csv")
Salary_107$`大學-薪資`<- gsub("—|…"," ",Salary_107$`大學-薪資`)
Salary_107$大職業別 <- gsub("_","、",Salary_107$大職業別)
  
Salary<-inner_join(Salary_104,Salary_107,by="大職業別")
View(Salary)

Salary$`大學-薪資.x`<- as.numeric(Salary$`大學-薪資.x`)
Salary$`大學-薪資.y`<- as.numeric(Salary$`大學-薪資.y`)

Salary$大學薪資比較<-Salary$`大學-薪資.y`/Salary$`大學-薪資.x` 

Salary %>% filter(大學薪資比較>1) %>% 
  arrange(desc(大學薪資比較)) %>% 
  head(10) %>%
  View()

#文字說明



Salary_1.05<-filter(Salary,大學薪資比較>1.05)

strsplit(Salary_1.05$大職業別,'-') %>%
  lapply("[", 1) %>%
  unlist() %>%
  table()


#2.a
Salary_104$`大學-女/男`<- gsub("—|…"," ",Salary_104$`大學-女/男`) %>% as.numeric()
Salary_104[order(Salary_104$`大學-女/男`,decreasing=F),] %>% 
  head(10) %>%View()

Salary_107$`大學-女/男`<- gsub("—|…"," ",Salary_107$`大學-女/男`) %>% as.numeric()
Salary_107[order(Salary_107$`大學-女/男`,decreasing=F),] %>% 
  head(10) %>%View()

###文字說明結果

#2.b
Salary_104[order(Salary_104$`大學-女/男`,decreasing=T),] %>% 
  head(10) %>%View()

Salary_107[order(Salary_107$`大學-女/男`,decreasing=T),] %>% 
  head(10) %>%View()

###文字說明結果

#3

Salary_107$`大學-薪資`<- gsub("—|…"," ",Salary_107$`大學-薪資`) %>% as.numeric()
Salary_107$`大學-薪資`<- as.numeric(Salary_107$`大學-薪資`)

Salary_107$`研究所-薪資`<- gsub("—|…"," ",Salary_107$`研究所-薪資`) %>% as.numeric()
Salary_107$`研究所-薪資`<- as.numeric(Salary_107$`研究所-薪資`)

Salary_107$研究所與大學薪資比較<-Salary_107$`研究所-薪資`/Salary_107$`大學-薪資`
View(Salary_107)

Salary_107 %>% 
  arrange(desc(研究所與大學薪資比較)) %>% 
  head(10) %>%
  View()


###文字說明結果


#4
Salary_107$`大學-薪資`<- gsub("—|…"," ",Salary_107$`大學-薪資`)
Salary_107$`研究所-薪資`<- gsub("—|…"," ",Salary_107$`研究所-薪資`)

Salary_107$`大學-薪資`<- as.numeric(Salary_107$`大學-薪資`)
Salary_107$`研究所-薪資`<- as.numeric(Salary_107$`研究所-薪資`)


name<-Salary_107$大職業別[c(79,99,100,101,128)] 
college<-Salary_107$`大學-薪資`[c(79,99,100,101,128)] 
graduade<-Salary_107$`研究所-薪資`[c(79,99,100,101,128)] 
graduade_vs_college<-graduade-college

Interested_job_salary<-data.frame(job=name,
                                  college_salary=college,
                                  graduade_salary=graduade,
                                  graduade_vs_college=graduade_vs_college)
View(Interested_job_salary)

##請問此薪資與妳想像中的一樣嗎? 文字說明
##會因為這樣改變心意，決定念/不念研究所嗎? 文字說明

















