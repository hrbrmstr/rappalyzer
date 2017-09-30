
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

    ## # A tibble: 6 x 5
    ##              tech              category match_type version confidence
    ##             <chr>                 <chr>      <chr>   <chr>      <dbl>
    ## 1 Google Font API          Font Scripts       html    <NA>        100
    ## 2           Nginx           Web Servers    headers  1.11.2        100
    ## 3             PHP Programming Languages    headers    <NA>        100
    ## 4       WordPress                   CMS     script    <NA>        100
    ## 5       WordPress                 Blogs     script    <NA>        100
    ## 6          jQuery JavaScript Frameworks     script    <NA>        100

``` r
rappalyze("https://blog.rapid7.com")
```

    ## # A tibble: 9 x 5
    ##                 tech              category match_type version confidence
    ##                <chr>                 <chr>      <chr>   <chr>      <dbl>
    ## 1  Amazon Cloudfront                   CDN    headers    <NA>        100
    ## 2            Express        Web Frameworks    headers    <NA>        100
    ## 3            Express           Web Servers    headers    <NA>        100
    ## 4              Ghost                 Blogs       meta     1.7        100
    ## 5 Google Tag Manager          Tag Managers       html    <NA>        100
    ## 6           Gravatar         Miscellaneous       html    <NA>        100
    ## 7              Nginx           Web Servers    headers  1.10.3        100
    ## 8             Ubuntu     Operating Systems    headers    <NA>        100
    ## 9             jQuery JavaScript Frameworks     script    <NA>        100

``` r
rappalyze("https://community.rstudio.com") 
```

    ## # A tibble: 3 x 5
    ##        tech              category match_type version confidence
    ##       <chr>                 <chr>      <chr>   <chr>      <dbl>
    ## 1 Discourse        Message Boards       meta   1.9.0        100
    ## 2     Nginx           Web Servers    headers  1.11.8        100
    ## 3    jQuery JavaScript Frameworks     script    <NA>        100

``` r
rappalyze("https://jquery.com/")
```

    ## # A tibble: 8 x 5
    ##         tech              category match_type version confidence
    ##        <chr>                 <chr>      <chr>   <chr>      <dbl>
    ## 1 CloudFlare                   CDN    headers    <NA>        100
    ## 2     Debian     Operating Systems    headers    <NA>        100
    ## 3  Modernizr JavaScript Frameworks     script    <NA>        100
    ## 4      Nginx           Web Servers    headers    <NA>        100
    ## 5        PHP Programming Languages    headers  5.4.45        100
    ## 6  WordPress                   CMS       meta   4.5.2        100
    ## 7  WordPress                 Blogs       meta   4.5.2        100
    ## 8     jQuery JavaScript Frameworks     script  1.11.3        100

``` r
rappalyze("https://wappalyzer.com")
```

    ## # A tibble: 4 x 5
    ##                tech          category match_type version confidence
    ##               <chr>             <chr>      <chr>   <chr>      <dbl>
    ## 1 Amazon Cloudfront               CDN    headers    <NA>        100
    ## 2             Nginx       Web Servers    headers  1.10.3        100
    ## 3          Swiftlet    Web Frameworks    headers    <NA>        100
    ## 4            Ubuntu Operating Systems    headers    <NA>        100
