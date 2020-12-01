#include <iostream>
#include <thread>

#include "conveyor.h"


int main() 
{
    setbuf(stdout, NULL);
    Conveyor *conveyor_obj = new Conveyor();
    conveyor_obj->run(200);

    delete conveyor_obj;

    return 0;
}
