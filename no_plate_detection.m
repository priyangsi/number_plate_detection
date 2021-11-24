close all;
clear all;

load imgfiledata;

[file, path]=uigetfile({'*.jpg;*.jpeg;*.bmp;*.png;*.tif'},'Choose an image');
s = [path,file];
picture = imread(s);
[~,cc] = size(picture);
picture=imresize(picture, [300,500]);

if size(picture,3)==3
    picture=rgb2gray(picture);
end

imgray = graythresh(picture);
picture = ~imbinarize(picture, imgray);
picture = bwareaopen(picture, 30);%remove some object if its width is shorter than 30
imshow(picture)

if cc>2000
    im1 = bwareaopen(picture, 3500);
else
    im1 = bwareaopen(picture, 3000);
end
figure, imshow(im1)

im2 = picture-im1;
figure, imshow(im2)

im2 = bwareaopen(im2,200);
figure, imshow(im2)

[L, Ne]=bwlabel(im2);
Iprops = regionprops(L, 'BoundingBox');
hold on;
pause(1);

for n=1:size(Iprops,1)
    rectangle('Position', Iprops(n).BoundingBox, 'EdgeColor', 'r', 'LineWidth',1)
end
hold off;

figure
final_output = [];

for n=1:Ne
    [r,c] = find(L==n);
    n1 = picture(min(r):max(r), min(c):max(c));
    n1 = imresize(n1,[42,24]);
    imshow(n1)
    pause(0.2)
    x = [];
    
    totalLetters = size(imgfile,2);
    
    for k=1:totalLetters
        y=corr2(imgfile{1,k}, n1);
        x=[x y];
    end
    
    if max(x)>0.46
        z=find(x==max(x));
        out = cell2mat(imgfile(2,z));
        
        final_output = [final_output out];
    end
end

file = fopen('number_plate.txt', 'wt');
fprintf(file,'%s\n', final_output);
