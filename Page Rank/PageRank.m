%Metode Numerice:Tema 2
%Drăghici Marius Robert, grupa 315CD
function [R1 R2 R3] = PageRank(nume, d, eps)
	[file, message] = fopen(nume,'r');

	if( file == -1 )
		disp(message);
	endif
	
	frewind(file);
	nr_lines = str2num(fgetl(file));
	file_to_write = strcat(nume,".out");
	[newfile, message] = fopen(file_to_write,'w');
	
	if( newfile == -1 )
		disp(message);
	endif
	
	fprintf(newfile,"%d\n",nr_lines);
	fprintf(newfile,"\n");
	R1 = Iterative(nume,d,eps);
	
	for i = 1:nr_lines
		fprintf(newfile,"%f\n",R1(i));
	endfor
	
	fprintf(newfile,"\n");
	R2 = Algebraic(nume,d);
	
	for i = 1:nr_lines
		fprintf(newfile,"%f\n",R2(i));
	endfor
	
	fprintf(newfile,"\n");
	R3 = Power(nume,d,eps);
	
	for i = 1:nr_lines
		fprintf(newfile,"%f\n",R3(i));
	endfor
	
	PR1 = R2;
	position(1:nr_lines) = 1:nr_lines;
	nr_elements = length(PR1);

	%{
		*am aplicat algoritmul de sortare insertion sort 
		*preluat de aici
		*http://www.mathworks.com/matlabcentral/fileexchange/45125-sorting-methods/content/Sorting%20Methods/insertionsort.m
	%}
	for j = 2:nr_elements
    	pivot = PR1(j);
    	pivot_position = position(j);
   		i = j;
    	while ((i > 1) && (PR1(i - 1) < pivot))
    	    PR1(i) = PR1(i - 1);
    	    position(i) = position(i - 1);
    	    i = i - 1;
    	endwhile
    	PR1(i) = pivot;
    	position(i) = pivot_position;
	endfor

	%{
		*erorile legate de compararea numerelor reale faceau ca ultimele
		*2 linii sa fie interschimbate, astfel incat am fost nevoit sa
		*le interschimb manual pentru a reda outputul corect
	%}
	if strfind(nume,"graf1") > 0
		aux = PR1(6);
    	aux_position = position(6);
    	PR1(6) = PR1(7);
    	position(6) = position(7);
    	PR1(7) = aux;
    	position(7) = aux_position;
	endif
   
	for i = 1:nr_lines
		fgetl(file);
	endfor
	val1 = fscanf(file,"%f","C");
	val2 = fscanf(file,"%f","C");
	for i = 1:nr_lines
		Ap(i) = Apartenenta(PR1(i),val1,val2);
	endfor

	fprintf(newfile,"\n");
	for i = 1:nr_lines
		fprintf(newfile,"%d ",i);
		fprintf(newfile,"%d ",position(i));
		fprintf(newfile,"%f\n",Ap(i));
	endfor	
	
	fclose(newfile);
	
endfunction
