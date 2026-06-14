#' Title Data generation with cross-loadings (generate factor scores)
#'
#' @param PL Primary loading size 
#' @param nvar.factor Number of items per factor
#' @param nfactors Number of factors
#' @param reliability Reliablity of items (control noise in X)
#' @param factor_corr Factor correlation
#' @param N Sample size
#' @param beta Regression coefficients when regressing y on the factors
#' @param VAFy Variance accounted for in y by the factors (control noise in y)
#'
#' @returns
#' @export
#'
#' @examples
data_generation <- function(PL, nvar.factor, nfactors, reliability, factor_corr, N, beta, VAFy, CL){
  # 1. initialize loadings
  fac <- matrix(c(rep(PL, times = nvar.factor )),
                nvar.factor, 1L)
  loadings <- lav_matrix_bdiag(rep(list(fac), nfactors))
  
  # 1.1. introduce cross-loadings
  if (CL == TRUE){
    i.cross <- (0:(nfactors-1))*nvar.factor+ceiling(nvar.factor/2)
    for (j in 1:ncol(loadings)) {
      loadings[i.cross[j],c(2:nfactors,1)[j]] <- .5
    }
  }
  
  # 2. generate factor scores
  Phi <- matrix(factor_corr, ncol = nfactors, nrow = nfactors) # factor correlation
  diag(Phi) <- 1
  scores <- mvrnorm(n = N, mu = rep(0, nfactors), Sigma = Phi, empirical = F)
  
  # 3. generate Theta to control reliability
  tmp <- diag(loadings %*% Phi %*% t(loadings))
  theta.diag <- tmp/reliability - tmp
  stopifnot(all(theta.diag > 0))
  theta <- matrix(0, nrow(loadings), nrow(loadings))
  diag(theta) <- theta.diag
  
  E <- mvrnorm(n = N, mu = rep(0, nfactors*nvar.factor), Sigma = theta)
  
  # 4. generate X
  X <- scores%*%t(loadings) + E
  
  # 5. generate y 
  Ytrue <- scores%*%beta
  # 5.1. add noise to match VAFy
  SSqYtrue =  sum(Ytrue^2)                        # sum squares of the data set
  EY = rnorm(N, mean = 0, sd = 1)                 # EX = Error of X
  SSqEY = sum(EY^2)                               # Sum squares fo the EX
  fy = sqrt(SSqYtrue*(1-VAFy)/(VAFy * SSqEY))
  y = Ytrue + fy*EY 
  
  data <- list(X = X, y = y, Ptrue = loadings, Htrue = scores)
}
  