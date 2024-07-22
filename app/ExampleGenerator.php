<?php

namespace App;

class ExampleGenerator
{
      private $firstNumber;
      private $secondNumber;
      private $operator;

    public function generate() : void{
        $operators = ['+', '-', '*'];
        $random_key = array_rand($operators);
        $this->operator = $operators[$random_key];
        $this->firstNumber = rand(1,100);
        $this->secondNumber = rand(1, $this->firstNumber - 1);
    }
    public function getExpression() : string{
        return $this->firstNumber . ' ' . $this->operator . ' ' . $this->secondNumber;
    }
    public function calculate(){
        switch ($this->operator) {
            case '+':
                return $this->firstNumber + $this->secondNumber;
            case '-':
                return $this->firstNumber - $this->secondNumber;
            case '*':
                return $this->firstNumber * $this->secondNumber;
            default:
                return 'System Error';
        }

    }
}