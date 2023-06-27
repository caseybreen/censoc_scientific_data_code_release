## CenSoc: Linked Administrative Mortality Records for Individual-level Mortality Research

This repository contains code and materials to replicate ["CenSoc: Linked Administrative Mortality Records for Individual-level Mortality Research."](https://osf.io/preprints/socarxiv/znsqg/)

### Replication Package

The this repository includes code to replicate all figures and tables in the paper. There are three steps to running the replication code: 

1. Clone this repository
2. Download the required datasets and update paths (when necessary)
3. Run the `00_run_all.Rmd` script, which will run all code (or run all scripts individually in any)


#### Data 

To actually replicate all results in this paper will require obtaining many different datasets. Please download download the CenSoc-DMF file, the CenSoc-Numident file, and the full-count 1940 Census. The data were originally obtained from: 

- IPUMS-USA [[link](https://usa.ipums.org/usa/)]
- CenSoc [[link](https://censoc.berkeley.edu/)]

#### Code 

After downloading the required data and updating paths, researchers can run the following script to replicate all figures and tables: 

- `00_run_all.Rmd` - this file runs all scripts. 

Alternatively, researchers can run each script individually in any order. 

- `01_mortality_rate_validation` - this script generates Figure 1, which compares the age-specific mortality rates for CenSoc-DMF and CenSoc-Numident to the "gold-standard" Human Mortality Database (HMD). 
- `02_assess_mortality_coverage` - Code to generate Figure 2, which benchmarks the mortality coverage (total count of deaths, annually) of the DMF and Numident (ages 65+) against the Human Mortality database. 
- `03_middle_initial_analysis.Rmd` - Code to assess the middle initial agreement of the CenSoc-DMF and CenSoc-Numident. Middle initial was not used as a matching field.  
- `04_association_between_education_longevity.Rmd` - This .Rmd file contains code to replicate the "This Study" results in Table 4. It calculates the educational gradient to longevity by fitting a parametric Gompertz model. 

### Authors

- [Casey F. Breen](caseybreen.com)
- [Maria Osborne](https://nathanseltzer.github.io/)
- [Joshua R. Goldstein](https://jrgoldstein.com/)

