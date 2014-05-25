# 1) 
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.


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


library(ggplot2)

# Group the sums of total emissions for each year
total_emissions_per_year = tapply(NEI$Emissions, NEI$year, "sum")

# Give our sums a matching years vector
years = unique(NEI$year)

# Combine sums and years into a data frame that we can expose to our plotting function
df = data.frame(Emissions=total_emissions_per_year, Year=years)

# A line plot will make for a perfect trend depiction 

png("plot1.png")
plot(df$Year, df$Emissions, type="l",
     xlab = "Year",
     ylab = "Total PM2.5 Emissions per year (tons)")
dev.off()

# Using the line graph from the base plotting system, it's quite clear that total emissions
# from PM2.5 fell greatly between 1999 and 2008.

