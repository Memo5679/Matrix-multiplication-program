Data_segment_name segment
        NumOfMatrix dw 4
        TempMat dw ?
        TempRow db ?
        TempCol db ?
        EnterMessage dw 'Enter elements of Matrix Number $'
        NumOfRow db    7,7,7,4
        NumOfColumn db 1,1,2,3
        Data dw 400 dup(?)
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
        
        Mov DX,DS
        Mov ES,DX
        Mov DI,OffestOfElement
        
        Mov TempMat,0
        
        Mat:
        Mov TempRow,0       ;Determine Row number
        Lea BX, NumOfRow
        Add BX, TempMat
        
        Lea DX, EnterMessage ;Print "Enter elements of Matrix Number "
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
                    
                    Sub DH,30h ;Find the value of ones digit number 
                    Sub DL,30h ;Find the value of tens digit number
                    
                    Mov AL,DH  ;Add the value of tens and value of ones
                    Mov CL,10
                    Mul CL
                    Mov AH,0
                    Add AL,DL
 
                    Stosw
                    
                    Mov dl, 9h        ;Print tab
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

            
        Inc TempMat          ;Increament Matrix number 
        Mov AX,TempMat 
        Cmp NumOfMatrix,AX
        JA Mat
        
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