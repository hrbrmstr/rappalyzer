
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

-   `rappalyze`: Identify technologies used on a given site/URL
-   `rapp_icon`: Provide the full path to the "icon" file within the package
-   `rebuild_apps_inventory`: Rebuild apps inventory with a different master file

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
rappalyze("https://rud.is/b") %>% unnest()
```

    ## # A tibble: 7 x 7
    ##   match_kind       match_app               url                icon implies              cat_name cat_priority
    ##        <chr>           <chr>             <chr>               <chr>   <chr>                 <chr>        <chr>
    ## 1       html Google Font API https://rud.is/b/ Google Font API.png    <NA>          Font Scripts            9
    ## 2       html       WordPress https://rud.is/b/       WordPress.svg     PHP                   CMS            1
    ## 3       html       WordPress https://rud.is/b/       WordPress.svg     PHP                 Blogs            1
    ## 4     script       WordPress https://rud.is/b/       WordPress.svg     PHP                   CMS            1
    ## 5     script       WordPress https://rud.is/b/       WordPress.svg     PHP                 Blogs            1
    ## 6    headers           Nginx https://rud.is/b/           Nginx.svg    <NA>           Web Servers            9
    ## 7    headers             PHP https://rud.is/b/             PHP.svg    <NA> Programming Languages            4

``` r
rappalyze("https://blog.rapid7.com")
```

    ## # A tibble: 8 x 7
    ##   match_kind          match_app                      url   implies                   icon  cat_name cat_priority
    ##        <chr>              <chr>                    <chr>    <list>                  <chr>    <list>       <list>
    ## 1       html Google Tag Manager https://blog.rapid7.com/ <chr [1]> Google Tag Manager.png <chr [1]>    <chr [1]>
    ## 2       html           Gravatar https://blog.rapid7.com/ <chr [1]>           Gravatar.png <chr [1]>    <chr [1]>
    ## 3       meta              Ghost https://blog.rapid7.com/ <chr [1]>              Ghost.png <chr [1]>    <chr [1]>
    ## 4    headers  Amazon Cloudfront https://blog.rapid7.com/ <chr [1]>  Amazon-Cloudfront.svg <chr [1]>    <chr [1]>
    ## 5    headers            Express https://blog.rapid7.com/ <chr [1]>            Express.png <chr [1]>    <chr [1]>
    ## 6    headers            Express https://blog.rapid7.com/ <chr [1]>            Express.png <chr [1]>    <chr [1]>
    ## 7    headers              Nginx https://blog.rapid7.com/ <chr [1]>              Nginx.svg <chr [1]>    <chr [1]>
    ## 8    headers             Ubuntu https://blog.rapid7.com/ <chr [1]>             Ubuntu.png <chr [1]>    <chr [1]>

``` r
rappalyze("https://community.rstudio.com") %>% unnest()
```

    ## # A tibble: 3 x 7
    ##   match_kind        match_app                            url                 icon       implies       cat_name
    ##        <chr>            <chr>                          <chr>                <chr>         <chr>          <chr>
    ## 1       meta        Discourse https://community.rstudio.com/        Discourse.png Ruby on Rails Message Boards
    ## 2     script Google Analytics https://community.rstudio.com/ Google Analytics.svg          <NA>      Analytics
    ## 3    headers            Nginx https://community.rstudio.com/            Nginx.svg          <NA>    Web Servers
    ## # ... with 1 more variables: cat_priority <chr>

``` r
rappalyze("https://www.quantcast.com")
```

    ## # A tibble: 10 x 7
    ##    match_kind      match_app                        url   implies               icon  cat_name cat_priority
    ##         <chr>          <chr>                      <chr>    <list>              <chr>    <list>       <list>
    ##  1       html W3 Total Cache https://www.quantcast.com/ <chr [1]> W3 Total Cache.png <chr [1]>    <chr [1]>
    ##  2       html      WordPress https://www.quantcast.com/ <chr [1]>      WordPress.svg <chr [1]>    <chr [1]>
    ##  3       html      WordPress https://www.quantcast.com/ <chr [1]>      WordPress.svg <chr [1]>    <chr [1]>
    ##  4       html      Yoast SEO https://www.quantcast.com/ <chr [1]>      Yoast SEO.png <chr [1]>    <chr [1]>
    ##  5       meta      WordPress https://www.quantcast.com/ <chr [1]>      WordPress.svg <chr [1]>    <chr [1]>
    ##  6       meta      WordPress https://www.quantcast.com/ <chr [1]>      WordPress.svg <chr [1]>    <chr [1]>
    ##  7     script      Modernizr https://www.quantcast.com/ <chr [1]>      Modernizr.png <chr [1]>    <chr [1]>
    ##  8     script     Optimizely https://www.quantcast.com/ <chr [1]>     Optimizely.png <chr [1]>    <chr [1]>
    ##  9     script         jQuery https://www.quantcast.com/ <chr [1]>         jQuery.svg <chr [1]>    <chr [1]>
    ## 10    headers          Nginx https://www.quantcast.com/ <chr [1]>          Nginx.svg <chr [1]>    <chr [1]>

``` r
rappalyze("https://jquery.com/") %>% unnest()
```

    ## # A tibble: 12 x 7
    ##    match_kind        match_app                 url                 icon implies              cat_name cat_priority
    ##         <chr>            <chr>               <chr>                <chr>   <chr>                 <chr>        <chr>
    ##  1       html        WordPress https://jquery.com/        WordPress.svg     PHP                   CMS            1
    ##  2       html        WordPress https://jquery.com/        WordPress.svg     PHP                 Blogs            1
    ##  3       meta        WordPress https://jquery.com/        WordPress.svg     PHP                   CMS            1
    ##  4       meta        WordPress https://jquery.com/        WordPress.svg     PHP                 Blogs            1
    ##  5     script Google Analytics https://jquery.com/ Google Analytics.svg    <NA>             Analytics            9
    ##  6     script        Modernizr https://jquery.com/        Modernizr.png    <NA> JavaScript Frameworks            3
    ##  7     script        WordPress https://jquery.com/        WordPress.svg     PHP                   CMS            1
    ##  8     script        WordPress https://jquery.com/        WordPress.svg     PHP                 Blogs            1
    ##  9     script           jQuery https://jquery.com/           jQuery.svg    <NA> JavaScript Frameworks            3
    ## 10    headers       CloudFlare https://jquery.com/       CloudFlare.svg    <NA>                   CDN            9
    ## 11    headers           Debian https://jquery.com/           Debian.png    <NA>     Operating Systems            5
    ## 12    headers            Nginx https://jquery.com/            Nginx.svg    <NA>           Web Servers            9

``` r
rappalyze("https://wappalyzer.com")
```

    ## # A tibble: 5 x 7
    ##   match_kind         match_app                     url   implies                  icon  cat_name cat_priority
    ##        <chr>             <chr>                   <chr>    <list>                 <chr>    <list>       <list>
    ## 1     script  Google Analytics https://wappalyzer.com/ <chr [1]>  Google Analytics.svg <chr [1]>    <chr [1]>
    ## 2    headers Amazon Cloudfront https://wappalyzer.com/ <chr [1]> Amazon-Cloudfront.svg <chr [1]>    <chr [1]>
    ## 3    headers             Nginx https://wappalyzer.com/ <chr [1]>             Nginx.svg <chr [1]>    <chr [1]>
    ## 4    headers          Swiftlet https://wappalyzer.com/ <chr [1]>          Swiftlet.png <chr [1]>    <chr [1]>
    ## 5    headers            Ubuntu https://wappalyzer.com/ <chr [1]>            Ubuntu.png <chr [1]>    <chr [1]>
