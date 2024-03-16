#ifndef _CPU_HEADER_
#define _CPU_HEADER_
#include "pc.h"
#include "memory.h"
#include "regfile.h"
#include "cpu_config.h"
#include "alu.h"
#include "decoder.h"
#include "control.h"
#include "debug.h"

struct cpu{
    struct alu     alu;
    struct memory  rom;//for instruction
    struct memory  ram;//for data
    struct regfile regfile;
    struct pc      pc;
    struct decoder decoder;
    struct control control;
};
#endif