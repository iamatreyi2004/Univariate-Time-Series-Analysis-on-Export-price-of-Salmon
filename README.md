# Univariate Time Series Analysis and Forecasting of Salmon Export Prices


This project presents a univariate time-series analysis and forecasting study of the monthly export price of farm-bred Norwegian Salmon from 2004 to 2016. The analysis was carried out using R and focuses on identifying the underlying time-series characteristics, developing an appropriate SARIMA model, and forecasting future export prices.

## Objectives

* Analyze the underlying pattern of salmon export prices.
* Identify trend, seasonality, and irregular fluctuations.
* Testing stationarity in the time series using ADF test.
* Determination of orders of MA and AR process for SARIMA model fitting using ACF and PACF of the data.
* Comparison of all possible pairs of candidate models using Akaike Information Criterion (AIC).
* Fitting the best model in terms of lowest AIC and generating forecasts.
* Validating the fact that model is free of variations by testing for independence of residuals using Ljung-Box.


## Key Results

* Original series: **Non-stationary**
* After first-order differencing: **Stationary**
* Selected model: **SARIMA (1,1,0)(1,0,1)**
* Lowest AIC: **104.1112**
* Ljung-Box p-value: **0.9296**
* Residuals: **Consistent with randomness**

## Limitations

SARIMA assumes a linear structure and may not adequately represent nonlinear patterns. Manual identification of model orders using ACF and PACF can also be subjective. Additionally, relying solely on AIC or other individual measures may not always guarantee the best forecasting model.

## Future Scope

The forecasting approach can be improved by:

* Combining SARIMA with deep-learning models such as LSTM, CNN, or Transformers.
* Using Auto-ARIMA to automate model-order selection.
* Incorporating external explanatory variables using SARIMAX.
* Including factors such as feed costs and ocean temperatures that may influence salmon export prices.

## Conclusion

The study demonstrates the application of classical time-series techniques for analyzing and forecasting salmon export prices. After achieving stationarity through first-order differencing and evaluating candidate models, **SARIMA (1,1,0)(1,0,1)** was selected based on AIC. Residual diagnostics further supported the adequacy of the fitted model, making it a useful baseline approach for forecasting salmon export prices.
