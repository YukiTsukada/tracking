function UV = unitvector(V,dim)
% UNITVECTOR �x�N�g���̒P�ʃx�N�g�����B
% 
%	UNITVECTOR(V)�͗�x�N�g���Ƃ��ĂЂƂ̃x�N�g�����\���ꂽ�x�N�g���z��V�̊e��̒P�ʃx�N�g����Ԃ��܂��B
%			�܂��CUNITVECTOR(V)�́AUNITVECTOR(V, 1)�Ɠ����ł��B
%	UNITVECTOR(V, DIM)�͒P�ʉ����鎟�����w�肵���x�N�g���z��V�̊e��̒P�ʃx�N�g����Ԃ��܂��B
%
%	�� :
%	��x�N�g��A�̒P�ʃx�N�g���D
%		A = [2;2;0];
%		unitvector(A)
%
%	�s�x�N�g��A�̒P�ʃx�N�g���D
%		A = [2,2,0];
%		unitvector(A,2)
%
%	�x�N�g���z��B�̊e�s�̒P�ʃx�N�g��
%		B = [[0;4;0],[1;1;1],[2;0;3],[3;2;1],[4;1;0],[5;1;1]];
%		unitvector(B)
%

% --
%	Title : UNITVECTOR() 
%	Author : Sach1o : http://sach1o.blog80.fc2.com/
%	Version: 1.0 $ : 2006/12/01 
%	Version: 2.0 $ : 2007/12/03 
%			(�s�ŕ\���ꂽ�x�N�g���ɂ��Ή�)
%	Version: 2.1 $ : 2008/01/23 
%			(�������̒������ɂȂ����Ƃ��̏����ǉ�)
% //--

error(nargchk(1, 2, nargin));

if nargin==1 dim=1; end;

if ~isreal(V) 
	error('�x�N�g���͎����z��ł���K�v������܂��B'); 
end;

if ~isequal(dim,floor(dim)) || numel(dim)~=1 || ndims(V)<dim 
	error('�����̈����́A�C���f�b�N�X�t���͈͂̒��ŁA���̐����̃X�J���łȂ���΂Ȃ�܂���B');
end;

sz = size(V);
sz2 = ones(1,ndims(V));
sz2(dim) = sz(dim);

vnorm = real(sqrt(sum(V.^2,dim)));
vnorm = repmat(vnorm,sz2);
vnorm = reshape(vnorm,sz);

if any(vnorm==0) 
	warning('�[������ł��BNaN��������Inf�ɂȂ��Ă���x�N�g��������܂��B');
end;

UV = V./vnorm;
