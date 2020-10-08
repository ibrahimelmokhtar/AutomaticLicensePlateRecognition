function img_blackAndWhite = Threshold(img_gray)
%Threshold converts a gray-scale image into a binary image
%   input:  a gray-scale image
%   output: a black-and-white image (binary image)

% find the maximum value ...
 max_level = max(img_gray);
 [row, col] = size(max_level);
 maxValue = max_level(1,1);
 for m = 1 : row
     for n = 1 : col
         maximum = max_level(m, n);
         if maximum > maxValue
             maxValue = maximum;
         end
     end
 end
 
 % find the minimum value ...
 min_level = min(img_gray);
 [row, col] = size(min_level);
 minValue = min_level(1,1);
 for m = 1 : row
     for n = 1 : col
         minimum = min_level(m, n);
         if minimum < minValue
             minValue = minimum;
         end
     end
 end
 
 % delete unnecessary variables
 clear max_level; clear min_level; clear maximum; clear minimum;
 
 % apply threshold ... (only black and white)
 threshold_value = ((maxValue + minValue)/2) - 1;
 [row, col] = size(img_gray);
 img_blackAndWhite = uint8(zeros(row, col));
 for m = 1 : row
     for n = 1 : col
         pixel = img_gray(m,n);
         if pixel <= threshold_value
             img_blackAndWhite(m,n) = 255; % it should be 0 ,but it's inverted
         else
             img_blackAndWhite(m,n) = 0; % it should be 255 ,but it's inverted
         end
     end
 end

end
