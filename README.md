# "Clean" Code, Horrible Performance

> From https://www.computerenhance.com/p/clean-code-horrible-performance

To jump to the results, you can use [a table of contents in github.](https://github.blog/changelog/2021-04-13-table-of-contents-support-in-markdown-files/)

# How to run

Execute `./run.sh`. It will compile the code and run it.

# How to Contribute

1. Add your favorite language version of the code in the `src` folder.
2. Append commands to compile and run the code in the `run.sh` file.
3. Run `./run.sh 100000` to make sure it works.
4. Copy a result to `README.md` file.

This is for fun, so you don't need to repeat the experiments to
get the average.

# Results for 100000 iterations

## Machine: MacBook Air (M1, 2020, 16GB Memory, Ventura 13.2.1)

| Language                 |   Clean |           Switch |         Inline |
| ------------------------ | ------: | ---------------: | -------------: |
| Dart VM                  | 8,342us |  8,555us(0.975x) | 8727us(0.955x) |
| Dart Compiled            | 9,707us | 10,541us(0.920x) | 7468us(1.299x) |
| CPP Compiled with -g -O0 | 7,058us |  8,306us(0.849x) | 4644us(1.519x) |
| CPP Compiled with -O0    | 6,680us |  8,665us(0.770x) | 4275us(1.562x) |
| CPP Compiled with -O1    | 5,693us |  4,751us(1.198x) | 1649us(3.452x) |
| CPP Compiled with -O2    | 4,299us |  3,924us(1.095x) | 1778us(2.417x) |
| CPP Compiled with -O3    | 6,711us |  4,449us(1.508x) | 1042us(6.440x) |
| CPP Compiled with -Ofast | 7,128us |  4,908us(1.452x) | 1324us(5.383x) |
