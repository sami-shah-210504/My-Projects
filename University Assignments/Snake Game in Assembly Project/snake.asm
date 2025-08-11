[org 0x0100]

jmp start
score_label: db 'SCORE: $'
old :dd 0
snake_row : resb 2000
snake_col: resb 2000
snake_length: dw 0
direction: dw 1
food_x: dw 0 
food_y: dw 0
score: dw 0
game_over_msg: db 'GAME OVER :( CONTINUE? (Y/N) $'
goodbye_msg: db 'GOODBYE :) $'

delay:
mov cx, 50000
l1:
loop l1
ret

self_collision_check:
    pusha
    mov cx, [snake_length]
    cmp cx, 1
    jbe no_collision

    mov si, 1
    mov al, [snake_row]
    mov dl, [snake_col]
check_loop:
    mov bl, [snake_row + si]
    cmp al, bl
    jne next
    mov bl, [snake_col + si]
    cmp dl, bl
    je game_over
next:
    inc si
    cmp si, cx
    jl check_loop
no_collision:
    popa
    ret

calculate_location:
    push bp
    mov bp,sp
    push dx
    push bx
    mov dx,[bp+6]
    mov ax,80
    mov bx, [bp+4]
    mul dx
    add ax,bx
    shl ax,1
    pop bx
    pop dx
    pop bp
    ret 4

clr_scr:
    push es
    push ax
    push di
    mov ax, 0xb800
    mov es, ax
    mov di, 0
next_char:
    mov word [es:di], 0x0720
    add di, 2
    cmp di, 4000
    jne next_char
    pop di
    pop ax
    pop es
    ret

borders:
    push es
    push ax
    push di
    mov ax, 0xb800
    mov es, ax
    mov di,0
    mov ax,0x1220
borderTop:
    mov [es:di],ax
    add di,2
    cmp di,160
    jne borderTop
borderLeft:
    mov [es:di],ax
    add di,160
    cmp di,3840
    jne borderLeft
borderBottom:
    mov [es:di],ax
    add di,2
    cmp di,4000
    jne borderBottom
    sub di,2
borderRight:
    mov [es:di],ax
    sub di,160
    cmp di,158
    jne borderRight
    pop di
    pop ax
    pop es
    ret

snake_intializer_function:
    pusha
    push es
    mov bx,0
    mov cx,2
    mov [snake_length],cx
loopy:
    mov byte[snake_row+bx],12
    inc bx
    loop loopy
    mov bx,0
    mov cx,15
    mov ax,10
loopx:
    mov byte[snake_col+bx],al
    inc ax
    inc bx
    loop loopx
    pop es
    popa
    ret

draw_snake:
    pusha
    push es
    mov bx,0xb800
    mov es,bx
    mov si,0
    mov cx,[snake_length]
getcoordss:
    mov ah, 0
    mov al, [snake_row+si]
    push ax
    mov al,  [snake_col+si]
    push ax
    call calculate_location
    mov di, ax
    mov word [es:di],0x042a
    inc si
    loop getcoordss
    pop es
    popa
    ret

erase_snake:
    pusha
    push es
    mov bx,0xb800
    mov es,bx
    mov si,0
    mov cx,[snake_length]
getcoords:
    mov ah, 0
    mov al, [snake_row+si]
    push ax
    mov al,  [snake_col+si]
    push ax
    call calculate_location
    mov di, ax
    mov word [es:di],0x0720
    inc si
    loop getcoords
    pop es
    popa
    ret

myinterrupt:
    in al,0x60
    cmp al,0x48
    jne checkdown
    mov word [direction],1
    jmp endinterrupt
checkdown:
    cmp al,0x50
    jne checkleft
    mov word [direction],2
    jmp endinterrupt
checkleft:
    cmp al,0x4b
    jne checkright
    mov word [direction],3
    jmp endinterrupt
checkright:
    cmp al, 0x4d
    jne endinterrupt
    mov word [direction],4
endinterrupt:
    jmp far [cs:old]

shift_snakeright:
    pusha
    push es
    mov cx,[snake_length]
    sub cx, 1
    mov bx, cx
    mov ah, 0
    mov al, [snake_row + bx]
    push ax
    mov al, [snake_col + bx]
    push ax
    call calculate_location
    mov di, ax
    mov ax, 0xb800
    mov es, ax
    mov word [es:di], 0x0720
shift_rightx:
    mov dl,[snake_col+bx-1]
    mov [snake_col+bx],dl
    dec bx
    loop shift_rightx
    mov cx,[snake_length]
    sub cx, 1
    mov bx, cx
shift_righty:
    mov dl,[snake_row+bx-1]
    mov [snake_row+bx],dl
    dec bx
    loop shift_righty
    pop es
    popa
    ret

updatehead:
    pusha
    mov ax,[direction]
    cmp ax,1
    jne downn
    dec byte [snake_row]
    jmp endd
downn:
    cmp ax,2
    jne leftt
    inc byte[snake_row]
    jmp endd
leftt:
    cmp ax,3
    jne rightt
    dec byte [snake_col]
    jmp endd
rightt:
    inc byte[snake_col]
endd:
    popa
    ret

generate_food:
    push ax
    push dx
    mov ah, 00h
    int 1Ah
    mov ax, dx
    xor dx, dx
    mov cx, 76
    div cx
    add dl, 2
    mov [food_x], dx
    mov ah, 00h
    int 1Ah
    mov ax, dx
    xor dx, dx
    mov cx, 21
    div cx
    add dl, 2
    mov [food_y], dx
    call draw_food
    pop dx
    pop ax
    ret

draw_food:
    push ax
    push di
    push es
    mov ax, word [food_y]
    push ax
    mov ax, word [food_x]
    push ax
    call calculate_location
    mov di, ax
    mov ax, 0xb800
    mov es, ax
    mov al, '@'
    mov ah, 8Ah
    mov [es:di], ax
    pop es
    pop di
    pop ax
    ret

check_food_eaten:
    pusha
    mov ah, 0
    mov al, byte [snake_row]
    push ax
    mov ah, 0
    mov al, byte [snake_col]
    push ax
    call calculate_location
    mov bx, ax
    mov ax, word [food_y]
    push ax
    mov ax, word [food_x]
    push ax
    call calculate_location
    cmp ax, bx
    jne not_eaten
    call increment_score
    call print_score
    call generate_food
    inc word [snake_length]
not_eaten:
    popa 
    ret

increment_score:
    mov ax, word [score]
    add ax, 1
    mov word [score], ax
    ret

print_score:
    pusha
    mov ah, 02h
    mov bh, 0
    mov dh, 1
    mov dl, 1
    int 10h
    mov dx, score_label
    mov ah, 09h
    int 21h
    mov ax, [score]
    call print_num
    popa
    ret

print_num:
    pusha
    xor cx, cx
print_loop:
    xor dx, dx
    mov bx, 10
    div bx
    push dx
    inc cx
    test ax, ax
    jnz print_loop
print_digits:
    pop dx
    add dl, '0'
    mov ah, 0Eh
    mov al, dl
    int 10h
    loop print_digits
    popa
    ret

check_collision_wall:
    mov al, [snake_row]
    cmp al, 1
    jb game_over
    cmp al, 23
    ja game_over
    mov al, [snake_col]
    cmp al, 1
    jb game_over
    cmp al, 78
    ja game_over
    ret

check_input:
    ret

start:
    mov ax,0
    mov es,ax
    mov ax,[es:9*4]
    mov [old],ax
    mov ax, [es:9*4+2]
    mov [old+2],ax
    cli
    mov word [es:9*4], myinterrupt
    mov [es:9*4+2],cs
    sti

begin_game:
    call clr_scr
    call borders
    call snake_intializer_function
    call draw_snake
    call generate_food
    call print_score

shiftTestLoop:
    call shift_snakeright
    call updatehead
    call delay
    call erase_snake
    call delay
    call draw_snake
    call check_food_eaten
    call delay
    call self_collision_check
    call check_collision_wall
    jmp shiftTestLoop

game_over:
    call clr_scr
    mov ah, 02h
    mov bh, 0
    mov dh, 12
    mov dl, 30
    int 10h
    mov dx, game_over_msg
    mov ah, 09h
    int 21h

wait_for_choice:
    mov ah, 00h
    int 16h
    cmp al, 'y'
    je restart_game
    cmp al, 'Y'
    je restart_game
    cmp al, 'n'
    je terminate
    cmp al, 'N'
    je terminate
    jmp wait_for_choice

restart_game:
    mov word [score], 0
    mov word [snake_length], 0
    mov word [direction], 1
    call snake_intializer_function
    jmp begin_game

terminate:
	call clr_scr
	mov ah, 02h
    mov bh, 0
    mov dh, 12
    mov dl, 30
    int 10h
    mov dx, goodbye_msg
    mov ah, 09h
    int 21h
    mov ax, 4C00h
    int 21h