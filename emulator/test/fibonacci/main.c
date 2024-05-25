#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#define UART_BASE 0x08000000
void finish(void);//define in bootcode
void print(const char *p);
void _puts(const char p);
int fibonacci(int n);
int main(void) {
    char buffer[10];
    
    int result;
    for(int i = 0; i < 10; i++){
        result = fibonacci(i);
        itoa(result, buffer, 10);
        print(buffer);
        print("\n");
    }
    finish();
    return 0;
}
int fibonacci(int n){
    //Fn = Fn-1 + Fn-2, where n > 1
    if ((n == 0) || (n == 1)) {
        return n;
    }    
    return fibonacci(n-1) + fibonacci(n-2);
}
void print(const char *p) {
    while (*p != '\0') {
        _puts(*p);
        p++;
    }
}

void _puts(const char p) {
    //*(char *)UART_BASE = p;
    *(uint32_t *)UART_BASE = p;
}
