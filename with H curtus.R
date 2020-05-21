# demographics with H. curtus
snakes <- snakes%>%
  mutate(Year = as.factor(Year))%>%
  filter(Species == "Hydrophis curtus" | Species == "Hydrophis schistosus")

age.yr <- snakes%>%
  group_by(Species, Year)%>%
  summarise(N = n(),
            mean = mean(Snout.to.Vent..cm., na.rm = T))


maturtity <- snakes%>%
  group_by(Species)%>%
  count()%>%
  mutate(juv = 35,
         adult = ifelse(Species == "Hydrophis curtus", 54, 65))
  
snakes%>%
  filter(Snout.to.Vent..cm. > 20)%>%
  ggplot(aes(Year, Snout.to.Vent..cm.))+
  geom_violin()+
  geom_hline(data = maturtity, aes(yintercept = adult), linetype = "dashed")+
  geom_hline(data = maturtity, aes(yintercept = juv), linetype = "dotted")+
  stat_summary(fun.data = "mean_sdl", geom = "pointrange", size = 1)+
  geom_label(data = age.yr, aes(Year, 20, label = N))+
  facet_wrap(~Species, ncol = 1, scales = "free_y")+
  labs(y = "Snout to vent length (cm)")

