#include <iostream>
#include <fstream>
#include <cstdint>
#include <string>
class cpu
{
private:
    uint32_t reg[32]; //reg
    uint32_t pc;
    uint32_t reset_vecotor;
    uint32_t *mem;
    uint32_t mem_size;
    void init_gpr();
public:
    int run();
    int reset();
    int hex2mem(const char *hexfile);
    cpu(uint32_t reset_vecotor, char *hexfile);
    ~cpu();
};

int cpu::run() {

}

int cpu::reset() {
    this->pc = this->reset_vecotor;
}

int cpu::hex2mem(const char *hexfile){
    std::ifstream fp(hexfile);
    if (fp.is_open()) {
        return 0;
    }

    this->mem[] = 
    fp.close();
    return 1;
}

cpu::cpu(uint32_t reset_vecotor = 0, char *hexfile)
{
    this->reset_vecotor = reset_vecotor;
}

cpu::~cpu()
{
    //free the memory
}
