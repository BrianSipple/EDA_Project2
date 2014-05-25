# 3) 
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in 
# emissions from 1999–2008 for Baltimore City? Which have seen increases 
# in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
# answer this question.



# This table contains number of tons of PM2.5 emitted from a specific type of 
# source for the entire year ( for the years 1999, 2002, 2005, and 2008)
#
# fips: A five-digit number (represented as a string) indicating the U.S. county
#
# SCC: The name of the source as indicated by a digit string (see source code classification table)
#
# Pollutant: A string indicating the pollutant
#
# Emissions: Amount of PM2.5 emitted, in tons
#
# type: The type of source (point, non-point, on-road, or non-road)
#
# year: The year of emissions recorded

NEI = readRDS("./data/summarySCC_PM25.rds")



# This table provides a mapping from the SCC digit strings int the Emissions
# table to the actual name of the PM2.5 source. 
# The sources are categorized in a few different ways from more general to more 
# specific and you may choose to explore whatever categories you think are most useful. 
# For example, source “10100101” is known as 
# “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

SCC = readRDS("./data/Source_Classification_Code.rds")


# Line plot for each yearly sum

balt_city_index = NEI$fips == "24510"
balt_city_emissions = NEI$Emissions[balt_city_index]
balt_city_emissions_years = NEI$year[balt_city_index]
balt_city_emissions_types = NEI$type[balt_city_index]

# We have a nice set of vectors, but now we need to group by year -- FORE EACH TYPE -- summing emissions

unique(balt_city_emissions_types)

balt_city_emissions_year_types_df = data.frame(tapply(balt_city_emissions, list(balt_city_emissions_years, balt_city_emissions_types), "sum"))

# A bit of refactoring on the df
names(balt_city_emissions_year_types_df) = c("nonroad", "nonpoint", "onroad", "point")
balt_city_emissions_year_types_df = data.frame(year = row.names(balt_city_emissions_year_types_df),
                                               point = balt_city_emissions_year_types_df$point,
                                               nonpoint = balt_city_emissions_year_types_df$nonpoint,
                                               onroad = balt_city_emissions_year_types_df$onroad,
                                               nonroad = balt_city_emissions_year_types_df$nonroad)

# A handy panel display mechanism that extends the ggplot2 package: the gridExtra package...
#install.packages("gridExtra")
library(gridExtra)

g1 = ggplot(data=balt_city_emissions_year_types_df, aes(x=year, y=point)) +
        geom_bar()

g2 = ggplot(data=balt_city_emissions_year_types_df, aes(x=year, y=nonpoint)) +
        geom_bar()

g3 = ggplot(data=balt_city_emissions_year_types_df, aes(x=year, y=onroad)) +
        geom_bar()

g4 = ggplot(data=balt_city_emissions_year_types_df, aes(x=year, y=nonroad)) +
        geom_bar()

grid.arrange(g1, g2, g3, g4, ncol=2)

# The four bar graphs each depict a clear trend of total emission levels from each 
# source type during each year's bin. 
# 
# "onroad" and "nonroad" saw drastic declines over the 1999-2008 period. 

# "nonpoint" (by comparison, at least) only experienced a small decline.

# The "point" source was the only source type that increased in overall emission levels
# during the 1999-2008 period, although 2008 marked a major improvement compared to its massive 
# upswing in 2005. 



