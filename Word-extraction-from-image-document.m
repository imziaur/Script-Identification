%%%%%%%%%%%%%%%%%%% String Segmentation for Numeral String Segmentation %%%%%%%%%%%%%%%%%%%%
img = rgb2gray(imread('H:\THESIS\Programs\mat\test\fullfile\oriya\or_07.jpg'));
bw_normal2 = im2bw(img, graythresh(img));
bw22 = imcomplement(bw_normal2);
%figure, imshow(bw22);
%se = strel('line', 50, 30); %//will work good for digit segmentation
se = strel('line', 8, 4);
bw3 = imdilate(bw22, se);
imshow(bw3);
[label2,n2] = bwlabel(bw3);  %// for word level
%[label2,n2] = bwlabel(bw_normal2);  %// for word block extraction
%[label2,n2] = bwlabel(bw22);    %// for character level

stats = regionprops(label2, {'Area', 'BoundingBox','EulerNumber','Orientation','Extent','Perimeter','Centroid','Extrema','PixelIdxList','ConvexArea','FilledArea','PixelList','ConvexHull','FilledImage','Solidity','ConvexImage','Image','SubarrayIdx','Eccentricity','MajorAxisLength','EquivDiameter','MinorAxisLength'});

A = stats(1)

%%%%%%%%%%%%%%%%%% Bounding Box Creation %%%%%%%%%%%%%%%%%%%%%%%%%
%imshow(img);
%for j=1:n2
%   hold on
% rectangle('Position',[stats(j).BoundingBox(1),stats(j).BoundingBox(2),stats(j).BoundingBox(3),stats(j).BoundingBox(4)],'EdgeColor','r');
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%% Saving all files in seperate folder %%%%%%%%%%%%%%%%%%
MinArea = 500; %// Select largest area you want to keep.
MaxArea = 50000;
stats = stats([stats.Area] > MinArea); %// Detect cells larger than some value.
stats = stats([stats.Area] < MaxArea);
L = length(stats);
figure

    %hold all %// Use if you use the subplot command
    
for k = 1:L   %// group processing
    %string=imcrop(bw_normal2,[stats(k).BoundingBox]); %// extraction in binary format
   string=imcrop(img,[stats(k).BoundingBox]); %// extraction in gray format
   % [st_x st_y] = size(string);
   % th=10;
   % string1 = imcrop(string, [th,th,st_y - (th+10), st_x - (th+4)]); 
  %  string2 = imresize(string1, [140 340], 'bicubic');
    
    %%%%%%%%%%%%%%%%%labeling each individual string2 %%%%%%%%%%%%%%%%%
    %bw_normal22 = im2bw(string2, graythresh(string2));
    %bw222 = imcomplement(bw_normal22);
    %se = strel('line', 40, 20);
    %string3 = imdilate(bw222, se);
    %[label3,n3] = bwlabel(string3);
    %stats1 = regionprops(label3, {'Area', 'BoundingBox'});
    %string4=imcrop(string2,[stats1(1).BoundingBox]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    imshow(string);
    pause(0.01);
    
    % Construct filename for this particular image.
    baseFileName = sprintf('or_p_%.4d.jpg', k+5066);
    % Specify yourFolder in advance.
    % Prepend the folder to make the full file name.
    %fullFileName = fullfile('E:/work/Code/MATLAB/Data/Temp', baseFileName);
    fullFileName = fullfile('data', baseFileName);
    %fullFileName = fullfile('E:/work/Code/MATLAB/Data/Temp', baseFileName);
    % Do the write to disk.
    imwrite(string, fullFileName);

end
diary
diary('reslt.txt')
diary off
diary on
diary reslt.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
