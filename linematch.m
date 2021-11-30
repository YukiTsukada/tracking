% matching on line along body axis 
% 
%
function [Y_OUT X_OUT] = linematch(IMM)
%  IMM = IM(:,:,1);
%figure;imagesc(IMM);
  level = graythresh(IMM);
  BW_FLIP = im2bw(IMM, level);

  % flip binary
  BW = (BW_FLIP - 1) .* -1;
%  BW(1:5,:) = 0;BW(:,1:5) = 0;
%  BW(end-5:end,:) = 0;BW(:,end-5:end) = 0;
  BW(1:10,:) = 0;BW(:,1:10) = 0;
  BW(end-10:end,:) = 0;BW(:,end-10:end) = 0;

  % making dilated images
%  SE1 = strel('disk', 3);
  SE1 = strel('disk', 5);
  DILATE = imdilate(BW, SE1);
  ERODE = imerode(DILATE, SE1);
  
  % use well skeltonize
  [SKR,rad] = skeleton(ERODE);
  SKEL = bwmorph(SKR > 5, 'skel', inf);
%   IME = double(IMM) + 100*double(SKEL);
%   figure;imagesc(IME);

  [Y X] = find(SKEL);
  XY = [X' ;Y'];
  [AXY flag] = alignment(XY);

%hold on;
%for j = 1:9
%  plot(AXY(1,3*j),AXY(2,3*j),'Marker','o','color',[j*0.1 j*0.1 j*0.1]);
%end
  
%  c = colormap;
%  figure;subplot(2,2,1);
  size_AXY = size(AXY);
  for i = 1:size_AXY(2)
    IN(i) = IMM(AXY(2,i),AXY(1,i));
%    colorsign = abs(round(62*i/size_AXY(2)))+1;
%    hold on;
%    plot(AXY(1,i),AXY(2,i),'Marker','*','color',c(colorsign,:));
  end
 [Con IDX] = max(medfilt1(IN,3));
 Y_OUT = AXY(2,IDX);
 X_OUT = AXY(1,IDX);

% plot(X_OUT,Y_OUT,'*r');
% figure;plot(IN); 

%subplot(2,2,2);plot(medfilt1(IN,3));
%subplot(2,2,3);imagesc(IM);hold on;plot(AXY(1,end),AXY(2,end),'wo');hold off;
%set(gca,'ydir','reverse');
%subplot(2,2,4);imagesc(IM);hold on;plot(X_OUT,Y_OUT,'w*');hold off;title('head');
