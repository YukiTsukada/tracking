% morpho(FILENAME)
%
%function [P_Y P_X] =morpho(FILENAME)
function [P_Y P_X] =morpho(IM)
tic;
%  IM = imread(FILENAME);
  IMM = IM(:,:,1);

  level = graythresh(IMM);
  BW_FLIP = im2bw(IMM, level);

  % flip binary
  BW = (BW_FLIP - 1) .* -1;
  BW(1:10,:) = 0;BW(:,1:10) = 0;
  BW(end-10:end,:) = 0;BW(:,end-10:end) = 0;
% figure;subplot(2,1,1); imagesc(BW);
% making dilated images
  SE1 = strel('disk', 5);
  DILATE = imdilate(BW, SE1);
  ERODE = imerode(DILATE, SE1);

  % use well skeltonize
  [SKR,rad] = skeleton(ERODE);
  SKEL = bwmorph(SKR > 35, 'skel', inf);

  [YSK XSK] = find(SKEL);
  size_YSK = size(YSK);

  YC = ones(size_YSK(1),3);
  XC = ones(size_YSK(1),3);  
  YC(:,1) = YSK-1; YC(:,2) = YSK; YC(:,3) = YSK+1;
  XC(:,1) = XSK-1; XC(:,2) = XSK; XC(:,3) = XSK+1;
  
  EDGE_P = ones(1,1);
  for i = 1:size_YSK
    SUM_LINE(i) = sum(sum(SKEL(YC(i,:),XC(i,:))));
    if(SUM_LINE(i) == 2)
      EDGE_P = [EDGE_P i];
    end
  end
  EDGE_P(1) =[];
  size_EDGE_P =size(EDGE_P);

  SE2 = strel('diamond', 5);
  CLOSE = imclose(SKEL, SE2);
  TEST = SKEL + BW;
%  figure;imagesc(TEST);

  for j = 1:size_EDGE_P(2)
%    XSK(EDGE_P(j))
%    hold on; plot(XSK(EDGE_P(j)),YSK(EDGE_P(j)),'or');
     XEDGE(j) = XSK(EDGE_P(j));
     YEDGE(j) = YSK(EDGE_P(j));
  end
  [CH_Y IDX_Y] = min(abs(YEDGE-60));
  [CH_X IDX_X] = min(abs(XEDGE-80));

  P_Y = YEDGE(IDX_Y); P_X = XEDGE(IDX_X);
  
t = toc;
