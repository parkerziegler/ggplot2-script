# set the working directory
setwd("/Documents/Ecotrust/Visualization")

# read in the data
nhood_data <- read.csv("Canopy_Data.csv", header = TRUE)

# load libraries
require(ggplot2)
require(dplyr)

View(nhood_data)

# STRIPCHARTS WITH GGPLOT2

# coerce the value of that differentiates each "strip" into a factor
nhood_data$YEAR <- as.factor(nhood_data$YEAR)

# create the initial plot
plot_init <- ggplot(nhood_data, aes(x=YEAR, y=CANOPY_COVER, color=YEAR)) + geom_boxplot() + geom_jitter(position=position_jitter(0.2)) # + theme(legend.position="none") use this to remove legends

# depending on your data and your design constraints, you may want to flip the x and y-axis
plot_strip <- plot_init + coord_flip()
plot_strip

# save the data as an SVG for final touch up with Illustrator
ggsave(file="Strip_Chart.svg", plot=plot_strip, width=7, height=3)

# DENSITY PLOTS WITH GGPLOT2

# use a package like dplyr to remove erroneous results
filt_data <- dplyr::filter(nhood_data, CANOPY_COVER < 75)

# create the density plot; use an alpha parameter to get opacity beneath the curves
plot_dens <- ggplot(data=filt_data, aes(CANOPY_COVER, fill=DISTRICTNA, color=DISTRICTNA)) + geom_density(alpha=0.1) #+ theme (legend.position="none") use this to remove legends
plot_dens
ggsave(file="Density_Plot.svg", plot=plot_dens, width=7, height=3)

# we can do the same, but with another variable (like DIF_TARGET, the difference between the current and target canopy in Portland)
plot_dens_2 <- ggplot(data=filt_data, aes(DIF_TARGET, fill=DISTRICTNA, color=DISTRICTNA)) + geom_density(alpha=0.1) #+ theme (legend.position="none") use this to remove legends
plot_dens_2
ggsave(file="Density_Plot_2.svg", plot=plot_dens, width=7, height=3)

# LINE GRAPHS WITH GGPLOT2

# we'll use our filtered data again; use geom_point() to display points for each feature in the dataset
plot_line <- ggplot(data=filt_data, aes(x=YEAR, y=CANOPY_COVER, group=NHOOD, color="GREEN")) + geom_line() #+ geom_point() + theme (legend.position="none")
plot_line
ggsave(file="Line_Graph.svg", plot=plot_line, width=7, height=3)
