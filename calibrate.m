%Calibrate Stage Position
%
function Coordi = calibrate();

% initialize Micro-Manager
import mmcorej.*
mmc = CMMCore;
mmc.loadSystemConfiguration('C:\Micro-Manager-1.3\Ludlshutter.cfg');

TrackX = mmc.getXPosition(mmc.getXYStageDevice());
TrackY = mmc.getYPosition(mmc.getXYStageDevice());
Coordi = [TrackY; TrackX];
Time = clock;
save('Right');

delete(mmc);
