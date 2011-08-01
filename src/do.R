## Ryan Elmore
## Date:
## Description:

project.path <- "~/Side_Projects/GoogleTrends/"

## Dependencies:
source(paste(project.path, "src/load.R", sep=""))

## Get some trends; login to gmail using firefox 
ff.data <- getGTrends("fantasy football")
nfl.data <- getGTrends("NFL")

ff.new <- data.frame(day   = mdy(ff.data$Week$Week),
                     score = ff.data$Week$fantasy.football)
ff.new$year <- format(ff.new$day, "%Y")
ff.new$week <- as.numeric(format(ff.new$day, "%V"))
ff.new$d <- yday(ff.new$day)


nfl.new <- data.frame(day   = mdy(nfl.data$Week$Week),
                     score = nfl.data$Week$nfl)
nfl.new$year <- format(nfl.new$day, "%Y")
nfl.new$week <- as.numeric(format(nfl.new$day, "%V"))
nfl.new$d <- yday(nfl.new$day)

n <- length(nfl.new[, 1])                     

p <- ggplot(data=ff.new[-n, ], aes(x=day, y=score))
p + geom_line(aes(col=year)) +
  scale_y_continuous("google trends score")
ggsave("../fig/ff_1.png", hei=7, wid=7)

p <- ggplot(data=ff.new[-n, ], aes(x=d, y=score, group=year))
p + geom_line(aes(col=year)) +
  scale_y_continuous("google trends score") +
  scale_x_continuous("day of year")
ggsave("../fig/ff_2.png", hei=7, wid=7)

p <- ggplot(data=nfl.new[-n, ], aes(x=day, y=score))
p + geom_line(aes(col=year)) +
  scale_y_continuous("google trends score")
ggsave("../fig/nfl_1.png", hei=7, wid=7)

p <- ggplot(data=nfl.new[-n, ], aes(x=d, y=score, group=year))
p + geom_line(aes(col=year)) +
  scale_y_continuous("google trends score") +
  scale_x_continuous("day of year")
ggsave("../fig/nfl_2.png", hei=7, wid=7)

