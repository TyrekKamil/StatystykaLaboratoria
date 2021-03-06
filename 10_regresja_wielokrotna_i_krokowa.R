# Zaj�cia 10 ####


# zadanie 1 ---------------------------------------------------------------
data = read.csv("Automobile.csv", na = "?")

head(data)

# 1

data <- na.omit(data)

# 2

temp = subset(
  data, 
  select=c(
    "horsepower", 
    "city.mpg", 
    "peak.rpm", 
    "curb.weight", 
    "num.of.doors", 
    "price"
  )
)

pairs(temp)

model <- lm(price ~ horsepower + city.mpg + peak.rpm + curb.weight + num.of.doors, data = temp)
model

# Jakie s� warto�ci estymator�w wsp�czynnik�w regresji i przedzia�y ufno�ci? 
# Kt�re zmienne s� stymulantami a kt�re destymulantami?
# estymacja parametr�w
coef(model)
confint(model)

# Kt�re wsp�czynniki s� statystycznie istotne w skontruowanym modelu? 
# Jakie jest dopasowanie modelu?
summary(model)

# Oblicz warto�ci dopasowane przez model oraz warto�ci reszt.
fitted(model)
# reszty
residuals(model)

# 3
# Spr�buj zredukowa� model korzystaj�c z regresji krokowej (�backward�, �forward�, AIC, BIC).

model_0 = lm(price ~ 1, data = data)

step(model)
step(model, direction = "backward")
step(model_0, direction = "forward", scope = formula(model))
step(model_0, direction = "forward", scope = formula(model), k = log(nrow(data)))

# 4
# Dokonaj redukcji modelu metod� eliminacji wstecznej, 
# tak aby w kolejnych krokach z pe�nego modelu stopniowo usuwa� najmniej istotn� zmienn� niezale�n�, 
# a� otrzymamy model ze wszystkimi istotnymi zmiennymi niezale�nymi. 
# Jakie by�o zachowanie odpowiedniego wsp�czynnika determinacji w kolejnych modelach?

model_2 <- lm(price ~ horsepower + city.mpg + curb.weight + num.of.doors, data = data)
summary(model_2)$coefficients
summary(model_2)$adj.r.squared
  
model_2 <- lm(price ~ horsepower + curb.weight + num.of.doors, data = data)
summary(model_2)$coefficients
summary(model_2)$adj.r.squared

model_2 <- lm(price ~ horsepower + curb.weight, data = data)
summary(model_2)$coefficients
summary(model_2)$adj.r.squared


# zadanie 1.5 ---------------------------------------------------------------
# Zamiast usuwa� obserwacje z brakuj�cymi danymi, jak to zrobili�my w punkcie 1, 
# uzupe�nij je za pomoc� �redniej i mediany s�siednich warto�ci dla zmiennych ilo�ciowych i porz�dkowych, odpowiednio. 
# Aby to zrobi�, u�yj funkcji impute() dost�pnej w pakiecie Hmisc. 
# W przypadku takich danych post�puj zgodnie z instrukcjami w punktach 2-4.



# zadanie 1.6 ---------------------------------------------------------------
# Korzystaj�c z ostatecznych modeli uzyskanych dla obu zbior�w danych, wykonaj prognoz� ceny samochodu, 
# dla kt�rego zmienne curb.weight i horsepower s� r�wne 2823 i 154, odpowiednio. 
# Kt�ry model daje lepsz� prognoz�, gdyby cena tego samochodu wynosi�a 1650? Jak mo�emy to wyja�ni�?


model <- lm(price ~ horsepower + city.mpg + peak.rpm + curb.weight + num.of.doors, data = temp)

new_data <- data.frame(
  Curb.Weight = 2823, 
  Horsepower = 154
)

predict(model, new_data, interval = "prediction")
