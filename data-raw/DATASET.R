## code to prepare `DATASET` dataset goes here


oriented <- volcano[nrow(volcano):1, ncol(volcano):1]

extent <- c(
  2667400 + c(0, 1) * ncol(volcano) * 10, 6478700 + c(0, 1) * nrow(volcano) * 10)

prj <- "EPSG:27200"
terra::writeRaster(rtiff <- terra::rast(oriented, extent = extent, crs = prj), "inst/extdata/volcano.tif")

volc <- list(x = terra::xFromCol(rtiff, 1:ncol(rtiff)),
             y = terra::yFromRow(rtiff, nrow(rtiff):1),
             z = t(volcano[,ncol(volcano):1]))
image(volc, asp = 1)
terra::contour(terra::rast("inst/extdata/volcano.tif"), add = TRUE)
## volc is volcano georeferenced
usethis::use_data(volc, overwrite = TRUE)
volc_extent <- extent
volc_proj <- prj
usethis::use_data(volc_extent, volc_proj)


