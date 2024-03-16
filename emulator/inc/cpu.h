#include "type.h"
#include "regfile.h"
class cpu{
private:
    reg pc;
    regfile regfile;
    reg get_pc();
    void set_pc();
public:
    void load_binary(char * filename);
    void run();
};