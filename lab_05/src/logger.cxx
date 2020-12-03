#include "logger.h"

void Logger::log_current_event(size_t task_num, const char *const event) 
{
    system_clock::time_point now = system_clock::now();
    system_clock::duration tp = now.time_since_epoch();

    tp -= duration_cast<seconds>(tp);

    time_t tt = system_clock::to_time_t(now);
    tm t = *gmtime(&tt);

    std::printf("Task №%lu | %s | %02u:%02u:%02u.%3u\n", 
                task_num,
                event, 
                t.tm_hour, 
                t.tm_min, 
                t.tm_sec, 
                static_cast<unsigned>(tp / milliseconds(1))
    );
}