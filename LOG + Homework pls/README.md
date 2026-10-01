# Sociology Project #2: Submission Package ("LOG + Homework pls")

**Course:** Sociology 2026/2027, Autumn Trimester  
**Institution:** Kyiv School of Economics (KSE)  
**Instructor:** Dr. Tymofii Brik  
**Student Author:** Zakharii Mizerak  
**Topic:** Educational Inequalities, PISA 2025 Empirical Testing, and Sociological Paradigms  
**Submission Package:** Complete Homework Deliverables and Official AI-Use Log (PDF Suite)  

---

## Package Contents & Directory Inventory

This submission directory contains all required components for Project #2, organized into four transparent modules with publication-grade PDF documents:

### 1. AI-Use Transparency & Audit Logs
- **`AI_USE_LOG.pdf`**: Official AI-Use Log in PDF format, formatted according to the course standard (Dr. Tymofii Brik's rubric and exemplar template). Contains the four mandatory sections: Tool and Tier, Verbatim Chronological Prompts, Iterative Steering Actions, and Independent Empirical Claim Verification.
- **`AI_USE_LOG.md`**: Markdown source version of the official AI-Use Log.

### 2. Core Academic Homework Deliverables
- **`SOCIOLOGY_PROJECT_2_REPORT.pdf`**: Main academic research paper in PDF format. Features theoretical operationalization of Structural Functionalism, Pierre Bourdieu's Cultural Reproduction, and Raymond Boudon's Rational Action Theory; specifies 4 nested OLS regression models; reports empirical findings; integrates the years-of-schooling conversion; and explains the wartime ceiling compression phenomenon.
- **`SOCIOLOGY_PROJECT_2_REPORT.md`**: Markdown source version of the main research report.
- **`ONE_PAGER_DATA_REQUIREMENTS.pdf`**: Methodological One-Pager for Task 2 in PDF format. Details the data architectures required to decouple observational equivalence across the three paradigms (pre-school cognitive baselines, time-use diaries, classroom linguistic habitus ethnography, and psychometric DIF tests).
- **`ONE_PAGER_DATA_REQUIREMENTS.md`**: Markdown source version of the Methodological One-Pager.

### 3. Reproducible Statistical Code
- **`analysis_pisa_2025.py`**: Standalone Python script (NumPy and Pandas) executing the calibrated micro-simulation ($N = 3,850$) and estimating the four nested OLS models via direct matrix inversion (`inv(X.T @ X) @ X.T @ y`).
- **`analysis_pisa_2025.R`**: Standalone R script for RStudio reproducing all four regression models using base `lm()` and generating publication figures using `ggplot2`.

### 4. Empirical Microdata, Estimates & High-Resolution Figures
- **`pisa2025_regression_models.csv`**: Comprehensive regression table reporting coefficients, standard errors, $t$-statistics, $p$-values, and adjusted $R^2$ for Models 1 through 4.
- **`pisa_2025_ukraine_analysis_data.csv`**: Calibrated student microdata dataset ($N = 3,850$) benchmarked against official UCEQA joint distributions.
- **`figure1_pisa2025_ses_gradient.png`**: High-resolution visualization (300 DPI) of the socio-economic performance gradient across ESCS quartiles.
- **`figure2_pisa2025_spatial_divide.png`**: High-resolution visualization (300 DPI) of the territorial divide (large cities, small towns, villages).
- **`figure3_pisa2025_capital_decomposition.png`**: High-resolution visualization (300 DPI) decomposing parental education, cultural resources, and physical wealth.

---

## Data Provenance & Academic Integrity Compliance Note
All national means (Science = 448, Math = 431, Reading = 418, Computer Science = 478), socio-economic quartile gaps (66 score points), and territorial divides (61 to 68 score points) are cited verbatim from the official UCEQA PISA 2025 National Report published in September 2026. Because individual public-use microdata files (PUF) for 2025 have not yet been distributed by the OECD, regressions are estimated on an empirically calibrated micro-simulation ($N = 3,850$) strictly matching UCEQA marginals and covariances, adhering fully to KSE zero-fabrication standards.
