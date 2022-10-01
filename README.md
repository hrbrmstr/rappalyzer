
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Signed
by](https://img.shields.io/badge/Keybase-Verified-brightgreen.svg)](https://keybase.io/hrbrmstr)
![Signed commit
%](https://img.shields.io/badge/Signed_Commits-0%25-lightgrey.svg)
[![Linux build
Status](https://travis-ci.org/hrbrmstr/rappalyzer.svg?branch=master)](https://travis-ci.org/hrbrmstr/rappalyzer)
[![Coverage
Status](https://codecov.io/gh/hrbrmstr/rappalyzer/branch/master/graph/badge.svg)](https://codecov.io/gh/hrbrmstr/rappalyzer)
![Minimal R
Version](https://img.shields.io/badge/R%3E%3D-3.2.0-blue.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)

# rappalyzer

Identify Technologies Used On Websites

## Description

The ‘Wappalyzer’ project <https://wappalyzer.com/> maintains a database
of features that can be compared and combined to identify what
technologies – servers, frameworks, analytics tools, etc. – are being
used by a target web site. Methods are provided that mimic the
functionality of ‘Wappalyzer’ in R.

## IMPORTANT

This package has been updated to use Wappalyzer v6.10.40.

It is still a major WIP.

You will temporarily need to do your own “joins” for applications,
categories and groups via `wap_application()`, `wap_categories()`, and
`wap_groups()`.

## What’s Inside The Tin

The following functions are implemented:

- `rapp_icon`: Provide the full URL to the “icon” file within the
  package
- `rappalyze`: Identify technologies used on a given site/URL
- `wap_application`: Wappalyzer Applications (TEMPORARY HELPER)
- `wap_categories`: Wappalyzer Categories (TEMPORARY HELPER)
- `wap_groups`: Wappalyzer Groups (TEMPORARY HELPER)

## Installation

``` r
remotes::install_github("hrbrmstr/rappalyzer")
```

NOTE: To use the ‘remotes’ install options you will need to have the
[{remotes} package](https://github.com/r-lib/remotes) installed.

## Usage

``` r
library(rappalyzer)
library(ragg)
# current version
packageVersion("rappalyzer")
## [1] '0.2.0'
```

``` r
rappalyze("https://rud.is/b") 
## # A tibble: 5 × 10
##   name           description                                  slug  catego…¹ confi…² version icon  website pricing cpe  
##   <chr>          <chr>                                        <chr> <list>     <int> <chr>   <chr> <chr>   <list>  <chr>
## 1 Nginx          Nginx is a web server that can also be used… nginx <tibble>     100 ""      Ngin… http:/… <list>  cpe:…
## 2 jQuery Migrate Query Migrate is a javascript library that … jque… <tibble>     100 "3.3.2" jQue… https:… <list>  <NA> 
## 3 jQuery         jQuery is a JavaScript library which is a f… jque… <tibble>     100 ""      jQue… https:… <list>  cpe:…
## 4 HSTS           HTTP Strict Transport Security (HSTS) infor… hsts  <tibble>     100 ""      defa… https:… <list>  <NA> 
## 5 Prism          Prism is an extensible syntax highlighter.   prism <tibble>     100 ""      Pris… http:/… <list>  <NA> 
## # … with abbreviated variable names ¹​categories, ²​confidence

rappalyze("https://greynoise.io/blog")
## # A tibble: 4 × 10
##   name      description                                       slug  catego…¹ confi…² version icon  website pricing cpe  
##   <chr>     <chr>                                             <chr> <list>     <int> <chr>   <chr> <chr>   <list>  <chr>
## 1 Varnish   Varnish is a reverse caching proxy.               varn… <tibble>     100 ""      Varn… http:/… <list>  cpe:…
## 2 Nginx     Nginx is a web server that can also be used as a… nginx <tibble>     100 ""      Ngin… http:/… <list>  cpe:…
## 3 OpenResty OpenResty is a web platform based on nginx which… open… <tibble>     100 ""      Open… http:/… <list>  <NA> 
## 4 jQuery    jQuery is a JavaScript library which is a free, … jque… <tibble>     100 ""      jQue… https:… <list>  cpe:…
## # … with abbreviated variable names ¹​categories, ²​confidence

rappalyze("https://docs.rs/") 
## # A tibble: 4 × 10
##   name                description                             slug  catego…¹ confi…² version icon  website pricing cpe  
##   <chr>               <chr>                                   <chr> <list>     <int> <chr>   <chr> <chr>   <list>  <chr>
## 1 Ubuntu              Ubuntu is a free and open-source opera… ubun… <tibble>     100 ""      Ubun… http:/… <list>  cpe:…
## 2 Amazon Web Services Amazon Web Services (AWS) is a compreh… amaz… <tibble>     100 ""      aws.… https:… <list>  <NA> 
## 3 Nginx               Nginx is a web server that can also be… nginx <tibble>     100 "1.14.… Ngin… http:/… <list>  cpe:…
## 4 Amazon Cloudfront   Amazon CloudFront is a fast content de… amaz… <tibble>     100 ""      Amaz… http:/… <list>  <NA> 
## # … with abbreviated variable names ¹​categories, ²​confidence

rappalyze("https://tailwindcss.com/")
## # A tibble: 4 × 10
##   name                             description                slug  catego…¹ confi…² version icon  website pricing cpe  
##   <chr>                            <chr>                      <chr> <list>     <int> <chr>   <chr> <chr>   <list>  <chr>
## 1 Cloudflare Network Error Logging Cloudflare Network Error … clou… <tibble>     100 ""      Clou… https:… <list>  <NA> 
## 2 Vercel                           <NA>                       verc… <tibble>     100 ""      verc… https:… <list>  <NA> 
## 3 HSTS                             HTTP Strict Transport Sec… hsts  <tibble>     100 ""      defa… https:… <list>  <NA> 
## 4 Cloudflare                       Cloudflare is a web-infra… clou… <tibble>     100 ""      Clou… http:/… <list>  <NA> 
## # … with abbreviated variable names ¹​categories, ²​confidence

rappalyze("https://example.com")
## # A tibble: 5 × 10
##   name                description                             slug  catego…¹ confi…² version icon  website pricing cpe  
##   <chr>               <chr>                                   <chr> <list>     <int> <chr>   <chr> <chr>   <list>  <chr>
## 1 Azure               Azure is a cloud computing service for… azure <tibble>     100 ""      azur… https:… <list>  <NA> 
## 2 Docker              Docker is a tool designed to make it e… dock… <tibble>     100 ""      Dock… https:… <list>  cpe:…
## 3 Amazon Web Services Amazon Web Services (AWS) is a compreh… amaz… <tibble>     100 ""      aws.… https:… <list>  <NA> 
## 4 Amazon ECS          <NA>                                    amaz… <tibble>     100 ""      aws.… https:… <list>  <NA> 
## 5 Azure CDN           Azure Content Delivery Network (CDN) r… azur… <tibble>     100 ""      azur… https:… <list>  <NA> 
## # … with abbreviated variable names ¹​categories, ²​confidence
```

## rappalyzer Metrics

| Lang | \# Files |  (%) | LoC |  (%) | Blank lines |  (%) | \# Lines |  (%) |
|:-----|---------:|-----:|----:|-----:|------------:|-----:|---------:|-----:|
| R    |        8 | 0.44 | 143 | 0.46 |          56 | 0.37 |       57 | 0.32 |
| Rmd  |        1 | 0.06 |  14 | 0.04 |          20 | 0.13 |       31 | 0.18 |
| SUM  |        9 | 0.50 | 157 | 0.50 |          76 | 0.50 |       88 | 0.50 |

clock Package Metrics for rappalyzer
