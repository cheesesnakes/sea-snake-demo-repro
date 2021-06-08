# Plots for MS
## run main script before running this script

require(tidyverse)
require(viridis)

# Figure 2

fig2a <-HS%>%
  filter(Year == "2018", # data not sufficient for other years
         Snout.to.Vent..cm. > 20)%>% # removing erroneous data
  mutate(Month = factor(Month, levels = month.name))%>%
  complete(nesting(Species), Month)%>%
  droplevels()%>%
  ggplot(aes(Month, Snout.to.Vent..cm.))+
  geom_violin(fill = "light grey")+
  #geom_point(data = month.svl, aes(x = Month, y = mean.SVL), size = 3)+
  geom_boxplot(width = 0.1)+
  geom_segment(data = births, aes(x = Month, xend = Month, y = 0 , yend = 10), #marking births
               arrow = arrow(length = unit(0.25, "cm"), ends = "first"), size = 1)+
  geom_text(data = births, aes(x = Month, y = 20, label = paste("Observed \n births")))+
  geom_vline(aes(xintercept = "June"), size = 1, linetype = "dotted")+#start of the monsoon ban
  geom_vline(aes(xintercept = "August"), size = 1, linetype = "dotted")+#end of the monsoon ban
  geom_text(aes(x = "July", y = 80, label = "Monsoon ban"))+
  scale_x_discrete(guide = guide_axis(n.dodge = 2))+
  labs(y = "Snout to vent length (cm)", title = "A")+
  theme(axis.title.x = element_blank())

fig2b <- gravid%>%
  mutate(Month = factor(Month, levels = month.name))%>%
  complete(Month, fill = list(prop.gravid = 0))%>%
  ggplot(aes(Month, prop.gravid))+
  geom_pointrange(size = 1, aes(ymin = prop.gravid + sd, ymax = prop.gravid - sd))+
  geom_path(aes(group = 1), size = 0.5, linetype = "dashed")+
  geom_segment(aes(x = "April", xend = "April", y = 0 , yend = 0.02), #marking births
               arrow = arrow(length = unit(0.25, "cm"), ends = "first"), size = 1)+
  geom_text(aes(x = "April", y = 0.04, label = paste("Observed \n births")))+
  geom_vline(aes(xintercept = "June"), size = 1, linetype = "dotted")+#start of the monsoon ban
  geom_vline(aes(xintercept = "August"), size = 1, linetype = "dotted")+#end of the monsoon ban
  geom_text(aes(x = "July", y = 0.20, label = "Monsoon ban"))+
  scale_x_discrete(guide = guide_axis(n.dodge = 2))+
  labs(y = "Proportion of gravid females", title = "B")

fig2 <- gridExtra::grid.arrange(fig2a, fig2b, ncol = 1)

ggsave(fig2, filename = "./Figures/figure2.tiff", height = 9, width = 8)

# Figure 3

fig3a <- re_clutch%>%
  ggplot(aes(Female.SVL, rcm))+
  geom_point(aes(col = clutch.size), size = 3)+
  geom_smooth(data = re_simdata, aes(y = fit, ymin = fit - se.fit, ymax = fit + se.fit), stat = "identity", linetype = "dashed")+
  scale_y_continuous(name = "Relative clutch mass")+
  scale_x_continuous(limits = c(85, 115), name = "Female SVL (cm)")+
  scale_color_viridis(name = "Clutch size")+
  labs(title = "A")+
  theme(axis.title.x = element_blank(),
        legend.position=c(0.825, 0.85), 
        legend.direction = "horizontal")+
  guides(colour = guide_colorbar(title.position = "top", title.hjust = 0.5, barwidth = 10))

fig3b <- re_embryo%>%
  ggplot(aes(Female.SVL, inv))+
  geom_point(aes(col = Embryo.SVL), size = 3)+
  geom_smooth(data = inv_simdata, aes(y = fit, ymin = fit -se.fit, ymax = fit+se.fit),stat = "identity", linetype = "dashed", size = 1)+
  scale_y_continuous(name = "Relative egg mass")+
  scale_x_continuous(limits = c(85, 115), name = "Female SVL (cm)")+
  scale_color_viridis(name = "Embryo SVL (cm)")+
  labs(title = "B")+
  theme(legend.position=c(0.825, 0.85), 
        legend.direction = "horizontal")+
  guides(colour = guide_colorbar(title.position = "top", title.hjust = 0.5, barwidth = 10))

fig3 <- gridExtra::grid.arrange(fig3a, fig3b, ncol = 1)

ggsave(fig3, filename = "./Figures/figure3.tiff", height = 9, width = 8)

