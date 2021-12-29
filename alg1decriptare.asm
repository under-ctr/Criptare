.386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern fopen:proc
extern fclose:proc
extern fscanf:proc
extern printf:proc
extern fprintf:proc
extern scanf: proc 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date
msg_cheie db "introdueti cheia de decriptare: ",13,10, 0
msg_fisier db "indroduceti calea spre fisier: ",13,10, 0 
format_fisier db "%s", 0
filed1 dd 0
format db "%c",0 
file2d1 dd 0 
mod_acces db "r",0
mod_acces2 db "w", 0 

nume_file2d1 db "decriptat1.txt", 0 
caracter db 0, 0
D1 db 0
citit dd 0
nume_file db 0, 0 
.code
start:
	;aici se scrie codul
	push offset msg_cheie	
	call printf 
	add esp,4 
	
	push offset D1 
	push offset format ;aici mai citesc o data cheia de criptare , dar cand pui in acelasi proiect tot nu o sa mai ai nevoie si de citirea asta din nou   
	call scanf
	add esp, 8  
	
	push offset msg_fisier	
	call printf 
	add esp,4 
	
	push offset nume_file 
	push offset format_fisier
	call scanf 
	add esp,8
	
	push offset mod_acces
	push offset nume_file
	call fopen
	mov filed1, EAX
	add esp, 8
	
	push offset mod_acces2
	push offset nume_file2d1
	call fopen
	mov file2d1,eax
	add esp,8

	mov ebx, 0 
	
	
	
bucla: 

	push offset caracter 
	push offset format 
	push filed1 ; citesc primul caracter din fisierul criptat
	call fscanf
	add esp,12 
	mov citit, eax 
	
	
	cmp citit, -1 ;verific daca nu am ajuns la final 
	je final 
	
	mov cl,D1
	mov bl, caracter; decriptez caracterul, fac operatiile in ordine inversa fata de criptare 
	rol bl, cl
	sub bl,1
	not bl 
	
	push ebx
	push offset format
	push file2d1
	call fprintf; si scriu caracterul decriptat intr-un nou fiser 
	add esp, 12

	
	
	cmp citit,-1; mai verific o data daca sunt ajuns la final si daca nu am ajuns repet operatiile 
	
	jne bucla
	
	;terminarea programului
final: 	
	push filed1
	call fclose
	add esp, 4
	
	push file2d1
	call fclose
	add esp,4 
	
	push 0
	call exit
end start

