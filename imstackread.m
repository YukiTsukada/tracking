% MV = imstackread(FILE,N)
% FILE = JPG file name
% N = number of files

function MV = imstackread(FILE,N_Stat,N_end)

%  FILENAME = sprintf('%s%1.2d.JPG',FILE,1);
%  FILENAME = sprintf('%s%1.3d.JPG',FILE,1);  
  FILENAME = sprintf('%s%1.6d.JPG',FILE,1);
  IM = imread(FILENAME);
  MV(1).cdata = IM(:,:,2);
tic;

for i = N_Stat:N_end
%  FILENAME = sprintf('%s%1.2d.JPG',FILE,i);
%  FILENAME = sprintf('%s%1.3d.JPG',FILE,i);  

% skipping read 
 ii = i * 3;

  FILENAME = sprintf('%s%1.6d.JPG',FILE,ii);  
  IM = imread(FILENAME);
%  cdata = IM(:,:,1);         %% -+
  MV(i).cdata = IM(:,:,2);     %% -+
%figure;imshow(cdata)  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%--+  
%%%  unsharp filter before binarizing
%  PSF = ones(5,5)/25;
%  FILT_IM = imfilter(cdata,PSF);
%  %  cdata = cdata + 0.6 .* FILT_IM;
%  cdata = cdata + 0.3 .* FILT_IM;
%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%--+  
  % making binary images
%  level = graythresh(cdata);         %% -+
%  BW_FLIP = im2bw(cdata, level);     %% -+

%  figure;imshow(BW_FLIP);
%  level = graythresh(MV(i).cdata);        %% -+
  level = graythresh(MV(i).cdata)-0.02;        %% -+  
  BW_FLIP = im2bw(MV(i).cdata, level);    %% -+

  [g LABEL_num] = bwlabel(BW_FLIP(80:end-80,80:end-80));
  MV(i).LABEL = LABEL_num;

  % flip binary
  BW = (BW_FLIP - 1) .* -1;

  figure;imagesc(BW);
  % making dilated images
  SE1 = strel('disk', 5);
  DILATE = imdilate(BW, SE1);  
  ERODE = imerode(DILATE, SE1);    

  % use well skeltonize
  [SKR,rad] = skeleton(ERODE);
  SKEL = bwmorph(SKR > 35, 'skel', inf);

  % closing and get XY positions for the other script
  SE2 = strel('diamond', 15);
  CLOSE = imclose(SKEL, SE2);    

  % reskeltonize
  [SKR2,rad2] = skeleton(CLOSE);
  SKEL2 = bwmorph(SKR2 > 35, 'skel', inf);
  % figure;imshow(SKEL2);
  % extract side outliers (noize)
  [MV(i).Y MV(i).X] = find(SKEL2);
  MV(i).XX = MV(i).X(find(MV(i).X>10 & MV(i).X<500));
  MV(i).YY = MV(i).Y(find(MV(i).X>10 & MV(i).X<500));
  MV(i).XY = [MV(i).XX'; MV(i).YY'];
  [Y_size X_size] = size(MV(i).cdata);    %% -+
%  [Y_size X_size] = size(cdata);           %% -+

  % alighnment
  [MV(i).XY FLAG]= alignment(MV(i).XY,i);

  % detect edge points
%  [dmap,MV(i).exy,jxy] = anaskel(SKEL2);
%  MV(i).exy = detect_edge(ERODE);
  MV(i).EDGE = flipud(detect_edge(ERODE,i));

end
t = toc