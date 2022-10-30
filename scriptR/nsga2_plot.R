library(ggplot2)

data.df <- read.csv("~/github/repro-seir/results_nsga/multi_infected_exposed_population2000.csv")

ggplot(data = data.df)+
  geom_point(aes(x = objective.integraleExposed, y = objective.integraleInfected, size = evolution.samples))+
  # geom_segment(aes(x = 1.5, y = 20, xend = 1, yend = 9.2),
  #              arrow = arrow(length = unit(0.5, "cm")))+
  # geom_segment(aes(x = 22, y = 20, xend = 21.1, yend = 12.2),
  #              arrow = arrow(length = unit(0.5, "cm")))+
  # annotate(geom="text", x=1.5, y=21, label="1")+
  # annotate(geom="text", x=22, y=21, label="2")+
  theme_bw()+
  labs(title = "2000 evolutions for NSGA2", 
       subtitle = "multi-obj : infected and exposed",
       x = paste0("\u2211","\u0394","Exposed"),
       y = paste0("\u2211","\u0394","Infected"))

ggsave("~/github/repro-seir/img/nsga2_evol2000.png", width = 10, height = 5)

ggplot(data = data.df)+
  geom_point(aes(x = objective.integraleExposed, y = objective.integraleInfected, size = evolution.samples))+
  # geom_segment(aes(x = 1.5, y = 20, xend = 1, yend = 9.2),
  #              arrow = arrow(length = unit(0.5, "cm")))+
  # geom_segment(aes(x = 22, y = 20, xend = 21.1, yend = 12.2),
  #              arrow = arrow(length = unit(0.5, "cm")))+
  # annotate(geom="text", x=1.5, y=21, label="1")+
  # annotate(geom="text", x=22, y=21, label="2")+
  theme_bw()+
  labs(title = "2000 evolutions for NSGA2", 
       subtitle = "multi-obj : infected and exposed",
       x = paste0("\u2211","\u0394","Exposed"),
       y = paste0("\u2211","\u0394","Infected"))+
  xlim(0, 50)+
  ylim(0,50)

ggsave("~/github/repro-seir/img/nsga2_evol2000_zoom.png", width = 8, height = 5)


data.df[34,1:12]
