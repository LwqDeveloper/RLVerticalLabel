//
//  ViewController.m
//  RLVerticalLabelDemo
//
//  Created by 李韦琼 on 17/3/21.
//  Copyright © 2017年 ___ Zoro___. All rights reserved.
//

#import "ViewController.h"
#import "RLVerticalLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    RLVerticalLabel *label = [[RLVerticalLabel alloc] initWithFrame:CGRectMake(50, 100, 0, 300)];
    label.text = @"这首词是作者镇守西北边疆时所作。格调悲壮苍凉，感情深沉郁抑。它一方面表达了作者要早日平息西夏统治阶级的叛乱，巩固边疆的强烈愿望，另一方面又流露出对久驻边地、怀念家乡的将士的深切同情。";
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor purpleColor];
    label.lineSpace = 5;
    label.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:label];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
