from random import randint

N = 1000

def main():
    with open("data/dataset.txt", "w") as f:
        for x in range(N):
            f.write(f"{x} {randint(1, 360)}\n")

if __name__ == "__main__":
    main()