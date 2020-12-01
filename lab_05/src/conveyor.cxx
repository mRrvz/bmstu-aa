#include "conveyor.h"


void Conveyor::run(size_t cars_cnt)
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

void Conveyor::create_carcass()
{
    std::cout << "Create carcass: start\n";

    while (!this->q1.empty())
    {
        std::shared_ptr<Car> car = q1.front();
        car->create_carcass();

        q2.push(car);
        q1.pop();
    }

    std::cout << "Create carcass: end\n";
}

void Conveyor::create_engine()
{
    std::cout << "Create engine: start\n";

    do
    {
        if (!this->q2.empty())
        {
            std::shared_ptr<Car> car = q2.front();
            car->create_engine();

            q3.push(car);
            q2.pop();
        }
    } while(!q1.empty() || !q2.empty());

    std::cout << "Create engine: end\n";
}

void Conveyor::create_wheels()
{
    std::cout << "Create wheels: start\n";

    do
    {
        if (!this->q3.empty())
        {
            std::shared_ptr<Car> car = q3.front();
            car->create_wheels();
            q3.pop();
        }
    } while (!q1.empty() || !q2.empty() || !q3.empty());

    std::cout << "Create wheels: end\n";
}