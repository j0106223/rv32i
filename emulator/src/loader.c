
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
int main(void){    
    uint32_t addr;
    char buffer[50];// \r\n\0
    char *hexfile = "a.hex";
    int data;
    FILE* fp;
    fp = fopen(hexfile,"r");
    while(fgets(buffer,50,fp) != NULL) {
        //printf("%s\n",buffer);
        buffer[strcspn(buffer, "\r\n")] = 0;
        if(buffer[0] == '@'){
            //deal with address
            sscanf(buffer+1, "%x", &addr);
            printf("adder = 0x%08x\n",addr);
        } else {
            //deal with data
            for(int i=0;sscanf(buffer+i, "%x", &data)!=1;i+=3){
                printf("0x%02x\n",data);
            }
        }
    }//use strtol
    fclose(fp);
    return 0;
}