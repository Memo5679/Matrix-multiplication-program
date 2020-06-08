Data_Segment_name segment
   Table1 db 100 dup(20d)
   Table2 db 100 dup(?)
    
Data_Segment_name ends

Stack_Segment_name segment para stack
    db 32h dup(0)
Stack_Segment_name ends

Code_Segment_name segment
   Main_Prog proc far
    Assume SS:Stack_Segment_name, CS:Code_Segment_name,DS:Data_Segment_name
    
    mov AX,Data_Segment_name
    mov DS,AX  
    
    Mov ax,0b800h 
    Mov es,ax 
    Mov ds,ax
    Mov si,160

  
Clear_Screen:
    Mov di,0 
    Mov cx,80*24*2
    Mov ax,0720h 
    Rep stosw
       
       
       
       
       
       
       
       
        
    mov AX,4c00h
    int 21
   Main_Prog endp 
Code_Segment_name ends
    end Main_Prog