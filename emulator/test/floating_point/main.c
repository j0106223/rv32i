#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#define UART_BASE 0x08000000
void finish(void);//define in bootcode
void print(const char *p);
void _puts(const char p);
int fibonacci(int n);
int main(void) {
    char buffer[10];
    int result;
    double pi = 3.1415926;
    result = ceil(pi);
    itoa(result, buffer, 10);
    print(buffer);
    print("\n");
    result = floor(pi);
    itoa(result, buffer, 10);
    print(buffer);
    print("\n");
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
