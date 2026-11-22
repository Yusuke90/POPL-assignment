    # Part 1 Report — Department Assignment Puzzle (Group 74)

    Terminology: a *candidate* is any assignment of the four departments, four
    languages and four projects to the four friends (4! x 4! x 4! = 13,824 in
    total). A *solution* is a candidate that satisfies the active clues.

    ## 1. Solution Count for Clues 1–8
    Running `count_solutions([1,2,3,4,5,6,7,8], N)` produces: N=3

    The three solutions that satisfy clues 1 to 8, in the order Alex, Ben, Carla, Dana (department, language, project):

    | | Alex | Ben | Carla | Dana |
    | :--- | :--- | :--- | :--- | :--- |
    | S1 | design, java, AI | development, javascript, web | research, c++, data | testing, python, embedded |
    | S2 | design, java, embedded | development, javascript, web | testing, python, AI | research, c++, data |
    | S3 | testing, python, embedded | development, javascript, web | design, java, AI | research, c++, data |

    Ben has the same values in all three. S1 and S3 contain exactly the same four
    bundles of (department, language, project) and differ only in which friend
    holds which bundle. S2 contains different bundles.

    ### Leave-One-Out Verification
    Omitting one clue at a time confirms each constraint's individual effect on the search space:

    | Active Clues | Omitted Clue | Valid Solutions (`N`) |
    | :--- | :--- | :---: |
    | `[1,2,3,4,5,6,7,8]` | None | 3 |
    | `[2,3,4,5,6,7,8]` | Clue 1 | 4 |
    | `[1,3,4,5,6,7,8]` | Clue 2 | 6 |
    | `[1,2,4,5,6,7,8]` | Clue 3 | 13 |
    | `[1,2,3,5,6,7,8]` | Clue 4 | 12 |
    | `[1,2,3,4,6,7,8]` | Clue 5 | 9 |
    | `[1,2,3,4,5,7,8]` | Clue 6 | 7 |
    | `[1,2,3,4,5,6,8]` | Clue 7 | 5 |
    | `[1,2,3,4,5,6,7]` | Clue 8 | 16 |
    higher the number more useful that clue was.

    ## 2. What This Tells Us About the Puzzle
    Because `N = 3` (greater than `1`), Clues 1 through 8 **under-constrain** the puzzle: they narrow the $4! \times 4! \times 4! = 13,824$ possible permutations down to **3 valid assignments**, meaning the initial eight clues alone do not define a unique solution.

    SBecause `N = 3` (greater than 1), clues 1 to 8 under-constrain the puzzle: they reduce the 13,824 candidates to 3 solutions, so the eight clues alone do not give a unique answer.

    ## 3. Adding Clue 9 for a Unique Solution (`N = 1`)

    **Clue 9:** The friend who prefers the AI project works in the testing department.

    **Result:** `count_solutions([1,2,3,4,5,6,7,8,9], N)` gives `N = 1`.

    The solution kept is S2. In S2 the AI friend (Carla) works in testing, so clue 9 is true. In S1 and S3 the AI friend works in design, so clue 9 is false there. The clue names no friend and refers to friends only through attribute values. `main/0` still prints S1, which is valid because it only has to satisfy clues 1 to 8.