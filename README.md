
rappalyzer
==========

Identify Technologies Used On Websites

**WIP** - basic tech stack identification is complete and some version info seems to be working but I think there's an isssue with the regexes & compatibility with `ore`.

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

    ## # A tibble: 5 x 8
    ##         match_app match_kind version               url                icon implies              cat_name cat_priority
    ##             <chr>      <chr>   <chr>             <chr>               <chr>   <chr>                 <chr>        <chr>
    ## 1 Google Font API       html    <NA> https://rud.is/b/ Google Font API.png    <NA>          Font Scripts            9
    ## 2       WordPress       html    <NA> https://rud.is/b/       WordPress.svg     PHP                   CMS            1
    ## 3       WordPress       html    <NA> https://rud.is/b/       WordPress.svg     PHP                 Blogs            1
    ## 4           Nginx    headers  1.11.2 https://rud.is/b/           Nginx.svg    <NA>           Web Servers            9
    ## 5             PHP    headers    <NA> https://rud.is/b/             PHP.svg    <NA> Programming Languages            4

``` r
rappalyze("https://blog.rapid7.com")
```

    ## # A tibble: 8 x 8
    ##            match_app match_kind version                      url   implies                   icon  cat_name
    ##                <chr>      <chr>   <chr>                    <chr>    <list>                  <chr>    <list>
    ## 1 Google Tag Manager       html    <NA> https://blog.rapid7.com/ <chr [1]> Google Tag Manager.png <chr [1]>
    ## 2           Gravatar       html    <NA> https://blog.rapid7.com/ <chr [1]>           Gravatar.png <chr [1]>
    ## 3              Ghost       meta     1.7 https://blog.rapid7.com/ <chr [1]>              Ghost.png <chr [1]>
    ## 4  Amazon Cloudfront    headers    <NA> https://blog.rapid7.com/ <chr [1]>  Amazon-Cloudfront.svg <chr [1]>
    ## 5            Express    headers    <NA> https://blog.rapid7.com/ <chr [1]>            Express.png <chr [1]>
    ## 6            Express    headers    <NA> https://blog.rapid7.com/ <chr [1]>            Express.png <chr [1]>
    ## 7              Nginx    headers  1.10.3 https://blog.rapid7.com/ <chr [1]>              Nginx.svg <chr [1]>
    ## 8             Ubuntu    headers    <NA> https://blog.rapid7.com/ <chr [1]>             Ubuntu.png <chr [1]>
    ## # ... with 1 more variables: cat_priority <list>

``` r
rappalyze("https://community.rstudio.com") %>% unnest()
```

    ## # A tibble: 3 x 8
    ##          match_app version match_kind                            url                 icon       implies       cat_name
    ##              <chr>   <chr>      <chr>                          <chr>                <chr>         <chr>          <chr>
    ## 1        Discourse   1.9.0       meta https://community.rstudio.com/        Discourse.png Ruby on Rails Message Boards
    ## 2 Google Analytics    <NA>     script https://community.rstudio.com/ Google Analytics.svg          <NA>      Analytics
    ## 3            Nginx  1.11.8    headers https://community.rstudio.com/            Nginx.svg          <NA>    Web Servers
    ## # ... with 1 more variables: cat_priority <chr>

``` r
rappalyze("https://www.quantcast.com")
```

    ## # A tibble: 7 x 8
    ##        match_app match_kind version                        url   implies               icon  cat_name cat_priority
    ##            <chr>      <chr>   <chr>                      <chr>    <list>              <chr>    <list>       <list>
    ## 1 W3 Total Cache       html    <NA> https://www.quantcast.com/ <chr [1]> W3 Total Cache.png <chr [1]>    <chr [1]>
    ## 2      WordPress       html    <NA> https://www.quantcast.com/ <chr [1]>      WordPress.svg <chr [1]>    <chr [1]>
    ## 3      WordPress       html    <NA> https://www.quantcast.com/ <chr [1]>      WordPress.svg <chr [1]>    <chr [1]>
    ## 4      Yoast SEO       html    <NA> https://www.quantcast.com/ <chr [1]>      Yoast SEO.png <chr [1]>    <chr [1]>
    ## 5      WordPress       meta   4.2.2 https://www.quantcast.com/ <chr [1]>      WordPress.svg <chr [1]>    <chr [1]>
    ## 6      WordPress       meta   4.2.2 https://www.quantcast.com/ <chr [1]>      WordPress.svg <chr [1]>    <chr [1]>
    ## 7          Nginx    headers    <NA> https://www.quantcast.com/ <chr [1]>          Nginx.svg <chr [1]>    <chr [1]>

``` r
rappalyze("https://jquery.com/") %>% unnest()
```

    ## # A tibble: 9 x 8
    ##          match_app match_kind version                 url                 icon implies              cat_name
    ##              <chr>      <chr>   <chr>               <chr>                <chr>   <chr>                 <chr>
    ## 1        WordPress       html    <NA> https://jquery.com/        WordPress.svg     PHP                   CMS
    ## 2        WordPress       html    <NA> https://jquery.com/        WordPress.svg     PHP                 Blogs
    ## 3        WordPress       meta   4.5.2 https://jquery.com/        WordPress.svg     PHP                   CMS
    ## 4        WordPress       meta   4.5.2 https://jquery.com/        WordPress.svg     PHP                 Blogs
    ## 5 Google Analytics     script    <NA> https://jquery.com/ Google Analytics.svg    <NA>             Analytics
    ## 6       CloudFlare    headers    <NA> https://jquery.com/       CloudFlare.svg    <NA>                   CDN
    ## 7           Debian    headers    <NA> https://jquery.com/           Debian.png    <NA>     Operating Systems
    ## 8            Nginx    headers    <NA> https://jquery.com/            Nginx.svg    <NA>           Web Servers
    ## 9              PHP    headers  5.4.45 https://jquery.com/              PHP.svg    <NA> Programming Languages
    ## # ... with 1 more variables: cat_priority <chr>

``` r
rappalyze("https://wappalyzer.com")
```

    ## # A tibble: 5 x 8
    ##           match_app version match_kind                     url   implies                  icon  cat_name cat_priority
    ##               <chr>   <chr>      <chr>                   <chr>    <list>                 <chr>    <list>       <list>
    ## 1  Google Analytics    <NA>     script https://wappalyzer.com/ <chr [1]>  Google Analytics.svg <chr [1]>    <chr [1]>
    ## 2 Amazon Cloudfront    <NA>    headers https://wappalyzer.com/ <chr [1]> Amazon-Cloudfront.svg <chr [1]>    <chr [1]>
    ## 3             Nginx  1.10.3    headers https://wappalyzer.com/ <chr [1]>             Nginx.svg <chr [1]>    <chr [1]>
    ## 4          Swiftlet    <NA>    headers https://wappalyzer.com/ <chr [1]>          Swiftlet.png <chr [1]>    <chr [1]>
    ## 5            Ubuntu    <NA>    headers https://wappalyzer.com/ <chr [1]>            Ubuntu.png <chr [1]>    <chr [1]>
