for i = 1:300
FILE = sprintf('A%i',i);
fprintf(s,'1FCH F,50');
pause(1);
A1 = getsnapshot(vid);imwrite(A1,FILE,'tif');
end
