#ifndef __LOGGER_H__
#define __LOGGER_H__

#include <iostream>
#include <chrono>

using namespace std::chrono;

class Logger 
{
public:
    Logger() = default;
    ~Logger() = default;

    static void log_current_event(size_t task_num, const char *const event);
};

#endif