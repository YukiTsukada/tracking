% Tracking 
% Coordi = curve_track(Num)

function Coordi = curve_track_image(Num)
%Num = 20;
%% video initialize
vid = videoinput('winvideo',1);
vid.FramesPerTrigger = 30;
preview(vid);

% initialize Micro-Manager
import mmcorej.*
mmc = CMMCore;
mmc.loadSystemConfiguration('C:\Program Files\Micro-Manager-1.3\drivers\MMConfig_ham_Ludl.cfg');

%downX = 1:2:160;
%downY = 1:2:120;

pause(1);
INI = getsnapshot(vid);
%[BW xpoint ypoint] = roipoly(INI);%%%%%
%Temp = INI(ypoint(1)-12:ypoint(1)+12, xpoint(1)-12:xpoint(1)+12, 1); 
%Temp = INI(ypoint(1)-8:ypoint(1)+8, xpoint(1)-8:xpoint(1)+8, 1); % 2x2%%%%%
%figure; imagesc(Temp)  %%%%%

for j = 1:Num
  tic;
  IM = getsnapshot(vid);
%  IMM = IM(downY,downX,1);
  IMM = IM(:,:,1);
%IMM = medfilt1(IMM,5);
%  IMM = IM(:,:,1)+IM(:,:,2)+IM(:,:,3);

%% find position of high curvature
%  [Y X] = headdetect2x32(IM,5,5);
%  [Y X] = ent(IMM,5);  
%  [Y X] = head(IMM);  
%  [Y X] = histmatch(IMM,1,Temp);  
%  [Y X] = morpho(IMM);  
%  [Y X] = linematch(IMM);  

%% down the resolution 
IMN = IMM(1:2:120,1:2:160);
[Y X] = curva(IMN);
Y = 2*Y;X = 2*X;

%% move stage
%  MX = (X -80)*4; % Mag 2 x 3.2
  MX = (X -80)*5; % Mag 2 x 2.5
%  MX = (abs(P_X-80).^0.5.*(P_X-80)./4)*5;  
%  MX = (abs(X-80).^0.5.*(X-80)./4)*5; %for 2x2
%  MX = (abs(X-80).^0.6.*(X-80)./4)*3; %for 2x2.5
%  MX = (abs(X-80).^0.3.*(X-80)./2.1)*3.5; %for 2x3.2
%  MX = 4* 80 * sign(X-80)*(1./(1+exp(-0.05 * abs(X-80)))); 

%  MY = -(Y -60)*4; % Mag 2 x 3.2
  MY = -(Y -60)*5; % Mag 2 x 2.5
%  MY = - (abs(P_Y-60).^0.5.*(P_Y-60)./4)*5;
%  MY = - (abs(Y-60).^0.5.*(Y-60)./4)*5; % for 2x2
%  MY = - (abs(Y-60).^0.6.*(Y-60)./4)*3; % for 2x2.5
%  MY = - (abs(Y-60).^0.3.*(Y-60)./2.1)*3.5; % for 2x3.2
%  MY = - 4* 60 * sign(Y-60)*(1./(1+exp(-0.05*abs(Y-60)))); 

  mmc.setRelativeXYPosition(mmc.getXYStageDevice(),MX,MY);  
  pause(0.15);

%% send shutter signal
%  pause(0.2);
%  pause(0.1);
  mmc.setShutterOpen(0);
  pause(0.01);
  mmc.setShutterOpen(1);
  TrackY(j) = mmc.getYPosition(mmc.getXYStageDevice());
  TrackX(j) = mmc.getXPosition(mmc.getXYStageDevice());
  TrackTime = clock;
  CoordiT(1:3,j) = TrackTime(4:end)';
%  Temp = IMM(Y-8:Y+8,X-8:X+8);
%  figure;imagesc(Temp); %%%%%
  Coordi = [TrackY; TrackX];
  csvwrite('Coordinates',Coordi);
  csvwrite('CoordiTime',CoordiT);
  toc
  i
  pause;
end

%% close video
stoppreview(vid);
%stop(vid);
delete(vid); clear vid; 
delete(mmc);
