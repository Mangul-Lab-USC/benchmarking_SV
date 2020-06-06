# Benchmarking of WGS-based structural variant callers


This project contains the links to the datasets and the code that was used for our study : ["A benchmarking of WGS-based structural variant callers"](https://www.biorxiv.org/content/10.1101/2020.04.16.045120v1)

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

> Sarwal, Varuni, et al. "A comprehensive benchmarking of WGS-based structural variant callers" bioRxiv, doi: https://doi.org/10.1101/2020.04.16.045120


# Reproducing results

## Tools

We have evaluated 12 structural variant tools: Biograph, BreakDancer, CLEVER, DELLY, GASV, GRIDSS, indelMINER, MiStrVar, Pindel, PopDel, RDXplorer, LUMPY . Details about the tools and instructions for running can be found in our [paper](https://www.biorxiv.org/content/10.1101/2020.04.16.045120v1).

We have prepared ["wrappers"](https://github.com/Mangul-Lab-USC/benchmarking-sv-callers-paper/tree/master/Scripts/wrappers) in order to run each of the respective tools as well as create standardized log files.


## Data

The raw vcf's produced by the tools can be found here: https://github.com/Mangul-Lab-USC/benchmarking-sv-callers-paper/tree/master/Data/raw_data/mouse/raw_vcf
The custom vcf files, which are raw vcf's converted to the VCFv4.2 format can be found here: https://github.com/Mangul-Lab-USC/benchmarking-sv-callers-paper/tree/master/Data/raw_data/mouse
The fastq and bam files used will be available soon

## Scripts

The scripts to compare the deletions inferred by the SV-caller versus the true deletions is available here: https://github.com/Mangul-Lab-USC/benchmarking-sv-callers-paper/blob/master/Scripts/customvcf_mouse.py

## Notebooks and Figures

We have prepared Jupyter Notebooks that utilize the raw data described above to reproduce the results and figures presented in our [manuscript](https://www.biorxiv.org/content/10.1101/2020.04.16.045120v1).

* [Figure1 Jupyter Notebook](https://github.com/Mangul-Lab-USC/benchmarking-sv-callers-paper/blob/master/Notebooks/Figure1.ipynb)
* [Figure2 Jupyter Notebook](https://github.com/Mangul-Lab-USC/benchmarking-sv-callers-paper/blob/master/Notebooks/Figure2.ipynb)
* [Figure3 Jupyter Notebook](https://github.com/Mangul-Lab-USC/benchmarking-sv-callers-paper/blob/master/Notebooks/Figure3.ipynb)
* [Figure4 Jupyter Notebook](https://github.com/Mangul-Lab-USC/benchmarking-sv-callers-paper/blob/master/Notebooks/Figure4.ipynb)
* [Figure5 Jupyter Notebook](https://github.com/Mangul-Lab-USC/benchmarking-sv-callers-paper/blob/master/Notebooks/Figure5.ipynb)
* [Supplementary Figures Jupyter Notebook](https://github.com/Mangul-Lab-USC/benchmarking-sv-callers-paper/blob/master/Notebooks/Supplementary%20Figures%20Mouse.ipynb)

# License

This repository is under MIT license. For more information, please read our [LICENSE.md](LICENSE.md) file.


# Contact

Please do not hesitate to contact us (mangul@usc.edu) if you have any comments, suggestions, or clarification requests regarding the study or if you would like to contribute to this resource.


