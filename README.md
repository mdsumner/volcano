
<!-- README.md is generated from README.Rmd. Please edit that file -->

# volcano

<!-- badges: start -->
<!-- badges: end -->

The goal of volcano is to georeference the `volcano` data set. There are
3 datasets

- `volc` volcano matrix in an R xyz ‘image’ list, oriented correctly for
  use with raster tools
- `volc_extent` the four number extent `c(xmin, xmax, ymin, ymax)`
- `volc_proj` the projection string, it’s an EPSG code for NZMG

## Installation

You can install the development version of volcano from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("mdsumner/volcano")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(volcano)

print(volc_extent)
#> [1] 2667400 2668010 6478700 6479570
print(volc_proj)
#> [1] "EPSG:27200"
diff(volc_extent)[c(1, 3)]  ## Ross Ihaka's famous digitization was 10m pixels
#> [1] 610 870
## basic example code
image(volc, asp = 1)

(vtiff <- terra::rast(system.file("extdata/volcano.tif", package = "volcano", mustWork = TRUE)))
#> class       : SpatRaster 
#> dimensions  : 87, 61, 1  (nrow, ncol, nlyr)
#> resolution  : 10, 10  (x, y)
#> extent      : 2667400, 2668010, 6478700, 6479570  (xmin, xmax, ymin, ymax)
#> coord. ref. : NZGD49 / New Zealand Map Grid (EPSG:27200) 
#> source      : volcano.tif 
#> name        : lyr.1 
#> min value   :    94 
#> max value   :   195
terra::contour(vtiff, add = TRUE)
```

<img src="man/figures/README-example-1.png" width="100%" />

`volc` is just volcano stored as a `image()` list. We can work directly
with it by reversing each axis, and using GDAL to get other data in the
same projection.

``` r
#remotes::install_github(file.path("hypertidy", c("whatarelief", "ximage")))
prj <- "EPSG:27200"
oriented <- volcano[nrow(volcano):1, ncol(volcano):1]

ximage::ximage(oriented, extent = volc_extent, asp = 1)

x <- whatarelief::elevation(volc_extent, dimension = c(256, 256), projection = volc_proj)
#> [1] "SRTM in use, in addition to GEBCO"
#> [1] "/vsicurl/https://public.services.aad.gov.au/datasets/science/GEBCO_2021_GEOTIFF/GEBCO_2021.tif"
#> [2] "/vsicurl/https://opentopography.s3.sdsc.edu/raster/COP30/COP30_hh.vrt"
im <- whatarelief::imagery(volc_extent, dimension = c(512, 512), projection = volc_proj)
ximage::ximage(im, extent = volc_extent, add = TRUE)
ximage::xcontour(x, extent = volc_extent, add = T, col = "white")
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

## Code of Conduct

Please note that the volcano project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
