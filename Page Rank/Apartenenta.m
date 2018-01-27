%Metode Numerice:Tema 2
%Drăghici Marius Robert, grupa 315CD
function y = Apartenenta(x, val1, val2)
	%{
		*aplicam relatia de continuitate descrisa in 
		*enuntul temei.
	%}
	if x < val1
		y = 0;
	elseif x > val2
		y = 1;
	elseif x >= val1 && x <= val2
		A = [ val1 1; val2 1];
		inv_A = GramSchmidt(A);
	    n = inv_A * [0;1];
		a = n(1);
		b = n(2);
		y = a * x + b;
	endif
endfunction
