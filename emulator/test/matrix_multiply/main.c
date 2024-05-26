#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#define UART_BASE 0x08000000
void finish(void);//define in bootcode
void print(const char *p);
void _puts(const char p);

int main(void) {
    char buffer[10];
    int a[10] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    int b[10] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    int result[100] = {0};
    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 10; j++){
            result[i*10+j] = a[i] * b[j];
        }
    }
    for (int i = 0; i < 100; i++) {
       itoa(result[i], buffer, 10);
       print(buffer);
       print("\n"); 
    }
    finish();
    return 0;
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
