% head detection by morphological operation
%

function [YY XX] = head(IM)
  level = graythresh(IM);
  BW_FLIP = im2bw(IM, level);

  % flip binary
  BW = (BW_FLIP - 1) .* -1 ;
  BW(1:10,:) = 0;  BW(end-10:end,:) = 0;
  BW(:,1:10) = 0;  BW(:,end-10:end) = 0;

  % making dilated images
  SE1 = strel('disk', 5);
  DILATE = imdilate(BW, SE1);
%  figure;imagesc(DILATE);
  ERODE = imerode(DILATE, SE1);
%  figure;imagesc(ERODE);
  OPE = imopen(BW,SE1);
%  figure;imagesc(OPE);
  TIP = ERODE - BW;
%  figure;imagesc(IM);
%  figure;imagesc(TIP);  
  [Y X] = find(TIP);
  sizeY = size(Y);
  
  sumY = sum(Y);
  sumX = sum(X);

  YY = sumY/sizeY(1);
  XX = sumX/sizeY(1);
  
%  hold on;plot(XX,YY,'wo');
  
