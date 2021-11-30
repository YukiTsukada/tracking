%Exposure time 40ms, EMgain 10
% auto focus

function V = auto_focusing1(Num)
%     clear all;
%     Num = 20;
     W = 10;
     N = 1;

%% focus unit initialize
s = serial('COM2');
set(s,'BaudRate',19200,'Parity','even','terminator','CR/LF','StopBits',2);
fopen(s);
fprintf(s,'1LOG IN');

%% video initialize
vid = videoinput('winvideo',1);
vid.FramesPerTrigger = 30;
preview(vid);

% initialize Micro-Manager
import mmcorej.*
mmc = CMMCore;
mmc.loadSystemConfiguration('C:\Micro-Manager-1.3\Ludlshutter.cfg');

pause(1);
% initialize threshold value
%%IM = getsnapshot(vid);
%%IMM = IM(:,:,1);
%%figure;imagesc(IMM);colorbar;
%%f = fspecial('gaussian',2,3);
%%IMF = imfilter(IMM,f,'replicate');
%%prompt = {'Enter threshold value'};
%%dlg_title = 'Input for threshold';
%%num_lines = 1;
%%def = {'130'};
%%answer = inputdlg(prompt,dlg_title,num_lines,def);
%%th_value = str2num(answer{1});
%%thresh = th_value/255;
%%close;
%thresh = 130/255;

for j = 1:Num
  tic
    WW = W * N;
  pause(0.1);
  mmc.setShutterOpen(0);
  pause(0.1);
  mmc.setShutterOpen(1);

    INI = sprintf('1FCH N,%d',WW);
    fprintf(s,INI);
    pause(0.3);
      for i = 1:N*2
        IM = getsnapshot(vid);
        IMM = IM(:,:,1);
        f = fspecial('gaussian',2,3);
        IMF = imfilter(IMM,f,'replicate');
        %  BW = im2bw(IMF,thresh);
        %  V(i) = var(double(IMM(find(BW==0))));
        [RAW COL] = size(IMM);
        IMM2 = reshape(IMF,1,RAW*COL);
        V(i) = var(double(IMM2));
  %      i
        STEP = sprintf('1FCH F,%d',W);
        fprintf(s,STEP);
        pause(0.2);
      end
    
    [C I] = max(V)
    REV = W * ((N*2)-I)
    COM = sprintf('1FCL N,%d',REV);
    fprintf(s,COM);
    %fprintf(s,'1FCH N,%d',REV);
%  toc
%  plot(V);
  %out = fscanf(s);

%  pause(0.1);
%  mmc.setShutterOpen(0);
%  pause(0.1);
%  mmc.setShutterOpen(1);

  %% tracking 
  level = graythresh(IMM);
  BW = im2bw(IMM,level);
%figure;imagesc(BW(3:end,:))
  [Y X] = find(BW(3:end,:)==0);
  size_Y = size(Y);
%  mean_Y =  -((sum(Y)/size_Y(1))-60)*20 % 3.2x

     mean_Y =  -((sum(Y)/size_Y(1))-60)*15 % 4x
     mean_X =  ((sum(X)/size_Y(1))-80)*15 % 4x

  if((sum(Y)/size_Y(1))-60 > 40)
     mean_Y =  -((sum(Y)/size_Y(1))-60)*30; % 4x
  end
  if((sum(X)/size_Y(1))-80 > 40)
     mean_X =  ((sum(X)/size_Y(1))-80)*30 % 4x
  end
%  else
%     mean_Y =  -((sum(Y)/size_Y(1))-60)*15 % 4x
%     %  mean_X =  ((sum(X)/size_Y(1))-80)*20 % 3.2x
%     mean_X =  ((sum(X)/size_Y(1))-80)*15 % 4x
%   end
     mmc.setRelativeXYPosition(mmc.getXYStageDevice(),mean_X,mean_Y);  
toc
end

%% close focus unit
pause(1);
fprintf(s,'1LOG OUT');
fclose(s);
delete(s);
clear s;

%% close video
stoppreview(vid);
%stop(vid);
delete(vid);
clear vid;

delete(mmc);
