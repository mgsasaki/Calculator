//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Marcello G Sasaki on 30/09/12.
//  Copyright (c) 2012 Marcello G Sasaki. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain ()

@property (strong,nonatomic) NSMutableArray * programStack;

@end


@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray *)programStack
{
    if (!_programStack)
        _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

- (void)clearStack
{
    [self.programStack removeAllObjects];
}

-(void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

- (void)pushVariable:(NSString *)variable
{
    [self.programStack addObject:variable]; 
}

- (double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}

- (id)program
{
    return [self.programStack copy];
}
    
+ (NSString *)descriptionOfProgram:(id)program
{
    NSString * result = @"Implement later";
    
    return result;
}

+ (double)popOperandOfStack:(NSMutableArray *)stack
        usingVariableValues:(NSDictionary *)variableValues
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];

    if ([topOfStack isKindOfClass:[NSNumber class]])
    {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]])
    {
        if ([topOfStack isEqualToString:@"+"])
            result = [self popOperandOfStack:stack usingVariableValues:variableValues] + [self popOperandOfStack:stack usingVariableValues:variableValues];
        else if ([topOfStack isEqualToString:@"*"])
            result = [self popOperandOfStack:stack usingVariableValues:variableValues] * [self popOperandOfStack:stack usingVariableValues:variableValues];
        else if ([topOfStack isEqualToString:@"-"])
        {
            double subtrahend = [self popOperandOfStack:stack usingVariableValues:variableValues];
            result = [self popOperandOfStack:stack usingVariableValues:variableValues] - subtrahend;
        }
        else if ([topOfStack isEqualToString:@"/"])
        {
            double divisor = [self popOperandOfStack:stack usingVariableValues:variableValues];
            if ( divisor == 0 )
                result = 0;
            else
                result = [self popOperandOfStack:stack usingVariableValues:variableValues] / divisor;
        }
        else if ( [topOfStack isEqualToString:@"sin"] )
            result = sin([self popOperandOfStack:stack usingVariableValues:variableValues] );
        else if ( [topOfStack isEqualToString:@"cos"] )
            result = cos( [self popOperandOfStack:stack usingVariableValues:variableValues] );
        else if ( [topOfStack isEqualToString:@"sqrt"] )
            result = sqrt( [self popOperandOfStack:stack usingVariableValues:variableValues] );
        else if ( [topOfStack isEqualToString:@"π"] )
            result = M_PI;
        else if (variableValues)
            result = [[variableValues objectForKey:topOfStack] doubleValue];
    }
    return result;
}

+ (double)runProgram:(id)program
{
    return [self runProgram:program usingVariableValues:nil];
}

+ (double)runProgram:(id)program
 usingVariableValues:(NSDictionary *)variableValues
{
    NSMutableArray * stack;
    if ([program isKindOfClass:[NSArray class]])
    {
        stack = [program mutableCopy];
    }
    return [self popOperandOfStack:stack usingVariableValues:nil];
}

+ (NSSet *)variableUsedInProgram:(id)program
{
    NSMutableSet * variables;
    NSMutableArray * stack;
    if ([program isKindOfClass:[NSArray class]])
    {
        stack = [program mutableCopy];
    }
    return [variables copy];
}

@end
