//
//  ApplicationVC.m
//  ddDemo
//
//  Created by 孙武东 on 2021/1/20.
//

#import "ApplicationVC.h"

@interface ApplicationVC ()

@end

@implementation ApplicationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)buttonAction:(UIButton *)sender {
    NSLog(@"应用页面被点击");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
