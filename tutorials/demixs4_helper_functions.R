

library(tidyr)
library(stringr)
library(tidySEM)
library(psych)


df_probs <- function(x){
  
  sm <- as.data.frame(sum_pars(x))
  sm$class <- rownames(sm)
  
  sm2 <- pivot_longer(sm, 
                      cols = colnames(sm)[-ncol(sm)],
                      names_to = "Re",
                      values_to = "Probability")
  
  sm2 <- data.frame(sm2, 
                    str_split(sm2$Re, "\\.", simplify = T))
  sm2 <- sm2[,c(1,3,4,5)]
  colnames(sm2) <- c("class","Probability", "Variable", "Category")
  
  return(sm2)
}

## fm is the LCA model from depmixS4, 
## with multinomial("identity")



####
#### fit indices
####

calc_fitindices <- function (model){
  post_prob <- model@posterior[-1]
  class <- apply(post_prob, 1, which.max)
  class_tab <- table(class)
  if (length(class_tab) == ncol(post_prob)) {
    prop_n <- range(prop.table(class_tab))
  }
  else {
    prop_n <- c(0, max(prop.table(class_tab)))
  }
  fits <- c(
    ifelse(ncol(post_prob) == 1, 1, 1 + (1/(nrow(post_prob) *
                                              log(ncol(post_prob)))) * (sum(rowSums(post_prob *
                                                                                      log(post_prob + 1e-12))))),
    range(diag(tidySEM:::classification_probs_mostlikely(post_prob, class))),
    prop_n)
  names(fits) <- c("Entropy", "prob_min", "prob_max", "n_min", "n_max")
  
  return(fits)
}

get_fits <- function(x){
  
  fits <- c(tidySEM:::make_fitvector(ll=logLik(x),
                           parameters=x@npars,
                           n=nrow(x@posterior),
                           postprob=x@posterior[,-1] ), 
            calc_fitindices(x))
  
  return(fits)
}


avepp <- function(x){
  ## Add average posterior class probability (AvePP)
  desc_k <- psych::describeBy(x[,1:ncol(x)-1], 
                              group = x[,"predicted"])
  
  unq <- sort(unique(x[,"predicted"]))
  out <- NULL
  for(j in 1:length(unq)){
    temp <- desc_k[as.character(unq[j])][[1]][paste0("S",j),c("mean","sd","min","max")]
    out <- do.call(rbind, list(out, temp))
  }
  return(out)
}

sum_postprob <- function(model, priors=NULL){
  
  if(is.null(priors)){
    priors <- getmodel(model, "prior")@parameters$coefficients
  }
  mix_names <- colnames(model@posterior[,-1])
  numObs <- nrow(model@posterior[,-1])
  data.frame(class = mix_names, count = as.vector(priors*numObs), 
             proportion = as.vector(priors))
  
}

sum_mostlikely <- function(model){

  post_prob <- model@posterior[,-1]
  classif <- table(apply(post_prob, 1, which.max))
  mix_names <- colnames(model@posterior[,-1])
  data.frame(class = mix_names, count = as.vector(classif), 
             proportion = as.vector(prop.table(classif)))
}

class_prob_dm <- function(x, priors=NULL,
                          type = c("sum.posterior", "sum.mostlikely", 
                                      "mostlikely.class", "avg.mostlikely", 
                                      "AvePP","individual"), ...){
  post_probs <- x@posterior[,-1]
  post_probs_pred <- cbind(post_probs, predicted = apply(post_probs, 1, which.max) )
  
  out <- lapply(type, function(thetype){
    switch(thetype,
           "mostlikely.class" = tidySEM:::classification_probs_mostlikely(post_probs),
           "avg.mostlikely" = tidySEM:::avgprobs_mostlikely(post_probs),
           "sum.posterior" = sum_postprob(x, priors=priors), ###
           "sum.mostlikely" = sum_mostlikely(x), ###
           "AvePP"= avepp(post_probs_pred),
           "individual"= post_probs_pred)
  })
  names(out) <- type
  out
}



###
### summary of parameters without printing
###
sum_pars <- function(x){
  ns <- x@nstates
  pars <- list()
  np <- numeric(x@nresp)
  for(j in 1:x@nresp) {
    np[j] <- npar(x@response[[1]][[j]])
    pars[[j]] <- matrix(NA,nrow=ns,ncol=np[j])
  }
  
  allpars <- matrix(NA,nrow=ns,ncol=0)
  nms <- c()
  for(j in 1:x@nresp) {
    for(i in 1:ns) {
      tmp <- getpars(x@response[[i]][[j]])
      pars[[j]][i,] <- tmp
    }
    nmsresp <- paste("Re",j,sep="")
    nmstmp <- names(tmp)
    if(is.null(nmstmp)) nmstmp <- 1:length(tmp)
    nms <- c(nms,paste(nmsresp,nmstmp,sep="."))
    allpars <- cbind(allpars,pars[[j]])					
  }
  rownames(allpars) <- paste("St",1:ns,sep="")
  colnames(allpars) <- nms
  return(allpars)
}

###
### bvr
###

predcell_dm <- function(x, dat, priors=NULL){
  if(sum(dat == 0) > 0){y <- dat + 1}else{y <- dat}
  
  ## response probabilities as list
  sm <- as.data.frame(sum_pars(x))
  lns <- cumsum(apply(y, 2, FUN=function(M)length(unique(M))))
  probs <- list()
  for(j in 1:ncol(y)){
    if(j == 1){
      probs[[j]] <- sm[,1:lns[j]]}else{
        probs[[j]] <- sm[,(lns[j-1]+1):lns[j]]
      }
  }
  names(probs) <- colnames(y)
  
  ### 
  compy <- poLCA:::poLCA.compress(y)
  datacell <- compy$datamat
  rownames(datacell) <- NULL
  freq <- compy$freq
  
  ylik <- poLCA:::poLCA.ylik.C(poLCA:::poLCA.vectorize(probs),datacell) 
  if(is.null(priors)){
    P <- getmodel(x, "prior")@parameters$coefficients
  }else{P <- priors}
  fit <- matrix(nrow(y)/.Machine$double.xmax * (ylik  %*%  P))
  
  predcell <- data.frame(datacell,observed=freq,expected=round(fit,3)) 
  Chisq <- sum((freq-fit)^2/fit) + (nrow(y)-sum(fit))
  
  return(predcell )
}

bvr <- function(fit, dat, priors=NULL) {
  
  predcell <- predcell_dm(fit, dat, priors=priors)
  
  ov_names <- names(predcell)[1:(ncol(predcell) - 2)]
  ov_combn <- combn(ov_names, 2)
  
  get_bvr <- function(ov_pair) {
    form_obs <- as.formula(paste0("observed ~ ", ov_pair[1], " + ", ov_pair[2]))
    form_exp <- as.formula(paste0("expected ~ ", ov_pair[1], " + ", ov_pair[2]))
    
    counts_obs <- xtabs(form_obs, data = predcell)
    counts_exp <- xtabs(form_exp, data = predcell)
    
    bvr <- sum((counts_obs - counts_exp)^2 / counts_exp)
    
    bvr
  }
  
  bvr_pairs <- apply(ov_combn, 2, get_bvr)
  # names(bvr_pairs) <- apply(ov_combn, 2, paste, collapse = "<->")
  attr(bvr_pairs, "class") <- "dist"
  attr(bvr_pairs, "Size") <- length(ov_names)
  attr(bvr_pairs, "Labels") <- ov_names
  attr(bvr_pairs, "Diag") <- FALSE
  attr(bvr_pairs, "Upper") <- FALSE
  
  return(bvr_pairs)
}


##### residual correlations


res_cors <- function(x, dat, pv=F, method="pearson"){
  
  y <- dat
  y$class <- x@posterior[,1]
  
  unq <- sort(unique(y$class))
  res_cor <- list()
  for(j in 1:length(unq)){
    if(pv){
      res_cor[[j]] <- corr.test(y[y$class == unq[j],colnames(dat)], 
                                method = method)
    }else{
      res_cor[[j]] <- cor(y[y$class == unq[j],colnames(dat)], 
                                method = method)
    }
    
  }
  
  return(res_cor)
}

sum_list <- function(x, dat){
  y <- dat
  sm <- as.data.frame(sum_pars(x))
  lns <- cumsum(apply(y, 2, FUN=function(M)length(table(M))))
  probs <- list()
  for(j in 1:ncol(y)){
    if(j == 1){
      probs[[j]] <- sm[,1:lns[j]]}else{
        probs[[j]] <- sm[,(lns[j-1]+1):lns[j]]
      }
  }
  names(probs) <- colnames(y)
  
  return(list(Mix_probs=x@prior, 
              Pobrabilities=probs))
}


####
#### test
####


##
#bvr(fm, dat=balance[,c("d1","d2","d3","d4")])

#class_prob_dm(fm)

#get_fits(fm)

#df <- df_probs(fm) 

#plot_prob(df,
#          bars="Variable",
#          facet = "class")

#res_cors(fm, dat=balance[,c("d1","d2","d3","d4")], pv=F)
