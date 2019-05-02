//
//  ZWWCase1MasonryVC.m
//  InterviewDemo
//
//  Created by jolly on 2019/4/3.
//  Copyright © 2019年 mac. All rights reserved.
//

// 文档
//Content Compression Resistance = 不许挤我！
//对，这个属性说白了就是“不许挤我”=。=
//这个属性的优先级（Priority）越高，越不“容易”被压缩。也就是说，当整体的空间装不下所有的View的时候，Content Compression Resistance优先级越高的，显示的内容越完整。
//
//Content Hugging = 抱紧！
//这个属性的优先级越高，整个View就要越“抱紧”View里面的内容。也就是View的大小不会随着父级View的扩大而扩大。

#import "ZWWCase1MasonryVC.h"

@interface ZWWCase1MasonryVC ()

@property (strong, nonatomic) UILabel *label1;
@property (strong, nonatomic) UILabel *label2;
@property (weak, nonatomic) IBOutlet UIView *contentView1;

@end

@implementation ZWWCase1MasonryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initViews];
}
- (IBAction)addLabelConstraintAction:(UIStepper *)sender {
    switch (sender.tag) {
        case 0:
            _label1.text = [self getLabelContentWithCount:(NSUInteger)sender.value];
            break;
            
        case 1:
            _label2.text = [self getLabelContentWithCount:(NSUInteger)sender.value];
            break;
            
        default:
            break;
    }
}

- (void)initViews{
    _label1 = [UILabel new];
    _label1.backgroundColor = [UIColor yellowColor];
    _label1.text = @"label,";
    
    _label2 = [UILabel new];
    _label2.backgroundColor = [UIColor greenColor];
    _label2.text = @"label,";
    
    [_contentView1 addSubview:_label1];
    [_contentView1 addSubview:_label2];
    
    // lable1 位于左上角
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView1).offset(5);
        make.left.equalTo(self.contentView1).offset(10);
       
        
        make.height.equalTo(40);
    }];
    
    // lable2 位于右上角
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView1).offset(5);
        make.left.equalTo(self.label1.mas_right).offset(10);
        //右边的间隔保持大于等于2，注意是lessThanOrEqual
        //这里的“lessThanOrEqualTo”放在从左往右的X轴上考虑会更好理解。
        //即：label2的右边界的X坐标值“小于等于”containView的右边界的X坐标值。
        make.right.lessThanOrEqualTo(self.contentView1.mas_right).offset(-2);
        make.height.equalTo(40);
    }];
    
    //设置label1的content hugging 为1000
    [_label1 setContentHuggingPriority:UILayoutPriorityRequired
                               forAxis:UILayoutConstraintAxisHorizontal];
    
    //设置label1的content compression 为1000 ()
    [_label1 setContentCompressionResistancePriority:UILayoutPriorityRequired
                                             forAxis:UILayoutConstraintAxisHorizontal];
    
    //设置右边的label2的content hugging 为1000
    [_label2 setContentHuggingPriority:UILayoutPriorityDefaultLow
                               forAxis:UILayoutConstraintAxisHorizontal];
    
    //设置右边的label2的content compression 为250
    [_label2 setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                             forAxis:UILayoutConstraintAxisHorizontal];
}

- (NSString *)getLabelContentWithCount:(NSUInteger)count {
    NSMutableString *ret = [NSMutableString new];
    
    for (NSUInteger i = 0; i <= count; i++) {
        [ret appendString:@"label,"];
    }
    
    return ret.copy;
}

@end
