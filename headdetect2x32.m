% detect head (max curvature position)
% R = radius to define the curvature
function [Y_2nd X_2nd] = headdetect2x32(IM,R,n)
WIDTH = 5;
%n = 6;
IMM = IM(:,:,1);
level = graythresh(IMM);
BW = im2bw(IMM,level);

SE = strel('disk',5);
OPEN = imopen(BW,SE);
EDGE = edge(OPEN);

EDGE_IN = EDGE;
EDGE_IN(1:WIDTH,:) = 0;EDGE_IN(end-WIDTH:end,:) = 0;
EDGE_IN(:,1:WIDTH) = 0;EDGE_IN(:,end-WIDTH:end) = 0;
[Y_IN X_IN] = find(EDGE_IN==1);
size_IN = size(Y_IN);

%figure; 
imagesc(EDGE_IN);hold on;  %% check

  for i = 1:n:size_IN
    XX = repmat(X_IN(i),size_IN(1),1);
    YY = repmat(Y_IN(i),size_IN(1),1);

    % find equal distance points from the center
    IN_CIRCLE = find((X_IN - XX).^2 + (Y_IN -YY).^2 <= R^2 & (X_IN - XX).^2 + (Y_IN -YY).^2 >= (R-3)^2 );
   if (IN_CIRCLE == 0)
      IN_CIRCLE  = i;
     disp('kore');
   end

    % plot(X_IN(i),Y_IN(i),'*w'); % center check
    % plot(X(IN_CIRCLE),Y(IN_CIRCLE),'ow'); % edge of the circle 
    %  plot(X(IN_CIRCLE(1)),Y(IN_CIRCLE(1)),'*k');
    sizeIN_CIRCLE = size(IN_CIRCLE);

    ONE_SIDE_X = repmat(X_IN(IN_CIRCLE(1)), sizeIN_CIRCLE(1), 1);
    ONE_SIDE_Y = repmat(Y_IN(IN_CIRCLE(1)), sizeIN_CIRCLE(1), 1);
  
    OTHER_SIDE = find((X_IN(IN_CIRCLE) - ONE_SIDE_X).^2 + (Y_IN(IN_CIRCLE) ...
                     - ONE_SIDE_Y).^2  >= 2 );
   if (IN_CIRCLE == 0)
     OTHER_SIDE = i;
     disp('kore');
   end
    % plot(X(IN_CIRCLE(OTHER_SIDE)),Y(IN_CIRCLE(OTHER_SIDE)),'*b');hold off;
  
    Right_X = X_IN(IN_CIRCLE(1)); Right_Y = Y_IN(IN_CIRCLE(1));
    Left_X = X_IN(IN_CIRCLE(OTHER_SIDE(1))); Left_Y = Y_IN(IN_CIRCLE(OTHER_SIDE(1)));
    % plot(Right_X,Right_Y,'g*'); plot(Left_X,Left_Y,'b*');

    ab1 = polyfit([Right_X X_IN(i)],[Right_Y Y_IN(i)] , 1);
    ab2 = polyfit([Left_X X_IN(i)], [Left_Y Y_IN(i)], 1);

    % calculate degrees in relative coordinate
    if( (atan(ab2(1)) - atan(ab1(1))) *180/pi < -90)
      Dig(i) = 180 + (atan(ab2(1)) - atan(ab1(1)))*180/pi;
    elseif((atan(ab2(1)) - atan(ab1(1))) *180/pi > 90)
      Dig(i) =  -180 + (atan(ab2(1)) - atan(ab1(1)))*180/pi;
    else
      Dig(i) =  (atan(ab2(1)) - atan(ab1(1)))*180/pi;
    end
    colorsign = abs(round((62/90)*Dig(i)))+1; c = colormap;  % check
     plot(X_IN(i),Y_IN(i),'Marker','*','color',c(colorsign,:)); % center check
  end

[MaxD MaxD_IDX] = max(abs(Dig));

% plot(X_IN(MaxD_IDX),Y_IN(MaxD_IDX),'wo'); % check

X_Max = X_IN(MaxD_IDX);
Y_Max = Y_IN(MaxD_IDX);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   For the head detection
  Max_rep_X = repmat(X_Max,size_IN(1),1);
  Max_rep_Y = repmat(Y_Max,size_IN(1),1);

  Non_Tail_I = find((X_IN - Max_rep_X).^2 + (Y_IN -Max_rep_Y).^2 >= ...
                  (R+5)^2);

  AddDig = zeros(1,n);
  Dig = [Dig AddDig];

  [MxD MxD_I] = max(abs(Dig(Non_Tail_I)));
%  [M_D M_D_I] = find(MxD == Dig);

%  plot(X_IN(Non_Tail_I(MxD_I)), Y_IN(Non_Tail_I(MxD_I)),'wd');  % check
%  plot(X_IN(MxD_I), Y_IN(MxD_I),'wd');  % check
  X_2nd = X_IN(Non_Tail_I(MxD_I));
  Y_2nd = Y_IN(Non_Tail_I(MxD_I));

  %figure;imagesc(IM);hold on;plot(X_2nd,Y_2nd,'ow');