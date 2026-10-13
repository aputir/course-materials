// This file intentionally contains a compile error.
// See the debugging handout, Part 2.
class BatteryCalc {
    public static void main(String[] args) {
        int remaining = 7;
        int capacity = 20;
        int percent = (double) remaining / capacity * 100;
        System.out.println(percent);
    }
}
