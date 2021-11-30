% headdetect based on patch histgram
% IM:image, n:skip parameter, Temp: Template 
%
function [Y_OUT X_OUT] = histmatch(IM,n,Temp)
[Raw Col] = size(IM);
level = graythresh(IM(:,:,1));
BW = im2bw(IM(:,:,1),level);

SE = strel('disk',5);
OPEN = imopen(BW,SE);
EDGE = edge(OPEN);
%EDGE(1:40,:) = 0; EDGE(:,1:40) = 0;
%EDGE(end-40:end,:) = 0; EDGE(:,end-40:end) = 0;
EDGE(1:12,:) = 0; EDGE(:,1:12) = 0;
EDGE(end-12:end,:) = 0; EDGE(:,end-12:end) = 0;
[Y X] = find(EDGE);
size_Y = size(Y);

% Temp = IM(Y(91)-10:Y(91)+10, X(91)-10:X(91)+10, 1);%%%%% 4 test image 
[Temphist XX] = imhist(Temp);
%figure;imagesc(Temp);

% figure;subplot(1,2,1);imagesc(Temp);
% subplot(1,2,2);plot(Temphist);
for i = 1:n:size_Y(1)
  ROI = IM(Y(i)-8:Y(i)+8, X(i)-8:X(i)+8, 1);
%  ROI = IM(Y(i)-12:Y(i)+12, X(i)-12:X(i)+12, 1);
  [C(i).hist XX] = imhist(ROI);
  COEF(i).P = corrcoef(Temphist(1:end-2),C(i).hist(1:end-2));
  CO(i) = COEF(i).P(2);
%  figure;
%  subplot(2,2,1);imagesc(ROI);colormap(gray);title('patch');
%  subplot(2,2,3);plot(C(i).hist);axis([0 255 0 10]);title('histgram');
%  subplot(2,2,4);imagesc(IM);hold on;plot(X(i),Y(i),'wo');hold off;
%  title(i);
end

[C IDX] = max(CO);
Y_OUT = Y(IDX); X_OUT = X(IDX);
%figure; plot(CO);
