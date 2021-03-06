library(sf)

polygon_path = system.file("datasets/search_area.gpkg", package = "rgugik")
polygon = read_sf(polygon_path)
DTM = pointDTM_get(polygon, distance = 3)


test_that("check if ouput is sf/data.frame", {
  expect_s3_class(DTM, c("sf", "data.frame"))
})

test_that("check number of rows", {
  expect_true(nrow(DTM) == 586)
})

test_that("check number of columns", {
  expect_true(ncol(DTM) == 2)
})

test_that("check elevation sd", {
  expect_true(sd(DTM$Z) > 0)
})


# test stops
test_that("check stops", {
  expect_error(pointDTM_get(polygon, distance = 0),
               "distance between the points cannot be less than 1 m")
  expect_error(pointDTM_get(polygon, distance = 1.5),
               "'distance' must contain an integer")
})
