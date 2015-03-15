//
//  ViewController.m
//  BabySittingCalculator
//
//  Created by Eric Maxwell on 3/14/15.
//  Copyright (c) 2015 Credible Solutions, Inc. All rights reserved.
//

#import "ViewController.h"
#import "Calculator.h"

#define AM_SEGMENT 0
#define PM_SEGMENT 1

@interface ViewController ()

@property (nonatomic, strong) Calculator *calculator;

@property (weak, nonatomic) IBOutlet UILabel *payAmount;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *startAmPmControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *endAmPmControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *bedtimeAmPmControl;

@property (weak, nonatomic) IBOutlet UITextField *startTimeText;
@property (weak, nonatomic) IBOutlet UITextField *endTimeText;
@property (weak, nonatomic) IBOutlet UITextField *bedtimeText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.errorLabel.hidden = YES;
    self.calculator = [[Calculator alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculatePayment:(id)sender {

    @try {
        NSString *start = self.startTimeText.text;
        BOOL isStartPm = self.startAmPmControl.selectedSegmentIndex == PM_SEGMENT;
        int startHour = isStartPm ? ([start intValue] + 12) : [start intValue];

        NSString *end = self.endTimeText.text;
        BOOL isEndPm = self.endAmPmControl.selectedSegmentIndex == PM_SEGMENT;
        int endHour = isEndPm ? ([end intValue] + 12) : [end intValue];

        NSString *bedtime = self.bedtimeText.text;
        BOOL isBedtimePm = self.bedtimeAmPmControl.selectedSegmentIndex == PM_SEGMENT;
        int bedTimeHour = isBedtimePm ? ([bedtime intValue] + 12) : [bedtime intValue];
        
        double result = [self.calculator calculateOneNightPayFromStartHour:startHour toEndHour:endHour withBedTimeAt:bedTimeHour];
        self.payAmount.text = [NSString stringWithFormat:@"$%d", (int)result];
        self.errorLabel.hidden = YES;
    }
    @catch (NSException *exception) {
        self.payAmount.text = @"$0";
        self.errorLabel.hidden = NO;
    }
    
    
    
    
}


@end
