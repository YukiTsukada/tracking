%
%
function histtest(IM,N)
IMM = IM(:,:,1);
[IM_y IM_x] = size(IMM);
level = graythresh(IMM);
BW_FLIP = im2bw(IMM,level);
BW = (BW_FLIP - 1) .* -1;
BW(1:5,:) = 0;
[BWY BWX] = find(BW);

size_BWY = size(BWY)
%for i = 1:IM_y - N
%  for j = 1:IM_x - N
 for i = 1:10:size_BWY(1)
    figure; subplot(2,1,1);
    imhist(IMM(BWY(i):BWY(i)+N,BWX(i):BWX(i)+N));
    axis([1 255 0 15]);
%    imhist(IMM(i:i+N,j:j+N));    
    subplot(2,1,2);
    imagesc(IMM);hold on;plot(BWX(i),BWY(i),'or');
    pause(0.5);close;
%  end
end
