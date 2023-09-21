@isTest
public class CalculatorTests {
  @isTest
  static void testDivideByZero() {
    // GIVEN

    // WHEN
    try {
      Decimal result = Calculator.divide(10, 0);
      Assert.fail(
        'Expected a CalculatorException for divide by zero, but no exception was thrown.'
      );
    } catch (Calculator.CalculatorException e) {
      // THEN
      Assert.areEqual(
        'You still can\'t divide by zero',
        e.getMessage(),
        'Wrong exception message for divide by zero'
      );
    }
  }
}
