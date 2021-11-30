% 
% 
function Coordi = testrun()

%% video initialize for Image acquisition toolbox
vid = videoinput('winvideo',1);
vid.FramesPerTrigger = 30;
preview(vid);

% initialize Micro-Manager
import mmcorej.*
mmc = CMMCore;
mmc.loadSystemConfiguration('C:\Micro-Manager-1.3\Ludlshutter.cfg');
pause(1);

for j = 1:30
  tic;
  % take a image from video input
  IM = getsnapshot(vid);
  IMM = IM(:,:,1);

  % move stage
  MX = 10*j; 
  MY = 10*j;
  mmc.setRelativeXYPosition(mmc.getXYStageDevice(),MX,MY);  
  pause(0.3);

  % shutter control
  mmc.setShutterOpen(0);
  pause(0.01);
  mmc.setShutterOpen(1);

  % record current position as .csv file  
  TrackY(j) = mmc.getYPosition(mmc.getXYStageDevice());
  TrackX(j) = mmc.getXPosition(mmc.getXYStageDevice());
  Coordi = [TrackY; TrackX];
  csvwrite('Coordinates.csv',Coordi);
  toc
end

%% close video
stoppreview(vid);
%stop(vid);
delete(vid); clear vid; 
delete(mmc);
