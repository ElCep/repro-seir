library(tidyverse)
library(reshape2)

setwd("~/github/repro-seir/")

data.df <- read.csv("results_bs/m0-seir experiment_simple-table.csv", skip = 6)

data.df %>%
  group_by(X.step.) %>%
  summarise(meanI = mean(propInfected), 
            SdI = sd(propInfected),
            meanS = mean(propSuseptible), 
            SdS = sd(propSuseptible),
            meanE = mean(propExposed), 
            SdE = sd(propExposed),
            meanR = mean(propRecovered), 
            SdR = sd(propRecovered),
            ) -> data.s

write_csv(data.s, "results_bs/m0-seir_summerised.csv")

sel <- subset(data.df, select = c("X.step.", "propInfected", "propSuseptible", 
                                  "propExposed", "propRecovered"))

data.m <- melt(sel,id.vars=c("X.step."),
            measured.vars=c("propInfected", "propSuseptible", 
                            "propExposed", "propRecovered"))

ggplot(data = data.m)+
  geom_smooth(aes(x = X.step., y = value, color = variable))+
  labs(x = "time", title = "50 replications")+
  theme_bw()

ggsave("img/replication.png", width = 8)
