# 6) Compare emissions from motor vehicle sources in Baltimore City with 
# emissions from motor vehicle sources in Los Angeles County, California 
# (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?


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



# We can employ the same methods that we used to make the previous plot, only now, we'll do
# a side-by-side comparison with both Baltimore City and LA County.

# Weave together data for our Baltimore City Barplot

balt_city_index = NEI$fips == "24510"


target_df = NEI[NEI$fips[balt_city_index] == NEI$fips,]
target_df = target_df[target_df$type == "ON-ROAD",]

balt_city_motor_emissions_grouped = tapply(target_df$Emissions, target_df$year, "sum")
year_bins = unique(target_df$year)

balt_city_motor_emissions_df = data.frame(Emissions = balt_city_motor_emissions_grouped, Year = year_bins)


# Weave together data for our LA Country barplot

la_county_index = NEI$fips == "06037"


target_df = NEI[NEI$fips[la_county_index] == NEI$fips,]
target_df = target_df[target_df$type == "ON-ROAD",]

la_county_motor_emissions_grouped = tapply(target_df$Emissions, target_df$year, "sum")
year_bins = unique(target_df$year)

la_county_motor_emissions_df = data.frame(Emissions = la_county_motor_emissions_grouped, Year = year_bins)


# Set our viewing parameters for a side-by-side view, and then plot

par(mfrow = c(1, 2))

barplot(balt_city_motor_emissions_df$Emissions, balt_city_motor_emissions_df$Year,
        main = "Baltimore City Motor Vehicle Emissions",
        xlab = "Year",
        ylab = "Emissions (tons)")

barplot(la_county_motor_emissions_df$Emissions, la_county_motor_emissions_df$Year,
        main = "Los Angeles County Motor Vehicle Emissions",
        xlab = "Year",
        ylab = "Emissions (tons)")

summary(balt_city_motor_emissions_df)
summary(la_county_motor_emissions_df)


# It's quite clear that while Baltimore City has greatly reduced its motor vehicle 
# emission levels over time, LA Country has actually seen increases. Also worth noting is 
# fact that LA County's vehicle emissions range between about 4000 - 5000 tons... a huge difference
# from Baltimore City's range of around 100-400. 


