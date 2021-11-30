%Exposure time 40ms, EMgain 10
% high speed tracking with 4x objective

function highspeedtrack(Num)

%% video initialize
vid = videoinput('winvideo',1);
vid.FramesPerTrigger = 30;
preview(vid);

% initialize Micro-Manager
import mmcorej.*
mmc = CMMCore;
mmc.loadSystemConfiguration('C:\Micro-Manager-1.3\Ludlshutter.cfg');

pause(1);

for j = 1:Num
  tic
  IM = getsnapshot(vid);
  IMM = IM(:,:,1);

  %% tracking 
  level = graythresh(IMM);
  BW = im2bw(IMM,level);
%figure;imagesc(BW(3:end,:))
  [Y X] = find(BW(3:end,:)==0);
  size_Y = size(Y);
     mean_Y =  -((sum(Y)/size_Y(1))-60)*8 % 4x
     mean_X =  ((sum(X)/size_Y(1))-80)*8 % 4x
  if(abs((sum(X)/size_Y(1))-80)>40)
     mean_X =  ((sum(X)/size_Y(1))-80)*10 % 4x
     end
%  else
%     mean_Y =  -((sum(Y)/size_Y(1))-60)*15 % 4x
%     %  mean_X =  ((sum(X)/size_Y(1))-80)*20 % 3.2x
%     mean_X =  ((sum(X)/size_Y(1))-80)*15 % 4x
%   end
  pause(0.19);
  mmc.setShutterOpen(0);
  pause(0.01);
  mmc.setShutterOpen(1);

  mmc.setRelativeXYPosition(mmc.getXYStageDevice(),mean_X,mean_Y);  
  pause(0.1);
  toc
end

%% close video
stoppreview(vid);
%stop(vid);
delete(vid);
clear vid;

delete(mmc);
