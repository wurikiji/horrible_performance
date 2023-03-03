# "Clean" Code, Horrible Performance

> From https://www.computerenhance.com/p/clean-code-horrible-performance

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

===== Dart VM =====

- Clean - Elapsed time: 8342us
- Switch - Elapsed time: 8555us, 0.9751022793687901x
- Inline - Elapsed time: 8727us, 0.9558840380428555x

===== Dart Compiled =====

- Clean - Elapsed time: 9707us
- Switch - Elapsed time: 10541us, 0.9208803718812257x
- Inline - Elapsed time: 7468us, 1.299812533476165x

===== CPP Compiled with -g -O0 =====

- Clean - Elapsed time: 7058us
- Switch - Elapsed time: 8306us, 0.849747x
- Inline - Elapsed time: 4644us, 1.51981x

===== CPP Compiled with -O0 =====

- Clean - Elapsed time: 6680us
- Switch - Elapsed time: 8665us, 0.770917x
- Inline - Elapsed time: 4275us, 1.56257x

===== CPP Compiled with -O1 =====

- Clean - Elapsed time: 5693us
- Switch - Elapsed time: 4751us, 1.19827x
- Inline - Elapsed time: 1649us, 3.4524x

===== CPP Compiled with -O2 =====

- Clean - Elapsed time: 4299us
- Switch - Elapsed time: 3924us, 1.09557x
- Inline - Elapsed time: 1778us, 2.41789x

===== CPP Compiled with -O3 =====

- Clean - Elapsed time: 6711us
- Switch - Elapsed time: 4449us, 1.50843x
- Inline - Elapsed time: 1042us, 6.4405x

===== CPP Compiled with -Ofast =====

- Clean - Elapsed time: 7128us
- Switch - Elapsed time: 4908us, 1.45232x
- Inline - Elapsed time: 1324us, 5.38369x
