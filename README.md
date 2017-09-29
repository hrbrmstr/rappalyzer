
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

    ## [1] "Google Font API" "jQuery"          "Nginx"           "PHP"             "WordPress"

``` r
rappalyze("https://blog.rapid7.com")
```

    ## [1] "Amazon Cloudfront"  "Express"            "Ghost"              "Google Tag Manager" "Gravatar"          
    ## [6] "jQuery"             "Nginx"              "Ubuntu"

``` r
rappalyze("https://community.rstudio.com") 
```

    ## [1] "Discourse" "jQuery"    "Nginx"

``` r
rappalyze("https://jquery.com/")
```

    ## [1] "CloudFlare" "Debian"     "jQuery"     "Modernizr"  "Nginx"      "PHP"        "WordPress"

``` r
rappalyze("https://wappalyzer.com")
```

    ## [1] "Amazon Cloudfront" "Nginx"             "Swiftlet"          "Ubuntu"
