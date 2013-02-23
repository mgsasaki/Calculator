//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Marcello G Sasaki on 29/09/12.
//  Copyright (c) 2012 Marcello G Sasaki. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic,strong) CalculatorBrain *brain;

@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize memoryDisplay = _memoryDisplay;

-(CalculatorBrain *)brain
{
    if( !_brain ) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    NSLog(@"Digit pressed: %@", digit);
    
    if( self.userIsInTheMiddleOfEnteringANumber )
    {
        NSRange range = [self.display.text rangeOfString:@"."];
        if ( range.location == NSNotFound && [self.display.text doubleValue] == 0 )
            self.display.text = digit;
        else
            self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else
    {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    self.memoryDisplay.text = [self.memoryDisplay.text stringByAppendingString:digit];
}

- (IBAction)decimalPointPressed:(UIButton *)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        NSRange range = [self.display.text rangeOfString:@"."];
        if( range.location == NSNotFound )
            self.display.text = [self.display.text stringByAppendingString:[sender currentTitle]];
    }
    else
    {
        self.display.text = @"0.";
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)clearPressed
{
    [self.brain clearStack];
    self.display.text = @"0";
    self.memoryDisplay.text = @"";
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.memoryDisplay.text = [self.memoryDisplay.text stringByAppendingString:@" "];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)operandPressed:(UIButton *)sender
{
    if ( self.userIsInTheMiddleOfEnteringANumber )
        [self enterPressed];
    
    NSString *operation = sender.currentTitle;
    self.memoryDisplay.text = [self.memoryDisplay.text stringByAppendingString:[NSString stringWithFormat:@"%@ ",operation]];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g",result];
}

@end
