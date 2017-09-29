
rappalyzer
==========

Identify Technologies Used On Websites

**WIP** - Stay tuned!

Description
-----------

The 'Wappalyzer' project <https://wappalyzer.com/> maintains a database of features that can be compared and combined to identify what technologies -- servers, frameworks, analytics tools, etc. -- are being used by a target web site. Methods are provided that mimic the functionality of 'Wappalyzer' in R.

Contents
--------

The following functions are implemented:

-   `rappalyze`: Identify technologies used on a given site/URL

Installation
------------

``` r
devtools::install_github("hrbrmstr/rappalyzer")
```

Usage
-----

``` r
library(rappalyzer)
library(tidyverse)

# current verison
packageVersion("rappalyzer")
```

    ## [1] '0.1.0'

``` r
rappalyze("https://rud.is/b") 
```

    ## # A tibble: 5 x 5
    ##              tech categories match_type version confidence
    ##             <chr>     <list>      <chr>   <chr>      <int>
    ## 1 Google Font API  <chr [1]>       html    <NA>        100
    ## 2           Nginx  <chr [1]>    headers  1.11.2        100
    ## 3             PHP  <chr [1]>    headers    <NA>        100
    ## 4       WordPress  <chr [1]>     script    <NA>        100
    ## 5          jQuery  <chr [1]>     script    <NA>        100

``` r
rappalyze("https://blog.rapid7.com")
```

    ## # A tibble: 8 x 5
    ##                 tech categories match_type version confidence
    ##                <chr>     <list>      <chr>   <chr>      <int>
    ## 1  Amazon Cloudfront  <chr [1]>    headers    <NA>        100
    ## 2            Express  <chr [1]>    headers    <NA>        100
    ## 3              Ghost  <chr [1]>       meta     1.7        100
    ## 4 Google Tag Manager  <chr [1]>       html    <NA>        100
    ## 5           Gravatar  <chr [1]>       html    <NA>        100
    ## 6              Nginx  <chr [1]>    headers  1.10.3        100
    ## 7             Ubuntu  <chr [1]>    headers    <NA>        100
    ## 8             jQuery  <chr [1]>     script    <NA>        100

``` r
rappalyze("https://community.rstudio.com") 
```

    ## # A tibble: 3 x 5
    ##        tech categories match_type version confidence
    ##       <chr>     <list>      <chr>   <chr>      <int>
    ## 1 Discourse  <chr [1]>       meta   1.9.0        100
    ## 2     Nginx  <chr [1]>    headers  1.11.8        100
    ## 3    jQuery  <chr [1]>     script    <NA>        100

``` r
rappalyze("https://jquery.com/")
```

    ## # A tibble: 7 x 5
    ##         tech categories match_type version confidence
    ##        <chr>     <list>      <chr>   <chr>      <int>
    ## 1 CloudFlare  <chr [1]>    headers    <NA>        100
    ## 2     Debian  <chr [1]>    headers    <NA>        100
    ## 3  Modernizr  <chr [1]>     script    <NA>        100
    ## 4      Nginx  <chr [1]>    headers    <NA>        100
    ## 5        PHP  <chr [1]>    headers  5.4.45        100
    ## 6  WordPress  <chr [1]>       meta   4.5.2        100
    ## 7     jQuery  <chr [1]>     script  1.11.3        100

``` r
rappalyze("https://wappalyzer.com")
```

    ## # A tibble: 4 x 5
    ##                tech categories match_type version confidence
    ##               <chr>     <list>      <chr>   <chr>      <int>
    ## 1 Amazon Cloudfront  <chr [1]>    headers    <NA>        100
    ## 2             Nginx  <chr [1]>    headers  1.10.3        100
    ## 3          Swiftlet  <chr [1]>    headers    <NA>        100
    ## 4            Ubuntu  <chr [1]>    headers    <NA>        100
