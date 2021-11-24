clc; clear; close all;

di = dir('alpha');
st = {di.name};
nam = st(3:end);
imgfile=cell(2, length(nam));
for i=1:length(nam)
    imgfile(1,i)={imread(['alpha\',cell2mat(nam(i))])};%images of the letters are saved in the 1st row
    temp = cell2mat(nam(i));
    imgfile(2,i)={temp(1)};%letters are saved in the 2nd row
end
save('imgfiledata.mat','imgfile');
clear;