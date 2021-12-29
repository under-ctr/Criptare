.386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern fopen:proc
extern fclose:proc
extern fscanf:proc
extern printf:proc
extern fprintf:proc
extern scanf: proc 
extern exit: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod

;;functioneaza primul algoritm 
.data
;aici declaram date
file dd 0
msg_fisier db "indroduceti calea spre fisier: ",13,10, 0
caracter Db 0, 0;
mod_acces db "r", 0
format db "%c",0 
citit dd 0
mod_acces2 db "w",0
nume_file2 db "criptat1.txt", 0
file2 dd 0 
cript db 0
C1 db 0 
format_fisier db "%s",0
msg_cheie db "introduceti cheia de criptare: ",13,10,0 
nume_file db  0,0
.code
start:
	push offset msg_cheie	
	call printf 
	add esp,4 
	
	push offset C1;citesc cheia de criptare 
	push offset format
	call scanf
	add esp, 8 
	
	push offset msg_fisier	
	call printf 
	add esp,4 
	
	push offset nume_file 
	push offset format_fisier
	call scanf 
	add esp,8
	
	;aici se scrie codul
	push offset mod_acces; aici deschid fisierul din care citesc
	push offset nume_file
	call fopen
	mov file, EAX
	add esp, 8
	
	push offset mod_acces2; aici deschid fisierul in care scriu
	push offset nume_file2
	call fopen
	mov file2,eax
	add esp,8
	


	inapoi:
	push offset caracter;aici citesc cate un caracter din fisier 
	push offset format
	push file
	call fscanf
	add esp, 12
	mov citit, eax
	
	cmp citit, -1; verific daca nu am ajuns la sfarsitu fisierului
	je final
	
	mov cl, C1
	mov bl, caracter
	not bl
	add bl,1
	ror bl, cl ; criptez caracterul 
	
	push ebx
	push offset format
	push file2
	call fprintf; aici scriu in fisier caracterul criptat
	add esp, 12 
	
	
	
	
	
	
	

	
	cmp citit, -1
	jne inapoi ;bucla asta merge pana ajung la finalul fisierului din care citesc 
final:
	push file
	call fclose; inchid fisierele 
	add esp, 4
	
	push file2
	call fclose
	add esp, 4 
	
	;;pana aici a fost criptarea 
	
 	
	
	
	;terminarea programului
	push 0
	call exit
end start
