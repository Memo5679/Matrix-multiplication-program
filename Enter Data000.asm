
Data_segment_name segment
    Enter_matrix dw 'Enter the number of matrices: $' 
    Enter_row dw 'Enter the number of row: $'
    Enter_column dw 'Enter the number of column: $' 
    EnterData dw 'Matrix Number $'
    NumOfMatrix dw ?
    TempMat dw ?
    TempRow db ?
    TempCol db ?
    EnterElements dw 'Enter elements of Matrix Number : $'  
    Enter_1 dw  'To Select number of matrices and dimensions press 1$' 
    Enter_2 dw  'To Enter Data press 2$'
    Enter_3 dw  'To Enter elements of Matrix Number press 3$'
    Enter_4 dw  'To Exit press 4$'
    NumOfRow db 50 dup(?)      ;Define an Array that contains number of rows for each matrix
    NumOfColumn db 50 dup(?)   ;Define an Array that contains number of columns for each matrix
    Data dw 2000 dup(?)
    OffestOfElement dw Data
            
Data_segment_name ends

Stack_segment_name segment
    dw 16 dup()    
Stack_segment_name ends

Code_segment_name segment
    Main_prog proc far
        Assume SS:Stack_segment_name, CS:Code_segment_name, DS:Data_segment_name
        Mov AX,Data_segment_name
        Mov DS,AX 
        
 Start:
        Mov DX,DS
        Mov ES,DX
        Mov DI,OffestOfElement
       
        lea dx, Enter_1 ;To Select number of matrices and dimensions press 1 "
        mov ah,9
        Int 21h 
          
        Mov dl, 0dh        ;Move to New line
        Mov ah,2           
        Int 21h
            
        Mov dl, 0ah        ;Move to starting of line
        Int 21h
        
        lea dx, Enter_2 ;To Enter Data press 2 "
        mov ah,9
        Int 21h
                
        Mov dl, 0dh        ;Move to New line
        Mov ah,2           
        Int 21h
            
        Mov dl, 0ah        ;Move to starting of line
        Int 21h
        
        lea dx, Enter_3 ;To Enter elements of Matrix Number press 3 "
        mov ah,9
        Int 21h 
                
        Mov dl, 0dh        ;Move to New line
        Mov ah,2           
        Int 21h
            
        Mov dl, 0ah        ;Move to starting of line
        Int 21h 
        
        lea dx, Enter_4 ;To Exit press 4 "
        mov ah,9
        Int 21h 
        
        Mov dl, 0dh        ;Move to New line
        Mov ah,2           
        Int 21h
            
        Mov dl, 0ah        ;Move to starting of line
        Int 21h 
        
        Mov ah,1 ;Take the PRESS from keyboard 
        int 21h
        Mov ah,0
        Sub al,30h
        mov bl,al
        
        Mov ax,0b800h  ;Clear Screen
        Mov es,ax 
        Mov di,0 
        Mov cx,80*25
        Mov ax,0720h 
        Rep stosw
        
        mov  dl, 0   ;Column
        mov  dh, 0   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h 
        
        Mov AX,Data_segment_name
        Mov DS,AX
        
        CMP bl,1   
        je PRESS_1 
        
        CMP bl,2   
        je PRESS_2
        
        ;CMP al,3   
        ;je PRESS_3
        
        CMP bl,4   
        je PRESS_4 
        
 PRESS_1:
      
        ;ENTER NUMBER OF MATRIX    
        
        Mov dl, 0dh        ;Move to New line
        Mov ah,2           
        Int 21h
        
        lea dx, Enter_matrix ;Enter the number of the matrix: "
        mov ah,9
        Int 21h
        
        Mov ah,1           ;Take the number of the matrix from keyboard 
        int 21h
        Mov ah,0
        Sub al,30h
        Mov NumOfMatrix,ax
        
        
        Mov dl, 0dh        ;Move to New line
        Mov ah,2           
        Int 21h
            
        Mov dl, 0ah        ;Move to starting of line
        Int 21h  
        
        
        Mov TempMat,0
        
        MatData:
            Lea DX, EnterData ;Print "Matrix Number "
            Mov AH,9
            Int 21h
        
            Mov DX,TempMat ;Print number of matrix
            Add Dl,31h
            Mov AH,2h
            Int 21h
            
            Mov dl, 0dh        ;Move to New line
            Mov ah,2           
            Int 21h
            
            Mov dl, 0ah        ;Move to starting of line
            Int 21h    
            
           ;ENTER NUMBER OF ROW
            
            lea dx, Enter_row ;Enter the number of row: "
            mov ah,9
            Int 21h
            
            Mov ah,1           ;Take the number of the row from keyboard 
            int 21h
            
            Sub al,30h
            lea bx,NumOfRow
            add bx,tempmat
            Mov [bx],al
            
            Mov dl, 0dh        ;Move to New line
            Mov ah,2           
            Int 21h
                
            Mov dl, 0ah        ;Move to starting of line
            Int 21h  
            
            ;ENTER NUMBER OF COLUMN
            
            lea dx, Enter_column ;Enter the number of column: "
            mov ah,9
            Int 21h
            
            Mov ah,1           ;Take the number of the column from keyboard 
            int 21h
            
            Sub al,30h
            lea bx,NumOfColumn
            add bx,tempmat
            Mov [bx],al
            
            Mov dl, 0dh        ;Move to New line
            Mov ah,2           
            Int 21h
                
            Mov dl, 0ah        ;Move to starting of line
            Int 21h  
        
        Inc TempMat
        Mov AX,TempMat 
        Cmp NumOfMatrix,AX
        JA MatData 
        
        Mov ax,0b800h  ;Clear Screen
        Mov es,ax 
        Mov di,0 
        Mov cx,80*25
        Mov ax,0720h 
        Rep stosw 
                 
        mov  dl, 0   ;Column
        mov  dh, 0   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h 
                 
        Jmp Start
       
 PRESS_2:
 
        Mov dl, 0dh        ;Move to New line
        Mov ah,2           
        Int 21h
          
      Mov TempMat,0
        
        MatElements:
       
        Mov TempRow,0       ;Determine Row number
        Lea BX, NumOfRow
        Add BX, TempMat
        
        Lea DX, EnterElements ;Print "Enter elements of Matrix Number "
        Mov AH,9
        Int 21h
        
        Mov DX,TempMat ;Print number of matrix
        Add Dl,31h
        Mov AH,2h
        Int 21h
            
        Mov dl, 0dh        ;Move to New line
        Mov ah,2           
        Int 21h
            
        Mov dl, 0ah        ;Move to starting of line
        Int 21h
        
         Row:
            Mov TempCol,0         ;Determine Column number 
            Lea DX, NumOfColumn
            Add DX, TempMat
            Mov BP,DX
            
            Column:                                                   
                    Mov AH,1  ;Enter first digit of first number
                    int 21h
                    Mov DH,AL ;Move ASCII code of first digit to Bl
                    
                    Mov AH,1  ;Enter second digit of first number
                    int 21h
                    Mov DL,AL                    
                    
                    Sub DH,30h ;Find the value of first digit number 
                    Sub DL,30h ;Find the value of second digit number
                    
                    Mov AL,DH
                    Mov CL,10
                    Mul CL
                    Mov AH,0
                    Add AL,DL
 
                    Stosw
                    
                    Mov dl, 20h        ;Print Space
                    Mov ah,2           
                    Int 21h
                    
                    Inc TempCol      ;Increament Column number      
                    Mov AL,DS:[BP]
                    CMP AL,TempCol
                    JA Column      
           
            Mov dl, 0dh        ;Move to New line
            Mov ah,2           
            int 21h
            
            Mov dl, 0ah        ;Move to starting of line
            int 21h
            


            Inc TempRow        ;Increament Row number 
            Mov AL,[BX]
            CMP AL,TempRow
            JA Row    

            
        Inc TempMat
        Mov AX,TempMat 
        Cmp NumOfMatrix,AX
        JA MatElements
                      
        mov  dl, 0   ;Column
        mov  dh, 0   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h   
        
        Mov ax,0b800h  ;Clear Screen
        Mov es,ax 
        Mov di,0 
        Mov cx,80*25
        Mov ax,0720h 
        Rep stosw
        
        Jmp Start 
        
 PRESS_4: 
        
        Mov AX,4c00h
        Int 21h
    Main_prog endp        
Code_segment_name ends
end main_prog
        
        Mov AX,4c00h
        int 21h
    Main_prog endp        
Code_segment_name ends
end main_prog


