#spec/calculator_spec.rb
require './lib/calculator'

describe Calculator do
  describe "#add" do
    it "returns the sum of two numbers" do
      calculator = Calculator.new
      expect(calculator.add(5, 2)).to eql(7)
    end

    it "returns the sum of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.add(2, 5, 7)).to eql(14)
    end
  end
  describe "#multiply" do
    it "return the product of two numbers" do
      calculator = Calculator.new
      expect(calculator.multiply(5, 3)).to eql(15)
    end
  end
  describe "#subtract" do
    it "return the difference between two numbers" do
      calculator = Calculator.new
      expect(calculator.subtract(7, 5)).to eql(2)
    end
  end
  describe "#divide" do
    it "return the quotient between two numbers" do
      calculator = Calculator.new
      expect(calculator.divide(50, 10)).to eql(5)
    end
  end
end
