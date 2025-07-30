clear,clc
gcp
tic

javaaddpath '####\Matlab\java\mij.jar'  % You can put the files in the "java" folder we provided into the Matlab\java directory.
javaaddpath '####\Matlab\java\ij.jar'

addpath("####\SRB+SPOT3.2");
imgName = "####\SRB+SPOT3.2\DL Synapsed homologs of meiotic mouse chromosomes ROI-1.tif";

amp =2;             % Pixel magnification factor.
psf = 3.9;          % Point Spread Function'Width at half maximum(/pixel)
dimz =1;            % The number of slices along the z-axis of the image
pixel=24;           % The size of the segmentation block should be adjusted in multiples of 4.
def =1.1;           % The value greater than 1. The closer it is to 1, the better the image quality. 
BRI= 7;             % The greater background noise, the larger the number.
bac2 = 0;           % Directly subtract this intensity value from the image.
slice = 1;          % This function is not enabled. Please keep it at 1.

% It is not recommended to set the amp×pixel parameter greater than 120.

imgResult = QOPSR(imgName,amp,psf,dimz,pixel,def,BRI,bac2,slice);


if size(imgResult, 3) ~= 1
filename_stark = sprintf('IMG_stark_amp%d_psf%.2f_dimz%d_pixel%d_def%.4f_BRI%d_bac%d_slice%d.tif',amp, psf, dimz, pixel, def,BRI, bac2,slice);
for k = 1:size(imgResult, 3)
    IMG = imgResult(:, :, k); 
    IMG = uint16(65535 * mat2gray(IMG));
    if k == 1    
        imwrite(IMG, filename_stark, 'tif', 'WriteMode', 'overwrite');
    else
        imwrite(IMG, filename_stark, 'tif', 'WriteMode', 'append');
    end
end

end

IMEAND = mean(imgResult, 3);
IMG_mean = uint16(65535 * mat2gray(IMEAND));
filename_mean = sprintf('IMG_mean_amp%d_psf%.2f_dimz%d_pixel%d_def%.4f_BRI%d_bac%d_slice%d.tif',amp, psf, dimz, pixel, def,BRI, bac2,slice);
imwrite(IMG_mean, filename_mean);

rawImage = imread(imgName);
figure;
subplot(1,2,1);
imshow(rawImage, []);
title('Raw Image');
subplot(1,2,2);
imshow(IMEAND, []);
title('SPOT Processed Image');



if size(imgResult, 3) ~= 1 
IVARD= var(imgResult, 0 ,3);
IMG_var = uint16(65535 * mat2gray(IVARD));
filename_var = sprintf('IMG_var_amp%d_psf%.2f_dimz%d_pixel%d_def%.4f_BRI%d_bac%d_slice%d.tif',amp, psf, dimz, pixel, def,BRI, bac2,slice);
imwrite(IMG_var, filename_var);
figure; imshow(IVARD, []);
end


time = toc

