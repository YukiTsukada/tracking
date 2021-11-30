function pts = reshape_points_seaquence(points, mode, psz, planarflag) 
%	RESHAPE_POINTS_SEAQUENCE	入力点列の整形
%	※　この関数はCHECK_POINTS_SEAQUENCE()とセットで使用される関数のためエラーチェックをしていません。
%	
%	mode:
%		0 : 3×N
%		1 : N×3
%		2 : 1×N×3
%		3 : N×1×3

% --
%	Title : RESHAPE_POINTS_SEAQUENCE()
%	Author : Sach1o : http://sach1o.blog80.fc2.com/
%	Created : 2008/01/23
% //-- 

%%% 入力チェック 
% 入力点列の次元チェック 
if nargin<4 
	planarflag=0;
end;

if planarflag==1 
	points = points(1:2,:);
end;

switch mode 
	case 0
		pts = points;
	case 1 
		pts = points';
	case 2 
		pts(:,:,1) = points(1,:);
		if numel(psz)==3 
			pts(:,:,2) = points(2,:);
			if planarflag~=1
				pts(:,:,3) = points(3,:);
			end;
		end;
	case 3 
		points = points';
		pts(:,:,1) = points(:,1);
		if numel(psz)==3 
			pts(:,:,2) = points(:,2);
			if planarflag~=1
				pts(:,:,3) = points(:,3);
			end;
		end;
	otherwise 
		error('第2引数が不正です。');
end;
%%%
