# ec503_project

### Abstract 
 The study focuses on different instances of the Expected Maximization (EM) algorithm for incomplete or missing data or data with latent variables model. We analyze the EM algorithm under the paradigm of clustering. Here, we've implemented the EM algorithm for the Gaussian Mixture Models (GMM) and the Bernoulli Mixture Models (BMM). We also report the effects of various initialization techniques using: completely random parameters; random data points; and estimates from k-means clustering algorithm, which was itself initialized via k-means++, on the iterations of convergence and the output accuracy of the EM algorithm. We also provide a motivation for using EM for clustering over k-means by comparing the algorithms' performance on a GMM with three overlapping Gaussian in a complicated fashion (\textbf{Figure 1}). Lastly, we explore how EM helps mitigate the affects of missing data and analyze the output accuracy as a function of the ratio missing points and the observed points.



### Directories

## EM

All the code regard the EM algorithm with different initializations.

## EM_BMM

EM algorithm for BMM model with mnist data set with different initializations.

## EM_missing

All the code regard the EM algoritm that can handled missing data.
