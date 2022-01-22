library(dplyr)
library(stringr)
#-----------------------------------------------------------------------------------------------------------------------
#Data Analysis

#1
Meta <- read.csv("FakeNewsMeta.csv", stringsAsFactors = FALSE)
View(Meta)

#2
Meta <- Meta %>% mutate(Date = str_extract(Meta$published, "[:digit:]{4}-[:digit:]{2}-[:digit:]{2}"))

#3
A1 <- Meta %>% group_by(type) %>% summarise(AverageShare = mean(shares)) %>% arrange(desc(AverageShare))
#bias is the highest shares per classification type

#4
A2 <- Meta %>% count(author) %>% arrange(desc(n))
head(A2, 10)

#5
# Meta %>% filter(!str_detect(author, "^$")) 
PPD <- Meta %>% filter(author != "") %>% count(author, Date) %>% arrange(desc(n))
head(PPD, 10)
#1 = Admin,  2 = Alex Ansary, Eddy Lavine, Editor, Gillian, Pakalert, Starkman, 8 = BareNakedIslam, 9 = Dave Hodges, 10 = Alexander Light

#6
PPD %>% filter(author == "Eddy Lavine") %>% arrange(Date)
#His peak posting was Nov 2nd, and it was 38.

#7
Meta %>% filter(author == "Eddy Lavine") %>% count(country)
#Eddy Lavine was posting from TV 

#-----------------------------------------------------------------------------------------------------------------------
#Text Analysis

#9
Titles <- readLines("FakeNewsTitles.txt", encoding = "UTF-8")
View(Titles)

#10
#10-1
Titles <- str_remove_all(Titles, pattern = "(\\||»).*$")

#10-2
Titles <- str_remove_all(Titles, pattern = "(\\[|\\()[a-zA-Z\\s]*(\\]|\\))")

#10-3
Titles <- str_remove_all(Titles, pattern = "\\s[a-zA-Z0-9]*\\.com$")

#11
#11-1
Titles <- str_to_lower(Titles)

#11-2
Titles <- str_replace_all(Titles, "\u2026", " ")

#11-3
Titles <- str_remove_all(Titles, pattern = "[:punct:]")

#11-4
Titles <- str_trim(Titles, side = "both")
Titles <- str_squish(Titles)

#12
Titles_words <- unlist(str_split(Titles, pattern = " "))
