%Metode Numerice:Tema 2
%Drăghici Marius Robert, grupa 315CD
function B = GramSchmidt(A)
	[nr_lines nr_cols] = size(A);
	for i = 1:nr_lines
		%{
			*am implementat algoritmul Gram-Schmidt modificat descris
			*in laboratorul 3
		%}
		norm = sqrt(sum(A(:,i).*A(:,i)));
		R(i,i) = norm;
		Q(:,i) = A(:,i)/R(i,i);
		R(i,1 + i:nr_lines) = Q(:,i)'*A(:,i+1:nr_lines);
    	A(:,i+1:nr_lines) = A(:,i+1:nr_lines) - Q(:,i)*R(i,i+1:nr_lines);
    endfor
	b = Q';
	B = SST(R,b);      
endfunction
