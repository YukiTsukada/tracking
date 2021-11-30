%
% auto focus

%function V = auto_focusing()
     clear all;
     W = 100;
     N = 3;

%% focus unit initialize
s = serial('COM2');
set(s,'BaudRate',19200,'Parity','even','terminator','CR/LF','StopBits',2);
fopen(s);
fprintf(s,'1LOG IN');

%% video initialize
vid = videoinput('winvideo',1);
vid.FramesPerTrigger = 30;
preview(vid);
%start(vid);
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
tic
WW = W*N;
INI = sprintf('1FCH N,%d',WW);
fprintf(s,INI);
pause(0.5);
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
  i
  STEP = sprintf('1FCH F,%d',W);
  fprintf(s,STEP);
  pause(0.2);
end

[C I] = max(V)
REV = W * ((N*2)-I)
     COM = sprintf('1FCL N,%d',REV);
     fprintf(s,COM);
%fprintf(s,'1FCH N,%d',REV);
toc
plot(V);
%out = fscanf(s);

%% close focus unit
pause(1);
fprintf(s,'1LOG OUT');
fclose(s)
delete(s)
clear s

%% close video
stoppreview(vid);
%stop(vid);
delete(vid);
clear vid;
