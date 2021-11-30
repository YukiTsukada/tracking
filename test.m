tic;
level = graythresh(IM);
BW = im2bw(IM,level);
BWL = bwlabel(BW);
[Y X] = find(BWL == 2);

figure;imshow(IM);hold on;plot(X,Y,'o');
toc