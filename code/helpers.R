## Source .Rmd 

source_rmd = function(file, ...) {
  tmp_file = tempfile(fileext=".R")
  on.exit(unlink(tmp_file), add = TRUE)
  knitr::purl(file, output=tmp_file, quiet = T)
  source(file = tmp_file, ...)
} 

# Calculate age at Death
calculate_age_at_death <- function(data) {
  setDT(data)
  ######## age_at_death
  
  ## This is a function written by Josh
  
  ## Only cases:
  ## (1) birthday before (or equal to) death day --> dyear - byear
  ## * dmonth > bmonth
  ## * dmonth == bmonth & dday >= bday
  
  ## (2) birthday after death day --> dyear - byear - 1
  ## * dmonth < bmonth
  ## * dmonth == bmonth & dday < bday
  
  ## BUT we can have  missing values on
  ## bday, bmonth, byear, dday, dmonth, and dyear
  
  ## (1) byear or dyear missing --> age_at_death = missing
  ## (2) bmonth only missing  --> impute as June
  ## (3) dmonth only missing  --> impute as June
  ## (4) dday only missing  --> impute as 15
  ## (5) bday only missing  --> impute as 15
  data[, bmonth_hat := bmonth]
  data[is.na(bmonth), bmonth_hat := 6]
  data[, dmonth_hat := dmonth]
  data[is.na(dmonth), dmonth_hat := 6]
  ##
  data[, bday_hat := bday]
  data[is.na(bday_hat), bday_hat := 15]
  data[, dday_hat := dday]
  data[is.na(dday_hat), dday_hat := 15]
  
  ## (1) birthday before (or equal to) death day --> dyear - byear
  ## NOTE: we default to this in the case where day or month are equal.
  ## * dmonth > bmonth
  ## * dmonth == bmonth & dday >= bday
  data[dmonth_hat > bmonth_hat,
       death_age := dyear - byear]
  data[dmonth_hat == bmonth_hat & dday_hat >= bday_hat,
       death_age := dyear - byear]
  ## (2) birthday after death day --> dyear - byear - 1
  ## * dmonth < bmonth
  ## * dmonth == bmonth & dday < bday
  data[dmonth_hat < bmonth_hat,
       death_age := dyear - byear - 1]
  data[dmonth_hat == bmonth_hat & dday_hat < bday_hat,
       death_age := dyear - byear -1]
  
  data <- data %>%
    dplyr::select(-c(dmonth_hat, bmonth_hat, dday_hat, bday_hat))
  
  return(data)
}

## function for recoding education
recode_education <- function(df, educ_var) {
  
  df <- df  %>%
    mutate(educ_variable = !!sym(educ_var)) %>%
    mutate(educ_yrs = case_when(
      educ_variable == 2 ~ 0,
      educ_variable == 12 ~ 0,
      educ_variable == 14 ~ 1,
      educ_variable == 15 ~ 2,
      educ_variable == 16 ~ 3,
      educ_variable == 17 ~ 4,
      educ_variable == 22 ~ 5,
      educ_variable == 23 ~ 6,
      educ_variable == 25 ~ 7,
      educ_variable == 26 ~ 8,
      educ_variable == 30 ~ 9,
      educ_variable == 40 ~ 10,
      educ_variable == 50 ~ 11,
      educ_variable == 60 ~ 12,
      educ_variable == 70 ~ 13,
      educ_variable == 80 ~ 14,
      educ_variable == 90 ~ 15,
      educ_variable == 100 ~ 16,
      educ_variable == 110 ~ 17,
      educ_variable == 111 ~ 17,
      educ_variable == 112 ~ 17,
      educ_variable == 113 ~ 17
    )) %>%
    select(-educ_variable)
  
  return(df)
  
}
