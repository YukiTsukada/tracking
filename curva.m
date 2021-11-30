%
%

function [tY tX] = curva(IM)
Num = 4;
[Y X] = size(IM);

level = graythresh(IM);
BW = im2bw(IM,level);

BW = bwmorph(BW,'erode',2);
BW = bwmorph(BW,'dilate',2);
EDGE = edge(BW);

EDGE(1:5,:) = 0;EDGE(:,1:5) = 0;
EDGE(end-5:end,:) = 0; EDGE(:,end-5:end) = 0;
[PY PX] = find(EDGE);
size_PY = size(PY);
PPY = PY; PPX = PX;

%% find edge start point
[YD INDX_Y] = max(PPY);
[XD INDX_X] = max(PPX);
[YDm INDX_Ym] = min(PPY);
[XDm INDX_Xm] = min(PPX);
Comp = [ Y-YD X-XD YDm XDm;
        INDX_Y INDX_X INDX_Ym INDX_Xm];
[D IIND] = min(Comp(1,:));
INDX = Comp(2,IIND);
%INDX = 1;

for i = 1:size_PY(1)-1;
  YP = repmat(PY(INDX),size_PY(1),1);
  XP = repmat(PX(INDX),size_PY(1),1);
  PPY(INDX) = 30000; PPY(INDX) = 30000;
  [D INDX] = min((PPY - YP).^2 + (PPX - XP).^2);
  Sorted(i) = INDX;
end

%figure;imagesc(IM);hold on;
%for i = 1:size_PY(1)-1;
%  colorsign = abs(round((62/size_PY(1))*i))+1; 
%  c = colormap;
%%  plot(PX(i),PY(i),'Marker','o','color',c(colorsign,:));
%  plot(PX(Sorted(i)),PY(Sorted(i)),'Marker','o','color', ...
%       c(colorsign,:));
%  pause(0.1);
%end
%Sorted

SortedY = PY(Sorted);
SortedX = PX(Sorted);

CU = curvature_numeric([SortedY(1:Num:end) SortedX(1:Num:end)],2);
[C IND] = max(abs(CU));

%%%% for avoiding tail ---------------------
%if (C > 0.5)
%  CU(IND) = 0;
%  [C IND] = max(abs(CU));
%end
%%%% for avoiding tail ---------------------

%figure;imagesc(IM);hold on;
%plot(SortedX(IND*Num),SortedY(IND*Num),'ow');
%figure; imagesc(EDGE);
%figure; plot(abs(CU));

tX = SortedX(IND*Num);
tY = SortedY(IND*Num);