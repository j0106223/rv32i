#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#define UART_BASE 0x08000000
void finish(void);//define in bootcode
void print(const char *p);
void _puts(const char p);
void show_element(int *item,int size);
int main(void) {
    int item[10] = {9,8,7,6,5,4,3,2,1,0};
    int temp;
    print("before sorting\n");
    show_element(item, sizeof(item)/sizeof(int));
    //sorting
    for(int i = 0; i < sizeof(item)/sizeof(int)-1; i++){
        for(int j = 0; j < sizeof(item)/sizeof(int)-1-i; j++){
            if(item[j]>item[j+1]){
                temp = item[j+1];
                item[j+1] = item[j];
                item[j] = temp;
            }
        }
    }
    print("after sorting\n");
    show_element(item, sizeof(item)/sizeof(int));
    finish();
    return 0;
}
void show_element(int *item,int size) {
    char buffer[10];
    for(int i=0; i < size; i++){
        itoa(item[i], buffer, 10);
        print(buffer);
        print(" "); 
    }
    print("\n");
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
