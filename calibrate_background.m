% 
% 

function calibrate_background()
%% video initialize
vid = videoinput('winvideo',1);
vid.FramesPerTrigger = 30;
preview(vid);

% initialize Micro-Manager
import mmcorej.*
mmc = CMMCore;
mmc.loadSystemConfiguration('C:\Micro-Manager-1.3\Ludlshutter.cfg');
pause(1);

%INI = getsnapshot(vid);


for i = 1:11
  for j = 1:10
    pause(0.8);
    mmc.setShutterOpen(0);
    pause(0.02);
    mmc.setShutterOpen(1);
    pause(0.8);
    mmc.setRelativeXYPosition(mmc.getXYStageDevice(),100,0);  
    j
  end
  MX = -100 * 10;
  mmc.setRelativeXYPosition(mmc.getXYStageDevice(),MX,100);  
  pause(1);
  i
end  
  
%% close video
stoppreview(vid);
%stop(vid);
delete(vid); clear vid; 
delete(mmc);
