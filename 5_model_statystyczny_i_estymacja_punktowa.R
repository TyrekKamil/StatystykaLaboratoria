# Zaj�cia 4 ####

# Zadanie 1 ---------------------------------------------------------------
# 1. 


# Zadanie 2 ---------------------------------------------------------------
load("Centrala.RData")

# 1.
rozklad_centrali = prop.table(table(Centrala))

# wykres s�upkowy
barplot(
  rozklad_centrali,
  xlab = "Liczba b��d�w", 
  ylab = "Prawdopodobie�stwo",
  main = "Rozk�ad empiryczny liczby b��d�w"
)

# sugeruj� rozklad Poissona
rozklad_poissona = dpois(
  x = 0:5, 
  lambda = mean(Centrala$Liczba)
)

barplot(
  rozklad_poissona, 
  names.arg = 0:5,
  xlab = "k", 
  ylab = "P(X=k)", 
  main = "Funkcja prawdopodobie�stwa"
)

both <- rbind(rozklad_centrali, rozklad_poissona)
barplot(both,beside=T)
 
# 2. warto�� estymatora
v = as.vector(Centrala[1])
p_est = colMeans(v) / length(v)

p_est <- mean(Centrala$Liczba)

# 3.
probs <- dpois(x = sort(unique(Centrala$Liczba)), lambda = p_est)
sum(probs)

counts <- matrix(
  c(rozklad_centrali, probs), 
  nrow = 2, 
  byrow = TRUE
)
rownames(counts) <- c("empiryczny", "teoretyczny")
colnames(counts) <- sort(unique(Centrala$Liczba))
counts

barplot(
  counts, 
  xlab = "Liczba b��d�w", ylab = "Prawdopodobie�stwo",
  main = "Rozk�ady empiryczny i teoretyczny liczby b��d�w",
  col = c("red", "blue"), 
  legend = rownames(counts), 
  beside = TRUE
)

# 4.
# wykres kwantyl-kwantyl

qq_1 = matrix(
  c(rozklad_centrali), 
  nrow = 1, 
  byrow = TRUE
)

qq_2 = matrix(
  c(probs), 
  nrow = 1, 
  byrow = TRUE
)

qqplot(qq_1, qq_2)
qqline(qq_1, distribution = function(qq_2) { qpois(qq_2, lambda = mean(Centrala$Liczba)) })

# 5.


# 6.
# empirycznie
mean(Centrala$Liczba < 4)

# teoretycznie: X ~ U(a_est, b_est) oraz P(X > 10) = 1 - P(X <= 10) = 1 - F(10)
ppois(3, lambda = mean(Centrala$Liczba))

# Zadanie 3 ---------------------------------------------------------------



# Zadanie 4 ---------------------------------------------------------------
wiatr = c(0.9, 6.2, 2.1, 4.1, 7.3, 1.0, 4.6, 6.4, 3.8, 5.0, 2.7, 9.2, 5.9, 7.4, 3.0, 4.9, 8.2, 5.0, 1.2, 10.1, 12.2, 2.8, 5.9, 8.2, 0.5)

# 1.
# sugeruj� rozk�ad Rayleigha

# 2.
# estymator najwi�kszej wiarygodno�ci 
ENW = mean(wiatr^2)

lambda = ENW

# 3,
# histogram z estymatorem j�drowym g�sto�ci
hist(
  wiatr, 
  xlab = "Czas oczekiwania na tramwaj", 
  main = "Rozk�ad empiryczny czasu oczekiwania na tramwaj",
  probability = TRUE, 
  col = "lightgreen"
)

# empiryczny
lines(
  density(wiatr), 
  col = "red", 
  lwd = 2
)

# teoretyczny
lambda <- ENW
curve(
  VGAM::drayleigh(x, sqrt(lambda / 2)), 
  col = "blue", 
  add = TRUE, 
  lwd = 2
)

# 4.
# wykres kwantyl-kwantyl
EnvStats::qqPlot(
  wiatr, 
  distribution = "unif", 
  param.list = list(
    min = min(wiatr), 
    max = max(wiatr)
  ),
  add.line = TRUE
)

# 5.
# dlaczego nie, kogo to interesuje

# 6.
# Oblicz empiryczne i teoretyczne prawdopodobie�stwo, �e �rednia szybko�� wiatru jest zawarta w przedziale [4, 8]

# estymatory: min i max
min_w = min(wiatr)
max_w = max(wiatr)

# empirycznie
mean(c(wiatr >= 4 & wiatr <= 8))

# teoretycznie
more_than_4 = VGAM::prayleigh(3)
more_than_8 = VGAM::prayleigh(8)

between_4_and_8 = more_than_4 - more_than_8

# 7.

