//
//  ViewController.m
//  HowMuchCoin
//
//  Created by Mikhail on 21.02.2025.
//

#import "ViewController.h"
#import "NetworkAPI.h"
@interface ViewController () 
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton *button;

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    [self setupUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) fetchData {
    NSString *coin = [self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (coin.length == 0) {
        self.label.text = @"Enter a coin name";
        return;
    }
    [[NetworkAPI sharedManager] fetchCostCoin:coin completion:^(NSString *cost) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.label.text = [NSString stringWithFormat:@"$%@", cost];
        });
    }];
}

- (void)setupUI {
    CGFloat width = self.view.frame.size.width;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
    self.titleLabel.text = @"How much coin?";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    [self.view addSubview:self.titleLabel];

    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, width - 100, 40)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.placeholder = @"Enter coin (e.g., litecoin)";
    self.textField.delegate = self;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.textField];

    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.frame = CGRectMake(50, 0, width - 100, 40);
    self.button.backgroundColor = [UIColor systemBlueColor];
    self.button.layer.cornerRadius = 10;
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button setTitle:@"Get Price" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];

    self.label = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, width - 100, 40)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text = @"Waiting for data...";
    self.label.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.label];

    CGFloat centerY = self.view.center.y - 80;
    self.titleLabel.center = CGPointMake(self.view.center.x, centerY - 80);
    self.textField.center = CGPointMake(self.view.center.x, centerY);
    self.button.center = CGPointMake(self.view.center.x, centerY + 60);
    self.label.center = CGPointMake(self.view.center.x, centerY + 120);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
