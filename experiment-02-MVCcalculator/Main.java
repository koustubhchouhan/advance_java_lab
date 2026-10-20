public class Main {

    public static void main(String[] args) {
        Views cv = new Views();

        Model cm = new Model();
        new CalculatorController(cv,cm);
    }
    
}
