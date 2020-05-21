#Tidying Data
snakes = snakes%>%
  filter(!is.na(Sr..No.))%>%
  mutate(Date = dmy(Date),
         Month = factor(months(ymd(Date)), 
                        levels = month.name),
         Year = year(ymd(Date)))%>%
  mutate(Collection.Time = format(as.POSIXct(Sys.Date() + as.numeric(as.character(Collection.Time))), #fix NA
                                  "%H:%M", tz="UTC"),
         Fishing.Trip.Start = format(as.POSIXct(Sys.Date() + as.numeric(as.character(Fishing.Trip.Start))), #fix NA
                                     "%H:%M", tz="UTC"),
         Fishing.Trip.End = format(as.POSIXct(Sys.Date() + as.numeric(as.character(Fishing.Trip.End))), #fix NA
                                   "%H:%M", tz="UTC"),
         Snout.to.Vent..cm. = as.numeric(as.character(Snout.to.Vent..cm.)),
         Tail.Length..cm. = as.numeric(as.character(Tail.Length..cm.)
         ),
         Depth.Caught..m. = Depth.Caught..Fathoms.*1.87
  )

#Adding developmental classes based on observed length at Maturity
snakes = snakes%>%  
  mutate(Class = 
           if_else(
             Species == "Hydrophis schistosus", 
             if_else(Snout.to.Vent..cm. > 60, 
                     "Adult",
                     if_else(Snout.to.Vent..cm. > 35,
                             "Juvenile", 
                             "Neonate"
                     ),
                     "NA"),
             if_else(
               Species == "Hydrophis curtus",
               if_else(Sex == "Male"&Snout.to.Vent..cm.>54| Sex=="Female"&Snout.to.Vent..cm.>67,#Fry et al. 2001
                       "Adult",
                       if_else(Snout.to.Vent..cm.>35,
                               "Juvenile",
                               "Neonate")
               ),
               "NA"
             )
           )
  )#fix NA

# calculating missing SVL from BL

## relationship SVL:BL by species and sex

snakes%>%
  group_by(Species, Sex)%>%
  filter(!is.na(Snout.to.Vent..cm.),
         !is.na(Body.Length..cm.))%>%
  summarise(SVL_BL = mean(Snout.to.Vent..cm./Body.Length..cm.))

## fixing SVL

snakes <- snakes%>%
  mutate(Snout.to.Vent..cm. = case_when(!is.na(Snout.to.Vent..cm.) ~ Snout.to.Vent..cm.,
                                        is.na(Snout.to.Vent..cm.) & Species == "Hydrophis curtus" & Sex == "Female" ~ Body.Length..cm.*0.9,
                                        is.na(Snout.to.Vent..cm.) & Species == "Hydrophis curtus" & Sex == "Male" ~ Body.Length..cm.*0.893,
                                        is.na(Snout.to.Vent..cm.) & Species == "Hydrophis schistosus" & Sex == "Female" ~ Body.Length..cm.*0.886,
                                        is.na(Snout.to.Vent..cm.) & Species == "Hydrophis schistosus" & Sex == "Male" ~ Body.Length..cm.*0.868))

write.csv(snakes, "./Data/Sea-snakes_fish-dep_mastersheet_250420.csv")
