* Encoding: UTF-8.

DATASET ACTIVATE DataSet3.
COMPUTE Coefficients_Tax_Share=Tax_Revenue_Percentage_of_GDP * 0.01.
EXECUTE.

COMPUTE Total_Tax_Revenue=Coefficients_Tax_Share * GDP_in_bln_USDollars_2021.
EXECUTE.

COMPUTE Tax_Revenue_percapita=Total_Tax_Revenue / Population.
EXECUTE.

COMPUTE Coefficients_NonTax_Share=1 - Coefficients_Tax_Share.
EXECUTE.

COMPUTE Total_NonTax_Revenues=Coefficients_NonTax_Share * GDP_in_bln_USDollars_2021.
EXECUTE.

COMPUTE Coefficients_Government_Expenditure=Gov_Exp_Percent_GDP * 0.01.
EXECUTE.

COMPUTE Total_Government_Expenditure=Coefficients_Government_Expenditure * 
    GDP_in_bln_USDollars_2021.
EXECUTE.

COMPUTE Government_Expenditure_percapita=Total_Government_Expenditure / Population.
EXECUTE.

GRAPH
  /HISTOGRAM=ID_Ownership_Age15Plus_2021.

FREQUENCIES VARIABLES=ID_Ownership_Age15Plus_2021
  /STATISTICS=STDDEV MEAN MEDIAN
  /ORDER=ANALYSIS.

CORRELATIONS
  /VARIABLES=Online_Service_Index Democracy_Index Income_Tax_Rate ID_Ownership_Age15Plus_2021
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.

CORRELATIONS
  /VARIABLES=Online_Service_Index Democracy_Index ID_Ownership_Age15Plus_2021 Total_NonTax_Revenues
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.

COMPUTE Moderation_Variable=ID_Ownership_Age15Plus_2021 * EmploymentRatio_15_TotalPop.
EXECUTE.

CORRELATIONS
  /VARIABLES=Online_Service_Index Democracy_Index ID_Ownership_Age15Plus_2021 Moderation_Variable
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT Tax_Revenue_percapita
  /METHOD=ENTER ID_Ownership_Age15Plus_2021 Online_Service_Index Democracy_Index Income_Tax_Rate.

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT Tax_Revenue_percapita
  /METHOD=ENTER ID_Ownership_Age15Plus_2021 Online_Service_Index Democracy_Index 
    Total_NonTax_Revenues.

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT Tax_Revenue_percapita
  /METHOD=ENTER ID_Ownership_Age15Plus_2021 Online_Service_Index Democracy_Index 
    Moderation_Variable Income_Tax_Rate.
