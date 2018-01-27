%Metode Numerice:Tema 2
%Drăghici Marius Robert, grupa 315CD
function R = Power(nume,d,eps)
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
		*P si E se calculeaza conform formulelor descrise in
		*enuntul temei.
	%}
	E = ones(nr_lines,1) * ones(nr_lines,1)';
	P = d.*M + ((1 - d)/nr_lines) .* E;
	
	succes = 0;
	%{
		*generam un pas de iteratie initial aleator.
	%}
	R(1:nr_lines,1) = rand();
	maxiter = 100;
	%{
		*am implementat metoda puterii conform algoritmului
		*descris in laboratorul 7; prezenta pasului de iteratie
		*in calcul ne asigura ca nu vom intra intr-o bucla
		*infinita.
	%}
	while maxiter > 0
		maxiter--;
		z = P*R;
		R = z./norm(z,1);
		lambda = R'*P*R;
		
		difference = P*R-lambda*R;
		norm_difference = sqrt(sum(difference.*difference));
		if norm_difference < eps
			break;
		endif
	endwhile
	
endfunction
