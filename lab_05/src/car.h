#ifndef __CAR_H__
#define __CAR_H__

#include <memory>
#include <cmath>

class Carcass
{
public:
    Carcass(size_t num);
    ~Carcass() = default;

    bool is_freight;
};

class Engine
{
public:
    Engine(int a, int x);
    ~Engine() = default;

    size_t engine_power;
};

class Wheels
{
public:
    Wheels(int n);
    ~Wheels() = default;

    size_t wheels_cnt;
};

class Car
{
public:
    Car() = default;
    ~Car() = default;

    void create_engine();
    void create_carcass();
    void create_wheels();

private:
    std::unique_ptr<Carcass> carcass;
    std::unique_ptr<Engine> engine;
    std::unique_ptr<Wheels> wheels;
};

#endif