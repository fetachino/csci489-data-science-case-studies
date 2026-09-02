# CSCI 48900 Assignment 1 (R)
# Files: NationalSalaries.xlsx, Salaries.xlsx

library(readxl)
library(dplyr)
library(stringr)
library(writexl)
library(ggplot2)

# -----------------------------
# Helpers
# -----------------------------
to_num <- function(x) {
  # Convert to numeric; treat BLS-style markers as NA
  x <- trimws(as.character(x))
  x[x %in% c("*", "**", "***", "#", "")] <- NA
  suppressWarnings(as.numeric(x))
}

is_detailed_job <- function(jobcode) {
  # Detailed = two digits dash four digits, NOT ending with 0000, and not 00-0000
  # Examples: 15-1256 (yes), 15-0000 (no), 00-0000 (no)
  jc <- as.character(jobcode)
  str_detect(jc, "^\\d{2}-\\d{4}$") & !str_detect(jc, "0000$") & jc != "00-0000"
}

# -----------------------------
# Read data
# -----------------------------
nat <- read_excel("NationalSalaries.xlsx")
sal <- read_excel("Salaries.xlsx")   # used for column set / names

# -----------------------------
# 1) Data cleaning: remove rows with invalid entries
#    (invalid markers in key numeric fields)
# -----------------------------
nat_clean <- nat %>%
  mutate(
    TOT_EMP_num = to_num(TOT_EMP),
    H_MEAN_num  = to_num(H_MEAN),
    A_MEAN_num  = to_num(A_MEAN)
  ) %>%
  filter(!is.na(TOT_EMP_num), !is.na(H_MEAN_num), !is.na(A_MEAN_num))

# Optional: rows that were removed (so you can show evidence)
invalid_rows <- nat %>%
  mutate(
    TOT_EMP_num = to_num(TOT_EMP),
    H_MEAN_num  = to_num(H_MEAN),
    A_MEAN_num  = to_num(A_MEAN)
  ) %>%
  filter(is.na(TOT_EMP_num) | is.na(H_MEAN_num) | is.na(A_MEAN_num))

# -----------------------------
# 2) Select only columns that appear in Salaries.xlsx
#    Rename to match Salaries.xlsx schema, save to a new file
# -----------------------------
# Mapping National -> Salaries
df <- nat_clean %>%
  transmute(
    ID                  = AREA,
    State               = ST,
    StateName           = STATE,
    JobCode             = OCC_CODE,
    JobName             = OCC_TITLE,
    Group               = GROUP,
    TotalEmployment     = TOT_EMP_num,
    AverageHourlySalary = H_MEAN_num,
    AverageYearlySalary = A_MEAN_num
  )

write_xlsx(df, "CleanSalaries.xlsx")

# -----------------------------
# 3) Randomly select 1500 rows
# -----------------------------
set.seed(489)  # reproducible
sample1500 <- df %>% slice_sample(n = 1500)
write_xlsx(sample1500, "Sample1500.xlsx")

# -----------------------------
# 4) Individual jobs (not major groups or all occupations)
#    with average hourly salary < 15
# -----------------------------
low_hourly <- df %>%
  filter(is_detailed_job(JobCode), AverageHourlySalary < 15)

write_xlsx(low_hourly, "LowHourlyUnder15.xlsx")

# -----------------------------
# 5) Individual jobs in Indiana, bin avg yearly salary into 10 bins
#    and count jobs in each bin
# -----------------------------
indiana_jobs <- df %>%
  filter(State == "IN", is_detailed_job(JobCode))

bins_in <- indiana_jobs %>%
  mutate(SalaryBin = cut(AverageYearlySalary, breaks = 10, include.lowest = TRUE)) %>%
  count(SalaryBin, name = "JobCount") %>%
  arrange(SalaryBin)

write_xlsx(list(IndianaJobs = indiana_jobs, IndianaBins = bins_in), "IndianaBins.xlsx")

# -----------------------------
# 6) Total employment for each state
#    Best way: use the "All Occupations" row (00-0000) per state
# -----------------------------
state_employment <- df %>%
  filter(JobCode == "00-0000") %>%
  select(State, StateName, TotalEmployment) %>%
  arrange(StateName)

write_xlsx(state_employment, "StateTotalEmployment.xlsx")

# -----------------------------
# 7) Average yearly salary of all (individual) jobs in Indiana
#    Compare with the dataset’s Indiana "All Occupations" value
#    Expected comparison per assignment: ~42630 vs 36410
# -----------------------------
in_avg_individual <- df %>%
  filter(State == "IN", is_detailed_job(JobCode)) %>%
  summarise(AvgYearlySalary_IndividualJobs = mean(AverageYearlySalary)) %>%
  pull(AvgYearlySalary_IndividualJobs)

in_all_occ <- df %>%
  filter(State == "IN", JobCode == "00-0000") %>%
  summarise(AllOccupations_AverageYearlySalary = mean(AverageYearlySalary)) %>%
  pull(AllOccupations_AverageYearlySalary)

comparison <- tibble(
  Metric = c("Indiana mean yearly salary (individual jobs)", "Indiana 'All Occupations' yearly salary (00-0000)"),
  Value  = c(in_avg_individual, in_all_occ)
)

write_xlsx(comparison, "IndianaSalaryComparison.xlsx")

# Print to console too (nice for your output capture)
print(comparison)

# -----------------------------
# 8) Chart: compare average yearly salaries of Computer & Mathematical occupations (15-xxxx)
#    in Indiana, California, New York
# -----------------------------
cm <- df %>%
  filter(State %in% c("IN", "CA", "NY"),
         str_detect(JobCode, "^15-\\d{4}$"),
         is_detailed_job(JobCode)) %>%
  select(State, JobCode, JobName, AverageYearlySalary)

p <- ggplot(cm, aes(x = JobName, y = AverageYearlySalary, fill = State)) +
  geom_col(position = "dodge") +
  labs(
    title = "Average Yearly Salaries: Computer & Mathematical Occupations (15-xxxx)",
    subtitle = "Indiana vs California vs New York",
    x = "Occupation",
    y = "Average Yearly Salary"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))

ggsave("ComputerMath_IN_CA_NY.png", p, width = 14, height = 7, dpi = 150)
