%Metode Numerice:Tema 2
%Drăghici Marius Robert, grupa 315CD
function R = Algebraic(nume, d)
	%{
		*construirea matricei de adiacenta si a matricei M
		*se fac la fel ca la task1
	%}
	[file, message] = fopen(nume,'r');
	
	if( file == -1 )
		disp(message);
	endif
	frewind(file);
	
	nr_lines = str2num(fgetl(file));
	A = zeros(nr_lines, nr_lines);
	
	for i = 1:nr_lines
		page = str2num(fgetl(file,2));
		nr_links = str2num(fgetl(file,2));
		links = str2num(fgetl(file,2 * nr_links));
		A( page, links(1:nr_links) ) = 1;
		if A(i,i) != 0
			A(i,i) = 0;
			K(i,i) = nr_links - 1;
		else
			K(i,i) = nr_links;
		endif
	endfor
	M = (inv(K)*A)';
	
	%{
		*se utilizeaza formula descrisa in enuntul temei
	%}
	R = GramSchmidt(eye(nr_lines,nr_lines) - d*M) * (1 - d)/nr_lines * ones(nr_lines,1);
endfunction
