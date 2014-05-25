# 2)
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.


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


balt_city_index = NEI$fips == "24510"
balt_city_emissions = NEI$Emissions[balt_city_index]
balt_city_emissions_years = NEI$year[balt_city_index]
balt_city_emissions_types = NEI$type[balt_city_index]


# Now that we've isolated all of the emissions for Baltimore city -- and their years -- we
# can group the total emissions for each year

balt_city_emissions_by_year = tapply(balt_city_emissions, balt_city_emissions_year, "sum")
years = unique(balt_city_emissions_years)

# Combine grouped values into df and plot
balt_city_df = data.frame(Emissions=balt_city_emissions_by_year, Year=years)
plot(balt_city_df$Year, balt_city_df$Emissions, 
     type="l",
     xlab = "Year", 
     ylab = "Total Emissions (tons)")

# The plot shows that emissions have, indeed decreased from 1999 to 2008. 
# After a a decrease between 1999 and 2002, the values increased between 2002 and 2005, 
# but then dropped sharply again in the final interval, 2005-2008, leaving them much lower 
# than where the data begins. 