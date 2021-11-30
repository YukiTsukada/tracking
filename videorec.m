%Exposure time 40ms, EMgain 10
% high speed tracking with 4x objective

%function curve_track(Num)
Num = 20;
%% video initialize
vid = videoinput('winvideo',1);
vid.FramesPerTrigger = 30;
preview(vid);

% initialize Micro-Manager
import mmcorej.*
mmc = CMMCore;
mmc.loadSystemConfiguration('C:\Micro-Manager-1.3\Ludlshutter.cfg');

for j = 1:Num
  pause(1);
  IM = getsnapshot(vid);
  FILE = sprintf('%d.tif',j);
 imwrite(IM,FILE,'tif');
 i
end

%% close video
stoppreview(vid);
%stop(vid);
delete(vid);
clear vid;

delete(mmc);
