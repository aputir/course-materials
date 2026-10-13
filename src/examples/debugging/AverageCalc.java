// This file intentionally contains a runtime error (division by zero).
// See the debugging handout, Part 3.
import java.util.Scanner;

class AverageCalc {
    public static void main(String[] args) {
        int total = 0;
        int count = 0;
        Scanner input = new Scanner(System.in);
        int value = input.nextInt();
        while (value != -1) {
            int avg = total / count;  // count is still 0!
            total += value;
            count++;
            value = input.nextInt();
        }
        System.out.println("Total: " + total);
    }
}
