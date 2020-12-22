#include "conveyor.h"


void Conveyor::run_parallel(size_t cars_cnt)
{
    for (size_t i = 0; i < cars_cnt; i++)
    {
        std::shared_ptr<Car> new_car(new Car);
        cars.push_back(new_car);
        q1.push(new_car);
    }

    this->threads[0] = std::thread(&Conveyor::create_carcass, this);
    this->threads[1] = std::thread(&Conveyor::create_engine, this);
    this->threads[2] = std::thread(&Conveyor::create_wheels, this);

    for (int i = 0; i < THRD_CNT; i++)
    {
        this->threads[i].join();
    }
}

void Conveyor::run_linear(size_t cars_cnt) 
{
    for (size_t i = 0; i < cars_cnt; i++)
    {
        std::shared_ptr<Car> new_car(new Car);
        cars.push_back(new_car);
        q1.push(new_car);
    }

    for (size_t i = 0; i < cars_cnt; i++) 
    {
        std::shared_ptr<Car> car = q1.front();
        car->create_carcass(i + 1);
        q2.push(car);
        q1.pop();

        car = q2.front();
        car->create_engine(i + 1);
        q3.push(car);
        q2.pop();

        car = q3.front();
        car->create_wheels(i + 1);
        q3.pop();
    }
}

void Conveyor::create_carcass()
{
    size_t task_num = 0;

    while (!this->q1.empty())
    {
        std::shared_ptr<Car> car = q1.front();
        car->create_carcass(++task_num);

        q2.push(car);
        q1.pop();
    }
}

void Conveyor::create_engine()
{
    size_t task_num = 0;

    do
    {
        if (!this->q2.empty())
        {
            std::shared_ptr<Car> car = q2.front();
            car->create_engine(++task_num);

            q3.push(car);
            q2.pop();
        }
    } while(!q1.empty() || !q2.empty());
}

void Conveyor::create_wheels()
{
    size_t task_num = 0;

    do
    {
        if (!this->q3.empty())
        {
            std::shared_ptr<Car> car = q3.front();
            car->create_wheels(++task_num);
            q3.pop();
        }
    } while (!q1.empty() || !q2.empty() || !q3.empty());
}