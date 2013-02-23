//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Marcello G Sasaki on 30/09/12.
//  Copyright (c) 2012 Marcello G Sasaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

@property (readonly) id program;

- (void)pushOperand:(double)operand;
- (void)pushVariable:(NSString *)variable;
- (double)performOperation:(NSString *)operation;
- (void)clearStack;

+ (double)runProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;
+ (double)runProgram:(id)program
 usingVariableValues:(NSDictionary *)variableValues;
+ (NSSet *)variableUsedInProgram:(id)program;

@end
