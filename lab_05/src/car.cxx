#include "car.h"
#include <iostream>

// Является ли автомобиль грузовым? (проверка на простоту)
Carcass::Carcass(size_t num)
{
    this->is_freight = false;

    for (size_t i = 2; i <= sqrt(num); i++)
    {
        if (0 == num % i) 
        {
            return;
        }
    }

    this->is_freight = true;
}

// Вычисление мощности движка (a^x)
Engine::Engine(int a, int x)
{    
    this->engine_power = a;

    for (int i = 0; i < x; i++)
    {
        this->engine_power *= a;
    }
}

// Вычисление числа колес (n-ое число Фибоначчи)
Wheels::Wheels(int n)
{
    size_t f1 = 1, f2 = 1;
    this->wheels_cnt = f1;

    for (int i = 2; i < n; i++)
    {
        this->wheels_cnt = f1 + f2;
        f1 = f2;
        f2 = this->wheels_cnt;
    }
}

void Car::create_engine()
{
    this->engine = std::unique_ptr<Engine>(new Engine(5, 15000000));
}

void Car::create_carcass()
{
    this->carcass = std::unique_ptr<Carcass>(new Carcass(27644437));
}

void Car::create_wheels()
{
    this->wheels = std::unique_ptr<Wheels>(new Wheels(1000000));
}