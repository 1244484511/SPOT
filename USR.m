clear all
imgName = "C:\Users\12444\Desktop\SRB+SPOT3.2\Stack-1067-4-l.tif";

sz=5;          % Uniform window size
dimz = 4;      % The number of slices along the z-axis of the image
n=50;          % Number of generated images

for d = 1:dimz
    img(:,:,d) = double(imread(imgName,d));
end

dimx = size(img, 1);
dimy = size(img, 2);
dimz = size(img, 3);


[height, width, dimz] = size(img);
output_img = img;

for i = 1:sz:height
    for j = 1:sz:width
        rowEnd = min(i + sz - 1, height);
        colEnd = min(j + sz - 1, width);
        window_stack = img(i:rowEnd, j:colEnd, :);
        mean_window_intensity = mean(window_stack, 'all');
        for k = 1:dimz
            current_window_intensity = mean(window_stack(:, :, k), 'all');
            if current_window_intensity ~= 0
                scale_factor = mean_window_intensity / current_window_intensity;
                output_img(i:rowEnd, j:colEnd, k) = ...
                    output_img(i:rowEnd, j:colEnd, k) * scale_factor;
            end
        end
    end
end






for k = 1:size(output_img, 3)
    IMG = output_img(:, :, k);
    IMG = uint16(IMG);

    if k == 1

        imwrite(IMG, 'output_img.tif', 'tif', 'WriteMode', 'overwrite');
    else

        imwrite(IMG, 'output_img.tif', 'tif', 'WriteMode', 'append');
    end
end


reconstructed_imgs = zeros(dimx, dimy, n);


for i = 1:n

    for x = 1:dimx
        for y = 1:dimy

            random_z = randi(dimz);

            reconstructed_imgs(x, y, i) = output_img(x, y, random_z);
        end
    end
end

for k = 1:size(reconstructed_imgs, 3)

    IMG = reconstructed_imgs(:, :, k);

    IMG = uint16(65535 * mat2gray(IMG));


    if k == 1

        imwrite(IMG, 'reconstructed_imgs.tif', 'tif', 'WriteMode', 'overwrite');
    else

        imwrite(IMG, 'reconstructed_imgs.tif', 'tif', 'WriteMode', 'append');
    end
end


