# spinning globe logo
library(s2)
library(s2plot)
countries <- s2_data_countries()
ocean <- s2_difference(
  # make a polygon of the whole earth!
  as_s2_geography(TRUE),
  s2_union_agg(countries)
)

set.seed(13313)
lon0 <- runif(1, -180, 180)
lat0 <- runif(1, -90, 90)
#for (lon in seq(0, -360, length.out = 101)[-1]) {
n <- 180
pb <- txtProgressBar(min = 0, max = n, style = 3)
library(animation)
saveGIF(
for (i in n:1) {
  lon <- lon0 + i * 2
  lat <- lat0 + (sin(i/n * 2 * pi) + 1) * 40
  s2plot(
    countries, 
    col = "white", border = "black", 
    projection = s2plot_projection_orthographic(sprintf("POINT (%s %s)", lon, lat)),
    xlim = c(-1, 1),
    ylim = c(-1, 1)
  )
  
  s2plot(ocean, col = "#0073B8", add = T)
  setTxtProgressBar(pb, n - i + 1)
}
, interval = 0.1, clean = FALSE)


