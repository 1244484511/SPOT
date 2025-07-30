###This repository provides code accompanying the paper:
Super-Resolution Imaging via Sparse Point Optimization.
The code implements a single-frame super-resolution algorithm for fluorescence microscopy.

###Citation
Please cite the following paper when using this code:
(To be filled)

###Requirements
MATLAB toolboxes: (To be filled)

###External software: FIJI (required)
You can find installation instructions and MIJ support here:
https://www.mathworks.cn/matlabcentral/fileexchange/47545-mij-running-imagej-and-fiji-within-matlab

or
You can put the files in the "java" folder we provided into the "Matlab\java" directory.

###How to Run
Open main.m in MATLAB.
% Replace "#" with your custom directory path
addpath("#/SRB+SPOT3.2");
imgName = "#/SRB+SPOT3.2/DL Synapsed homologs of meiotic mouse chromosomes ROI-2.tif";
Adjust parameters and directory paths as needed.
Click Run to execute.
For USR.m, follow the same procedure.
imgName = "#\Stack-1067-4-l.tif";

###Example Data
Synapsed homologs of meiotic mouse chromosomes
From: Extending resolution within a single imaging frame
DOI: https://doi.org/10.1038/s41467-022-34693-9

WienerSIM488_2D_NA1.7-COS7_MitoTrakerGreen
From: Sparse deconvolution improves the resolution of live-cell super-resolution fluorescence microscopy
DOI: https://doi.org/10.1038/s41587-021-01092-2

###License
This code is provided for academic use only.