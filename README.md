
rappalyzer
==========

Identify Technologies Used On Websites

**WIP** - basic tech stack identification is complete but versions and more metadata need to be added

Description
-----------

The 'Wappalyzer' project <https://wappalyzer.com/> maintains a database of features that can be compared and combined to identify what technologies -- servers, frameworks, analytics tools, etc. -- are being used by a target web site. Methods are provided that mimic the functionality of 'Wappalyzer' in R.

Contents
--------

The following functions are implemented:

-   `rappalyze` : Identify technologies used on a given site/URL

Installation
------------

``` r
devtools::install_github("hrbrmstr/rappalyzer")
```

Usage
-----

``` r
library(rappalyzer)

# current verison
packageVersion("rappalyzer")
```

    ## [1] '0.1.0'

``` r
rappalyze("https://rud.is/b")
```

    ## # A tibble: 5 x 3
    ##   match_kind       match_app               url
    ##        <chr>           <chr>             <chr>
    ## 1       html Google Font API https://rud.is/b/
    ## 2       html       WordPress https://rud.is/b/
    ## 3     script       WordPress https://rud.is/b/
    ## 4    headers           Nginx https://rud.is/b/
    ## 5    headers             PHP https://rud.is/b/

``` r
rappalyze("https://blog.rapid7.com")
```

    ## # A tibble: 7 x 3
    ##   match_kind          match_app                      url
    ##        <chr>              <chr>                    <chr>
    ## 1       html Google Tag Manager https://blog.rapid7.com/
    ## 2       html           Gravatar https://blog.rapid7.com/
    ## 3       meta              Ghost https://blog.rapid7.com/
    ## 4    headers  Amazon Cloudfront https://blog.rapid7.com/
    ## 5    headers            Express https://blog.rapid7.com/
    ## 6    headers              Nginx https://blog.rapid7.com/
    ## 7    headers             Ubuntu https://blog.rapid7.com/

``` r
rappalyze("https://community.rstudio.com")
```

    ## # A tibble: 3 x 3
    ##   match_kind        match_app                            url
    ##        <chr>            <chr>                          <chr>
    ## 1       meta        Discourse https://community.rstudio.com/
    ## 2     script Google Analytics https://community.rstudio.com/
    ## 3    headers            Nginx https://community.rstudio.com/

``` r
rappalyze("https://www.quantcast.com")
```

    ## # A tibble: 8 x 3
    ##   match_kind      match_app                        url
    ##        <chr>          <chr>                      <chr>
    ## 1       html W3 Total Cache https://www.quantcast.com/
    ## 2       html      WordPress https://www.quantcast.com/
    ## 3       html      Yoast SEO https://www.quantcast.com/
    ## 4       meta      WordPress https://www.quantcast.com/
    ## 5     script      Modernizr https://www.quantcast.com/
    ## 6     script     Optimizely https://www.quantcast.com/
    ## 7     script         jQuery https://www.quantcast.com/
    ## 8    headers          Nginx https://www.quantcast.com/

``` r
rappalyze("https://jquery.com/")
```

    ## # A tibble: 9 x 3
    ##   match_kind        match_app                 url
    ##        <chr>            <chr>               <chr>
    ## 1       html        WordPress https://jquery.com/
    ## 2       meta        WordPress https://jquery.com/
    ## 3     script Google Analytics https://jquery.com/
    ## 4     script        Modernizr https://jquery.com/
    ## 5     script        WordPress https://jquery.com/
    ## 6     script           jQuery https://jquery.com/
    ## 7    headers       CloudFlare https://jquery.com/
    ## 8    headers           Debian https://jquery.com/
    ## 9    headers            Nginx https://jquery.com/

``` r
rappalyze("https://wappalyzer.com")
```

    ## # A tibble: 5 x 3
    ##   match_kind         match_app                     url
    ##        <chr>             <chr>                   <chr>
    ## 1     script  Google Analytics https://wappalyzer.com/
    ## 2    headers Amazon Cloudfront https://wappalyzer.com/
    ## 3    headers             Nginx https://wappalyzer.com/
    ## 4    headers          Swiftlet https://wappalyzer.com/
    ## 5    headers            Ubuntu https://wappalyzer.com/

