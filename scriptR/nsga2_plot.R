library(ggplot2)

data.df <- read.csv("~/github/repro-seir/results_nsga/population250.csv")

ggplot(data = data.df)+
  geom_point(aes(x = evolution.samples, y = objective.integraleInfected))+
  geom_segment(aes(x = 1.5, y = 20, xend = 1, yend = 9.2),
               arrow = arrow(length = unit(0.5, "cm")))+
  geom_segment(aes(x = 22, y = 20, xend = 21.1, yend = 12.2),
               arrow = arrow(length = unit(0.5, "cm")))+
  annotate(geom="text", x=1.5, y=21, label="1")+
  annotate(geom="text", x=22, y=21, label="2")+
  theme_bw()+
  labs(title = "250 evolution for NSGA2")

ggsave("~/github/repro-seir/img/nsga2_evol250.png", width = 10)
