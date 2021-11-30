s = serial('COM2');
set(s,'BaudRate',19200,'Parity','even','terminator','CR/LF','StopBits',2);
fopen(s);
fprintf(s,'1LOG IN');
fprintf(s,'1FCL F,1000');
fprintf(s,'1FCL N,1000');
fprintf(s,'1FCH N,1000');
fprintf(s,'1FCL F,1000');

out = fscanf(s);
fclose(s)
delete(s)
clear s
