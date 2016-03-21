//
//  ViewController.m
//  CalculatorApp
//
//  Created by 심연진 on 2016. 3. 21..
//  Copyright © 2016년 coriel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// 속성에 대한 get, set 메서드를 생성합니다.
@synthesize curValue;
@synthesize totalCurValue;
@synthesize curStatusCode;
@synthesize displayLabel;

// 화면 초기화가 끝났을 때 호출됩니다.
- (void)viewDidLoad {
    [self ClearCalculation]; // 계산기 화면을 초기화합니다.
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//////////////////
// 화면 회전
//////////////////
-(BOOL)shouldAutorotate{
    return YES;
}

-(UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

/////////////////
// 화면 표시 메서드
/////////////////
-(void)DisplayInputValue:(NSString *)displayText
{
    NSString *CommaText;
    CommaText = [self ConvertComma:displayText];
    [displayLabel setText:CommaText];
}

// 계산결과를 화면에 출력합니다.
-(void)DisplayCalculationValue
{
    NSString *displayText;
    displayText = [NSString stringWithFormat:@"%g", totalCurValue];
    [self DisplayInputValue:displayText];
    curInputValue = @"";
}

// 계산기를 초기화합니다.
-(void)ClearCalculation
{
    curInputValue = @"";
    curValue = 0;
    totalCurValue = 0;
    
    [self DisplayInputValue:curInputValue];
    
    curStatusCode = STATUS_DEFAULT;
}

////////
// 계산 결과값을 표시할 때 천 단위마다 ','가 포함되어 표시될 수 있도록
//
-(NSString *)ConvertComma:(NSString *)data
{
    if(data == nil) return nil;
    if([data length] <= 3) return data;
    
    NSString *integerString = nil;
    NSString *floatString = nil;
    NSString *minusString = nil;
    
    // 소수점을 찾습니다.
    NSRange pointRange = [data rangeOfString:@"."];
    if ( pointRange.location == NSNotFound ) {
        // 소수점이 없다.
        integerString = data;
    }
    else {
        // 소수점 이하 영역을 찾는다.
        NSRange r;
        r.location = pointRange.location;
        r.length = [data length] - pointRange.location;
        floatString = [data substringWithRange:r];
        
        // 정수부 영역을 찾습니다.
        r.location = 0;
        r.length = pointRange.location;
        integerString = [data substringWithRange:r];
    }
    
    // 음수 부호를 찾습니다.
    NSRange minusRange = [integerString rangeOfString:@"-"];
    if(minusRange.location != NSNotFound) { // 음수 부호가 있습니다.
        minusString = @"-";
        integerString = [integerString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    // 세 자리 단위로 콤마를 찍습니다.
    NSMutableString *integerStringCommaInserted = [[NSMutableString alloc] init];
    NSUInteger integerStringLength = [integerString length];
    int idx = 0;
    while (idx < integerStringLength) {
        [integerStringCommaInserted appendFormat:@"%C", [integerString characterAtIndex:idx]];
        if((integerStringLength - (idx + 1))%3 == 0 && integerStringLength != (idx + 1)) {
            [integerStringCommaInserted appendString:@","];
        }
        idx++;
    }
    
    NSMutableString *returnString = [[NSMutableString alloc] init];
    if(minusString != nil) [returnString appendString:minusString];
    if(integerStringCommaInserted != nil) [returnString appendString:integerStringCommaInserted];
    if(floatString != nil) [returnString appendString:floatString];
    
    return returnString;
                    
}

// 숫자와 소수점 버튼을 누르면 호출되는 매서드입니다.
-(IBAction)digitPressed:(UIButton *)sender
{
    NSString *numPoint = [[sender titleLabel] text];
    curInputValue = [curInputValue stringByAppendingFormat:numPoint];
    [self DisplayInputValue:curInputValue];
}

// 기능 버튼을 누르면 호출되는 메서드입니다.
-(IBAction)operationPressed:(UIButton *)sender
{
    NSString *operationText = [[sender titleLabel] text];
    
    if([@"+" isEqualToString:operationText])
    {
        [self Calculation:curStatusCode CurStatusCode:STATUS_PLUS];
    }
    else if([@"-" isEqualToString:operationText])
    {
        [self Calculation:curStatusCode CurStatusCode:STATUS_MINUS];
    }
    else if([@"x" isEqualToString:operationText])
    {
        [self Calculation:curStatusCode CurStatusCode:STATUS_MULTIPLY];
    }
    else if([@"/" isEqualToString:operationText])
    {
        [self Calculation:curStatusCode CurStatusCode:STATUS_DIVISION];
    }
    else if([@"C" isEqualToString:operationText])
    {
        [self ClearCalculation];
    }
    else if([@"=" isEqualToString:operationText])
    {
        [self Calculation:curStatusCode CurStatusCode:STATUS_RETURN];
    }
}

-(void)Calculation:(kStatusCode)StatusCode CurStatusCode:(kStatusCode)cStatusCode;
{
    switch(StatusCode)
    {
        case STATUS_DEFAULT:
            
            [self DefaultCalculation];
            break;
            
        case STATUS_DIVISION:
            [self DivisionCalculation];
            break;
        case STATUS_MULTIPLY:
            [self MultiplyCalculation];
            break;
        case STATUS_MINUS:
            [self MinusCalculation];
            break;
        case STATUS_PLUS:
            [self PlusCalculation];
            break;
    }
    curStatusCode = cStatusCode;
}

// 초기화 이후 처음 입력된 값에 대한 처리
-(void)DefaultCalculation
{
    curValue = [curInputValue doubleValue];
    totalCurValue = curValue;
    
    [self DisplayCalculationValue];
}

// 입력된 값에 대한 덧셈 처리
-(void)PlusCalculation
{
    curValue = [curInputValue doubleValue];
    totalCurValue = totalCurValue + curValue;
    
    [self DisplayCalculationValue];
}

// 입력된 값에 대한 뺼셈 처리
-(void)MinusCalculation
{
    curValue = [curInputValue doubleValue];
    totalCurValue = totalCurValue - curValue;
    
    [self DisplayCalculationValue];
}

// 입력된 값에 대한 곱셈 처리
-(void)MultiplyCalculation
{
    curValue = [curInputValue doubleValue];
    totalCurValue = totalCurValue * curValue;
    
    [self DisplayCalculationValue];
}

// 입력된 값에 대한 나눗셈 처리
-(void)DivisionCalculation
{
    curValue = [curInputValue doubleValue];
    totalCurValue = totalCurValue / curValue;
    
    [self DisplayCalculationValue];
}

- (IBAction)s:(id)sender {
}
@end
