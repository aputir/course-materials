// This file intentionally contains a logic error (off-by-one).
// See the debugging handout, Part 4.
class Checkerboard {
    public static void main(String[] args) {
        int rows = 4;
        int cols = 4;
        for (int row = 0; row <= rows; row++) {
            for (int col = 0; col < cols; col++) {
                System.out.print((row + col) % 2 == 0 ? "X " : ". ");
            }
            System.out.println();
        }
    }
}
