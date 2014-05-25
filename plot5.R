# 5) How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


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


# Digging through the data, it appears as though motor vehicle sources include everything
# with the type of "ON-ROAD"

balt_city_index = NEI$fips == "24510"


target_df = NEI[NEI$fips[balt_city_index] == NEI$fips,]
target_df = target_df[target_df$type == "ON-ROAD",]

balt_city_motor_emissions_grouped = tapply(target_df$Emissions, target_df$year, "sum")
year_bins = unique(target_df$year)

balt_city_motor_emissions_df = data.frame(Emissions = balt_city_motor_emissions_grouped, Year = year_bins)

barplot(balt_city_motor_emissions_df$Emissions, balt_city_motor_emissions_df$Year,
        main = "Baltimore City Motor Vehicle Emissions",
        xlab = "Year",
        ylab = "Emissions (tons)")


# Have motor vehcile emissions dropeed between 1999-2008? According to the plot, they've plummeted.

