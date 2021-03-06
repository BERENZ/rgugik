tmp = tempfile()
emuia_download(commune = "Jejkowice", outdir = tmp, unzip = FALSE) # 37.1 KB
file_path = list.files(tmp, full.names = TRUE)
file_size = file.info(file_path)$size / 2^10
file_ext = substr(file_path, nchar(file_path) - 2, nchar(file_path))


test_that("check file size", {
  expect_true(file_size > 37)
})

test_that("check file ext", {
  expect_true(file_ext == "zip")
})


# unzip
tmp = tempfile()
emuia_download(TERYT = 2412032, outdir = tmp, unzip = TRUE) # 37.1 KB
file_path = list.files(tmp, full.names = TRUE)
file_number = length(file_path)
file_ext = substr(file_path, nchar(file_path) - 2, nchar(file_path))


test_that("check number of files", {
  expect_true(file_number == 8L)
})

test_that("check if zip is removed", {
  expect_true(!"zip" %in% file_ext)
})


# test stops
test_that("check stops", {
  expect_error(emuia_download(), "'commune' and 'TERYT' are empty")
  expect_error(emuia_download("Jejkowice", 2412032), "use only one input")
  expect_error(emuia_download(commune = "XXX"), "incorrect county name")
  expect_error(emuia_download(TERYT = "0"), "incorrect TERYT")
})
