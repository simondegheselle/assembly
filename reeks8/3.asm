verm: mov 33H,#00H  
  mov 34H, #00H
  mov 30H, #251d
  mov 31H, #254d
loop:
  clr C
  mov A, 30H
  rrc A
  mov 30H, A
  jnc verder
  mov A, 31H
  add A, 33H
  
