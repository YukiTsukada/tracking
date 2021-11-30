% Tracking for 2x 6.3
%

%function highmagtrack(N)
% initialize Micro-Manager
import mmcorej.*
mmc = CMMCore;
mmc.loadSystemConfiguration('C:\Micro-Manager-1.3\MMConfig_Ludl.cfg');

% initialize video
vid = videoinput('winvideo',1);
vid.FramesPerTrigger = 30;
start(vid);

%preview(vid);
%pause;

for i = 1:N
  flushdata(vid);

  % get image data
  IM = getdata(vid,1);
  % analyze image
  level = graythresh(IM(:,:,1));
  BW = im2bw(IM(:,:,1),level);
  BWL = bwlabel(BW);
figure;imagesc(BWL);
  [Y X] = find(BWL == 2);

% determine how long the stage moves
if(numel(X) ~=0)
  moveX = X(1) - 80;
else
 moveX = 0;
end
if(numel(Y) ~=0)
  moveY = 60 - Y(1);
else
 moveY = 0;
end

%  figure;imshow(BW); %hold on;
%  plot(X,Y,'o');hold off;

% move stage
  mmc.setRelativeXYPosition(mmc.getXYStageDevice(),moveX,moveY);
end

% stop video
stop(vid);
delete(vid);

% stop Micro-Manager 
delete(mmc);
