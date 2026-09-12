rm(list=ls())
library(astsa)
data=salmon
data=as.vector(data)
data=data[c(-1,-2,-3,-4)]
data
data=ts(data,start=2004,end=c(2016,12),freq=12)
data
plot(data,type="l",main="Time series plot",ylab="Export price of Salmon")

n=length(data)
n
i=ceiling(n*0.8)
train=data[1:i]
test=data[(i+1):n]
train=ts(train,start=2004,freq=12)
t=1:102
plot(train,type="l",main="Time series plot",ylab="Export price of Salmon")
year=2004:2012
t=1:10
yavg=aggregate(train,1,mean)
plot(yavg,type='l',main="Plot of yearly averages",ylab="yearly average")

#FITTING TREND EQUATION TO THE DATA
summary(lm(yavg~t))
summary(lm(yavg~t+I(t^2)))
#YEARLY TREND EQUATION BASED ON YEARLY AVERAGES
Tt=3.48593+0.25922*t
Tt
#MONTHLY TREND EQUATION BASED ON YEARLY AVERAGES
t=6:113
Tt=3.48593+(0.25922/12)*(t+0.5)
Tt=2.55583+((0.76655/12)*(t+0.5))-((0.05073/144)*(t+0.5)*(t+0.5))
Tt
#SEASONAL INDICES
dt=train/Tt
dt
dt=matrix(dt,nrow=9,ncol=12,byrow=T)
dt
si=apply(dt,2,mean)
si
sum(si)
a_si=si*(12/sum(si))
a_si
sum(a_si)
se=matrix(rep(a_si,times=9),ncol=12,byrow=T)
se
er=dt/se
er=as.vector(t(er))
er
plot(er,type="l",main="Residual plot",ylab="residuals")

Box.test(er,type="Ljung-Box")
#Reject null i.e errors are correlated

library(tseries)
train
adf.test(train)
d1=diff(train)
plot(d1,main="1st order differenced series",ylab="1st order difference(d1)",type="l")
adf.test(d1)
d2=diff(d1)
adf.test(d2)
plot(d2,main="2nd order differenced series",ylab="2nd order difference(d2)")



#possible values of d are 1 and 2

#p value=0.5204
#accept h0
#residual is non-stationary


acf(train,lag.max=100,main="ACF plot")
pacf(train,lag.max=100,main="PACF plot of original series")#p=1 or 0
d1=diff(train)
plot(d1,type='l',main="1 st order differenced series",ylab="d1")
acf(d1,lag.max=100)#q=0

d2=diff(d1)
acf(d2,lag.max=100)#q=1
pacf(d2,lag.max=100)






dd1=diff(train,lag=1)
dd1
plot(dd1,type="l")
acf(dd1,lag.max=100,main="ACF of 1st order differenced series")#q=1, d=1,Q=1
pacf(dd1,lag.max=100,main="PACF of 1 st order differenced series")# p=1 ,D=0,P=0 or 1
a=arima(train,order=c(1,1,1),seasonal = list(order=c(1,0,1),period=12),method="ML")

b=arima(train,order=c(1,1,0),seasonal = list(order=c(1,0,1),period=12),method="ML")
c=arima(train,order=c(0,1,1),seasonal = list(order=c(1,0,1),period=12),method="ML")
d=arima(train,order=c(0,1,0),seasonal = list(order=c(1,0,1),period=12),method="ML")

aic=c(a$aic,b$aic,c$aic,d$aic)
aic
rmse1=sum((a$residuals)^2)
rmse2=sum((b$residuals)^2)
rmse3=sum((c$residuals)^2)
rmse4=sum((d$residuals)^2)

rmse=c(rmse1,rmse2,rmse3,rmse4)
rmse
model=c("(1,1,1)(1,0,1)","(1,1,0)(1,0,1)","(0,1,1)(1,0,1)","(0,1,0)(1,0,1)")
df=data.frame(model,aic,rmse)
df

dstar=b$residuals
acf(dstar,lag.max=100,main="ACF of fitted residuals")
Box.test(dstar,type="Ljung-Box")


dd2=diff(dd1,lag=12)
dd2
Box.test(dd2,type="Ljung-Box")
# stationary
d=1
D=1
acf(dd2,lag.max=100,main="ACF plot")#q=1
pacf(dd2,lag.max=100,main="PACF plot")#p=2
#P=2 Q=1


library(forecast)
f1=forecast(a,h=length(test))
f1
pf1=f1$mean
pf1
pf1=as.numeric(pf1)
plot(pf1,type="l",ylim=c(4,12))
lines(test,col="red")
rmse1=sqrt(mean((pf1-test)^2))
rmse1
plot(pf1,type="l",ylim=c(4,12))
lines(test,col="red")



library(forecast)
f2=forecast(b,h=length(test))
f2
pf2=f2$mean
pf2
pf2=as.numeric(pf2)

plot(pf2,type="l",ylim=c(4,12),main="Forecasted vs Actual values",ylab="Export price of salmon(y)",xlab="time",col="blue")
lines(test,col="red")
legend("topleft",c("Forecasted value","Actual value"),col=c("blue","red"),lty=c("solid","solid"),text.width=3)

rmse2=sqrt(mean((pf2-test)^2))
rmse2


library(forecast)
f3=forecast(c,h=length(test))
f3
pf3=f3$mean
pf3
pf3=as.numeric(pf3)
rmse3=sqrt(mean((pf3-test)^2))
rmse3
resid=pf3-test
resid

plot(pf3,type="l",ylim=c(4,12),main="Forecasted vs Actual values",ylab="Export price of salmon(y)",xlab="time",col="blue")
lines(test,col="red")
legend("topleft",c("Forecasted value","Actual value"),col=c("blue","red"),lty=c("solid","solid"),text.width=3)


library(forecast)
f4=forecast(d,h=length(test))
f4
pf4=f4$mean
pf4=as.numeric(pf4)
rmse=sqrt(mean((pf4-test)^2))
rmse
plot(pf4,type="l",ylim=c(4,10),main="Forecasted vs Actual values",ylab="Export price of salmon(y)",xlab="time",col="blue")
lines(test,col="red")
legend("topleft",c("Forecasted value","Actual value"),col=c("blue","red"),lty=c("solid","solid"),text.width=3)



plot(pf4,type="l",ylim=c(4,10))
lines(test,col="red")




