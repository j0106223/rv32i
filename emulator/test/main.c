#include <stdint.h>

#define UART_BASE 0x08000000
void finish(void);//define in bootcode
void print(const char *p);
void _puts(const char p);
int main(void) {
    for(int i = 0; i < 20; i++){
        print("Hello World!!\n");
        print("TKUEE LAB: RV32I Emulator\n");
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