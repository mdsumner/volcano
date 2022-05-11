## code to prepare `DATASET` dataset goes here

oriented <-volcano[nrow(volcano):1,ncol(volcano):1]

extent <- c(2667394, 2668004, 6478902, 6479772)
projection <- "+proj=nzmg +datum=WGS84"
terra::writeRaster(rtiff <- terra::rast(oriented, extent = extent, crs = projection), "inst/extdata/volcano.tif")

volc <- list(x = terra::xFromCol(rtiff, 1:ncol(rtiff)),
             y = terra::yFromRow(rtiff, nrow(rtiff):1),
             z = t(volcano[,ncol(volcano):1]))
# image(volc, asp = 1)
# terra::plot(terra::rast("inst/extdata/volcano.tif"), add = TRUE)
## volc is volcano georeferenced
usethis::use_data(volc, overwrite = TRUE)
