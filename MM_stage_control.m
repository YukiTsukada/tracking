import mmcorej.*;
mmc = CMMCore;
mmc.loadSystemConfiguration('C:\Micro-Manager-1.3\MMConfig_Ludl.cfg');
mmc.setRelativeXYPosition(mmc.getXYStageDevice(),1000,1000);
