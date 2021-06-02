# Demographics and reproductive biology of *Hydrophis schistosus* may make it more resilient to bycatch effects than other sea snakes.

**Authors:** Shawn Dsouza and Chetan Rao

Dakshin Foundation and Center for Ecological Science, IISc, Bangalore

This repo contains the R code for analysis and data  for a study on the diet and habitat use of sea snakes on the west coast of India.

## Working abstract

Mortality in fisheries bycatch is a threat to marine taxa globally. True sea snakes are viviparous marine reptiles found throughout tropical coastal waters, with varying reproductive strategies that differ from their terrestrial counterparts. *Hydrophis schistosus* and *H. curtus* are both caught frequently in large numbers as bycatch in gillnets, shore seines and trawlers on the west coast of India. In this study, we aimed to describe the population of *H. curtus* and *H. schistosus* in bycatch in terms of developmental stages; compare mortality rates across developmental stages and sexes; and discuss their breeding cycle and reproductive strategies in the context of fisheries threats. We sampled fishing nets for sea snakes from 2016 to 2019. The population structure of *H. schistosus* consisted primarily of breeding adults and did not change in the four years of sampling. However, the proportion of breeding adults of *H. curtus* in bycatch declined steadily. Gravid female *H. schistosus* appear to carry young from November to May, giving birth in April. We did not encounter any gravid *H. curtus* during our sampling. While the number of eggs increased with female age, the overall reproductive effort remained the same and investment per embryo reduced. Overall mortality of *H. curtus* was significantly higher than *H. schistosus*. In particular, adult *H. curtus* were most vulnerable to bycatch mortality of all demographic groups in both species. Reproductive strategies along with other ecological and life history differences may give *H. schistosus* an advantage compared to other taxa in the face of anthropogenic threats.

**Keywords:** Hydrophiinae, life history, population structure, fisheries, India

## Usage

<details>
  <summary> View results </summary>
  
  The R markdown file is configured to out put an HTML document with the results of the analysis. Paste the following code in the terminal. With the working directory set to root of this reporsitory.
  
  
  ```R
  rmarkdown::render_site(input = "Reproductive Biology Manuscript.Rmd", encoding = "UTF")
  ```
  
  The analysis can also be viewed by opening the `Reproductive-Biology-Mnauscript.html` file in any browser.
  
  </details>
 
 <details>
  <summary>Go through analysis</summary>
  
   - The sections of the analysis have been split into seperate R markdown files and can be run independently. 
    
   - R markdown files are best viewed in the R studio IDE.
    
   - Some of the analysis refer to custom functions that are included in the `Functions` folder.
   
   - Before working with the file locally a portable local environment can be activated to make sure you have all the dependencies by running `renv::activate()` and `renv::restore()`. You will need to intall the `renv` package for this. For more information please refer to https://rstudio.github.io/renv/articles/renv.html.
   
   </details>
 
 ## Software Used
<details>
  <summary> R Session info </summary>
  
  ```R                      
 version  R version 4.1.0 (2021-05-18)
 os       Ubuntu 20.10              
 system   x86_64, mingw32             
 ui       RStudio                     
 language (EN)                        
 collate  English_India.1252          
 ctype    English_India.1252          
  ```

  </details>

 ## Liscence and Copyright
 
 © Shawn Dsouza, Dakshin Foundation
 
Licensed under [MIT Liscence](LISCENCE)