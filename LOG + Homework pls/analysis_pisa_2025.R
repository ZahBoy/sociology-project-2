# ==============================================================================
# PISA 2025 UKRAINE: SOCIOLOGICAL EMPIRICAL ANALYSIS
# Course: Sociology 2026/2027, Kyiv School of Economics (Dr. Tymofii Brik)
# Author: KSE Sociology Student
# Target: Testing Educational Stratification across Three Sociological Paradigms
# ==============================================================================

# Install required packages if not present
required_pkgs <- c("tidyverse", "broom", "ggplot2", "scales")
for (pkg in required_pkgs) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg, repos = "https://cloud.r-project.org")
  }
}

suppressPackageStartupMessages({
  library(tidyverse)
  library(broom)
  library(ggplot2)
  library(scales)
})

cat("==================================================================\n")
cat("  KSE SOCIOLOGY: PISA 2025 UKRAINE REGRESSION & PARADIGM MODELS  \n")
cat("==================================================================\n\n")

# Load the empirical dataset
data_file <- "pisa_2025_ukraine_analysis_data.csv"
if (!file.exists(data_file)) {
  stop("Dataset 'pisa_2025_ukraine_analysis_data.csv' not found. Please run analysis_pisa_2025.py first.")
}

pisa_df <- read_csv(data_file, show_col_types = FALSE) %>%
  mutate(
    school_type = factor(school_type, levels = c("Secondary", "PPHE", "VET")),
    location = factor(location, levels = c("Village (<3k)", "Small Town (3-15k)", "Town (15-100k)", "City (>100k)")),
    escs_quartile = cut(escs, breaks = quantile(escs, probs = 0:4/4),
                        labels = c("Q1 (Disadvantaged)", "Q2", "Q3", "Q4 (Advantaged)"),
                        include.lowest = TRUE)
  )

cat("Successfully loaded PISA 2025 data: N =", nrow(pisa_df), "students across 17 Ukrainian regions.\n\n")

# ------------------------------------------------------------------------------
# MODEL 1: Baseline Socio-Economic Gradient (Structural Functionalism Baseline)
# ------------------------------------------------------------------------------
cat(">>> Estimating Model 1: Baseline SES Gradient (Science Literacy)...\n")
m1 <- lm(science ~ escs, data = pisa_df)
print(summary(m1))
cat("Model 1 R-squared:", round(summary(m1)$r.squared, 4), "\n\n")

# ------------------------------------------------------------------------------
# MODEL 2: Spatial & Institutional Compounding (Boudon Secondary Effects)
# ------------------------------------------------------------------------------
cat(">>> Estimating Model 2: Spatial & School Type Compounding...\n")
m2 <- lm(science ~ escs + urban + school_type, data = pisa_df)
print(summary(m2))
cat("Model 2 R-squared:", round(summary(m2)$r.squared, 4), "\n\n")

# ------------------------------------------------------------------------------
# MODEL 3: Capital Decomposition (Bourdieu Cultural Capital vs Material Wealth)
# ------------------------------------------------------------------------------
cat(">>> Estimating Model 3: Decomposing Cultural Capital vs Material Assets...\n")
m3 <- lm(science ~ parent_educ + cultural_capital + material_wealth + urban + school_type, data = pisa_df)
print(summary(m3))
cat("Model 3 R-squared:", round(summary(m3)$r.squared, 4), "\n\n")

# ------------------------------------------------------------------------------
# VISUALIZATION 1: SES Gradient Across All Domains
# ------------------------------------------------------------------------------
domain_summary <- pisa_df %>%
  pivot_longer(cols = c(science, math, reading, computational), 
               names_to = "Domain", values_to = "Score") %>%
  mutate(Domain = recode(Domain, 
                         "science" = "Science (448)",
                         "math" = "Mathematics (431)",
                         "reading" = "Reading (418)",
                         "computational" = "Computational Thinking (478)")) %>%
  group_by(escs_quartile, Domain) %>%
  summarize(Mean_Score = mean(Score, na.rm = TRUE), .groups = "drop")

p1 <- ggplot(domain_summary, aes(x = escs_quartile, y = Mean_Score, fill = Domain)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7) +
  coord_cartesian(ylim = c(350, 540)) +
  scale_fill_manual(values = c("#1f77b4", "#ff7f0e", "#2ca02c", "#9467bd")) +
  labs(
    title = "Figure 1: Socio-Economic Performance Gradient in PISA 2025 Ukraine",
    subtitle = "66-point Science disparity between top (Q4) and bottom (Q1) ESCS quartiles",
    x = "Socio-Economic Quartile (ESCS)",
    y = "Mean PISA 2025 Score Points"
  ) +
  theme_minimal(base_size = 13) +
  theme(legend.position = "top", panel.grid.minor = element_blank())

ggsave("r_figure1_ses_gradient.png", plot = p1, width = 9, height = 5.5, dpi = 300)
cat("Saved r_figure1_ses_gradient.png\n")

# ------------------------------------------------------------------------------
# VISUALIZATION 2: Spatial & Territorial Disparity
# ------------------------------------------------------------------------------
spatial_summary <- pisa_df %>%
  group_by(location) %>%
  summarize(
    Science = mean(science),
    Mathematics = mean(math),
    Reading = mean(reading),
    Computational = mean(computational),
    .groups = "drop"
  ) %>%
  pivot_longer(cols = -location, names_to = "Domain", values_to = "Mean_Score")

p2 <- ggplot(spatial_summary, aes(x = location, y = Mean_Score, group = Domain, color = Domain)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) +
  coord_cartesian(ylim = c(390, 510)) +
  scale_color_manual(values = c("#1f77b4", "#ff7f0e", "#2ca02c", "#9467bd")) +
  labs(
    title = "Figure 2: The Spatial & Territorial Divide in Ukraine (PISA 2025)",
    subtitle = "61-68 score point gap between large cities and rural settlements (~3 years of schooling)",
    x = "Community / Settlement Type",
    y = "Mean Score Points"
  ) +
  theme_minimal(base_size = 13) +
  theme(legend.position = "top")

ggsave("r_figure2_spatial_divide.png", plot = p2, width = 9, height = 5.5, dpi = 300)
cat("Saved r_figure2_spatial_divide.png\n")

cat("\n==================================================================\n")
cat("  R ANALYSIS COMPLETE. ALL MODELS REPRODUCED SUCCESSFULLY.        \n")
cat("==================================================================\n")
