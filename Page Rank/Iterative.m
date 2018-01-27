%Metode Numerice:Tema 2
%Drăghici Marius Robert, grupa 315CD
function R = Iterative(nume, d, eps)
	[file, message] = fopen(nume,'r');
	
	%{
		*afisam un mesaj de eroare in caz ca fisierul
		*nu a fost gasit sau nu a putut fi deschis
	%}
	if( file == -1 )
		disp(message);
	endif
	
	frewind(file);
	%{
		*citim din fisier cu ajutorul functiei fgetl prima linie
		*si cum aceasta functie returneaza un string trebuie sa
		*facem conversie la numar intreg
	%}
	nr_lines = str2num(fgetl(file));
	
	%{
		*initializam matricea de adiacenta cu zerouri
	%}
	A = zeros(nr_lines, nr_lines);
	
	for i = 1:nr_lines
		%{
			*extragem de pe fiecare linie din fisier datele necesare
			*pentru a construi matricea de adiacenta; tin cont de
			*faptul ca fgetl extrage un sir, deci si spatiile dintre
			*cifre sunt luate in considerare cand extrag o parte din
			*elementele de pe linie; in plus ne asiguram ca pe diagonala
			*principala matricea de adiacenta are zerouri.
		%}
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
		*pasul initial de iteratie.
	%}
	R = ones(nr_lines,1)/nr_lines;
	succes = 0;
	
	%{
		*recurenta descrisa in enunt are loc cat timp
		*nu am atins acuratetea dorita
	%}
	while( !succes )
		R0 = R;
		one = ones(nr_lines,1);
		R = d*M*R0 + ((1-d)/nr_lines)*one;
		
		if( abs(R - R0) < eps )
			succes = 1;
		endif
	endwhile
	
endfunction
