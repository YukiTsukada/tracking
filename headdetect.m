% detect head (max curvature position)
% R = radius to define the curvature
function [Y_Max X_Max] = headdetect(IM,R);

IMM = IM(:,:,1);
level = graythresh(IMM);
BW = im2bw(IMM,level);

SE = strel('disk',5);
OPEN = imopen(BW,SE);
EDGE = edge(OPEN);
EDGE(1:3,:)=0;

EDGE_IN = EDGE;
EDGE_IN(1:20,:) = 0;EDGE_IN(end-20:end,:) = 0;
EDGE_IN(:,1:20) = 0;EDGE_IN(:,end-20:end) = 0;
[Y_IN X_IN] = find(EDGE_IN==1);
size_IN = size(Y_IN);

[Y X] = find(EDGE==1);
sizeY = size(Y);
figure; imagesc(EDGE);hold on;

  for i = 1:size_IN
    %plot(X,Y,'ow');hold off; 
    XX = repmat(X_IN(i),sizeY(1),1);
    YY = repmat(Y_IN(i),sizeY(1),1);
    
    IN_CIRCLE = find((X - XX).^2 + (Y -YY).^2 <= R^2 & (X - XX).^2 + (Y -YY).^2 >= (R-2)^2 );
    plot(X_IN(i),Y_IN(i),'*w'); % center 

    %  plot(X(IN_CIRCLE),Y(IN_CIRCLE),'ow'); % edge of the circle 
  
    %  plot(X(IN_CIRCLE(1)),Y(IN_CIRCLE(1)),'*k');
    sizeIN_CIRCLE = size(IN_CIRCLE);
    ONE_SIDE_X = repmat(X(IN_CIRCLE(1)),sizeIN_CIRCLE(1),1);
    ONE_SIDE_Y = repmat(Y(IN_CIRCLE(1)),sizeIN_CIRCLE(1),1);
  
    OTHER_SIDE = find((X(IN_CIRCLE) - ONE_SIDE_X).^2 + (Y(IN_CIRCLE) ...
                     - ONE_SIDE_Y).^2  >= 100 );
    % plot(X(IN_CIRCLE(OTHER_SIDE)),Y(IN_CIRCLE(OTHER_SIDE)),'*b');hold off;
  
    Right_X = X(IN_CIRCLE(1)); Right_Y = Y(IN_CIRCLE(1));
    Left_X = X(IN_CIRCLE(OTHER_SIDE(1))); Left_Y = Y(IN_CIRCLE(OTHER_SIDE(1)));
    %  plot(Right_X,Right_Y,'g*'); plot(Left_X,Left_Y,'b*');

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
    c = colormap;
  
    colorsign = abs(round((62/90)*Dig(i)))+1;
    plot(X_IN(i),Y_IN(i),'Marker','*','color',c(colorsign,:)); % center 

  end
[MaxD MaxD_IDX] = max(Dig);

plot(X_IN(MaxD_IDX),Y_IN(MaxD_IDX),'ko');

X_Max = X_IN(MaxD_IDX);
Y_Max = Y_IN(MaxD_IDX);
