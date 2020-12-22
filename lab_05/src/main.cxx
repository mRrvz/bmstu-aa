#include <iostream>
#include <thread>

#include "conveyor.h"


int main() 
{
    setbuf(stdout, NULL);
    Conveyor *conveyor_obj = new Conveyor();
    conveyor_obj->run_linear(50);

    delete conveyor_obj;

    return 0;
}
