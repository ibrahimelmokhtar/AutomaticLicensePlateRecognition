% NOTE:
%   images MUST be in .jpg format

close all; clear; clc;

% get all images from a specific directory using regex:
images = dir('images\*.jpg');

for index = 1:length(images)
    % close ALL opened figures, if any exists:
    close all;
    
    % get an image name:
    img_name = images(index).name;
    original_name = strcat('images\', img_name);
    
    % read a specific image:
    img_original = imread(original_name);

    % change original image into gray image:
    img_grayScale = rgb2gray(img_original);
    
    % apply threshold to get a binary image:
    img_BlackAndWhite = Threshold(img_grayScale);
    
    % remove small connected components from binary image: 
    img_WithoutNoise = bwareaopen(img_BlackAndWhite, 450);
    
    % apply O.C.R. on the filtered image:
    ocrResults = ocr(img_WithoutNoise);
    
    % get O.C.R features:
    recognizedText = ocrResults.Text;
    features = ocrResults.CharacterBoundingBoxes;
    row = max(size(recognizedText));
    
    % set ocr_image as fitered image:
    image_ocr = img_WithoutNoise;
    
    % display step-by-step results:
        % for binary image:
    fig_binary = figure;
    imshow(img_BlackAndWhite); title('Black/White Image');
        % for filter image:
    fig_filter = figure;
    imshow(img_WithoutNoise); title('No Noise Image');
        % for ocr image:    
    fig_ocr = figure;
    imshow(image_ocr); title('Final Image');
    
    % draw rectangles around detected characters:
    i = 1;
    for m = 1 : row
        if recognizedText(i) ~= ' '
            pos = features(m, :);
            rectangle(  'Position',pos, ...
                        'EdgeColor','r', ...
                        'LineWidth', 2.0);
        end
        i = i + 1;
    end
    
    % create results folder with sub-folders for each image:
    folder_name = strcat('results\plate_', num2str(index), '\');
    mkdir(folder_name);
    
    % save results:
    saveas(fig_binary, strcat(folder_name, 'binary_', img_name));
    saveas(fig_filter, strcat(folder_name, 'filter_', img_name));
    saveas(fig_ocr, strcat(folder_name, 'ocr_', img_name));
end

% close any opened figures:
close all;
