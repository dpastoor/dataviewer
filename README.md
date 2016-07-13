README
=========

The app does not need to be installed as I have not created it as a package (yet). To install, either download this repo, or clone it through git with `git clone https://github.com/dpastoor/dataviewer.git`

The dependencies can be checked by running the code in the `dependencies.R` file. They are

* shiny
* shinydashboard
* DT

and can be installed from CRAN.

The app can be run by opening an R/Rstudio session at the dataviewer directory and running `shiny::runApp()` to launch it.

To best leverage the dataviewer app, use the `view_creator` function in PKPDmisc to create a way of passing data to the app.

```
view2 <- PKPDmisc::view_creator("<path/to/dataviewer>")

## for example
view2 <- PKPDmisc::view_creator("~/Repos/dataviewer")
```

To then save data it is as simple as calling `view2`, and the resulting rds file
created in the dataviewer folder will take the name of the data.

```
view2(Theoph)
```

You can use `view2` in your data pipelines. However, because the data is 
represented as a `.` in the pipeline, it should be given a name. Luckily, the view_creator
also creates a parameter `name` that allows the name of the resulting rds file
to be customized.


```
library(dplyr)
Theoph %>% summarize(cmax = max(conc)) %>% view2(name = "Theoph")
```

it can also be used multiple times, as it will return the data that is piped in and
pass it along the pipeline by default, so can see what intermediate outputs are


```
Theoph %>% mutate(ID = as.numeric(Subject)) %>% view2("step1") %>%
    mutate(ID2 = as.numeric(as.character(Subject))) %>% view2("step2")
```


![](assets/example1.png)
