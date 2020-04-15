# Benchmarking of WGS-based structural variant callers


This project contains the links to the datasets and the code that was used for our study : ["A benchmarking of WGS-based structural variant callers"]()

**Table of contents**

* [How to cite this study](#how-to-cite-this-study)
* [Reproducing results](#reproducing-results)
  * [Tools](#tools)
  * [Data](#data)
  * [Scripts](#scripts)
  * [Notebooks and Figures](#notebooks-and-figures)
* [License](#license)
* [Contact](#contact)


# How to cite this study

> 


# Reproducing results

## Tools

We have evaluated 12 structural variant tools: Biograph, BreakDancer, CLEVER, DELLY, GASV, GRIDSS, indelMINER, MiStrVar, Pindel, PopDel, RDXplorer, LUMPY . Details about the tools and instructions for running can be found in our ["paper"]().

We have prepared ["wrappers"](https://github.com/Mangul-Lab-USC/benchmarking-sv-callers-paper/tree/master/Scripts/wrappers) in order to run each of the respective tools as well as create standardized log files.


## Data

The vcf files produced by the tools can be found ["here"] (https://github.com/Mangul-Lab-USC/benchmarking-sv-callers-paper/tree/master/Data/raw_data/mouse)
The bam files used in the analysis can be found on Google Drive

## Scripts

Scripts to convert custom formats of SV-detection tools to VCFv4.2 are available ["here"](benchmarking-sv-callers-paper/tree/master/Scripts/modification_scripts)
 
The scripts to compare the deletions inferred by the SV-caller versus the true deletions is available ["here"] (https://github.com/Mangul-Lab-USC/benchmarking-sv-callers-paper/blob/master/Scripts/customvcf_mouse.py)

## Notebooks and Figures

We have prepared Jupyter Notebooks that utilize the raw data described above to reproduce the results and figures presented in our [manuscript](). The notebooks can be found ["here"](https://github.com/Mangul-Lab-USC/benchmarking-sv-callers-paper/tree/master/Notebooks) and the figures can be found ["here"](https://github.com/Mangul-Lab-USC/benchmarking-sv-callers-paper/tree/master/Figures)


# License

This repository is under MIT license. For more information, please read our [LICENSE.md](./LICENSE.md) file.


# Contact

Please do not hesitate to contact us (mangul@usc.edu) if you have any comments, suggestions, or clarification requests regarding the study or if you would like to contribute to this resource.


