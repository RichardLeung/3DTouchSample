//
//  ViewController.m
//  3DTouchSample
//
//  Created by RichardLeung on 15/10/31.
//  Copyright © 2015年 RL. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIViewControllerPreviewingDelegate>

@property(nonatomic,strong)UITableView *tableViewList;
@property(nonatomic,strong)NSArray *arrayData;

@end

@implementation ViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initDefaultData];
    [self createTableView];
    [self registerPreview];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shortCut) name:@"ShortCut" object:nil];
    [self shortCut];
}

-(void)shortCut{
    if ([_shortcutName length]>0) {
        [self.navigationController popToViewController:self animated:NO];
        DetailViewController *detailVC =[[DetailViewController alloc]initWithTitle:self.shortcutName];
        [self.navigationController pushViewController:detailVC animated:NO];
    }
}

-(void)registerPreview{
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:self sourceView:self.tableViewList];
    }
    else {
        NSLog(@"该设备不支持3D-Touch");
    }
}

-(void)createTableView{
    _tableViewList =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _tableViewList.delegate =self;
    _tableViewList.dataSource =self;
    _tableViewList.tableFooterView =[[UIView alloc]init];
    [self.view addSubview:_tableViewList];
    [_tableViewList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
}

-(void)initDefaultData{
    self.title =@"复仇者联盟";
    self.arrayData =@[@"钢铁侠",@"雷神",@"黑寡妇",@"美国队长"];
}

#pragma mark - UIViewControllerPreviewingDelegate

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    NSIndexPath * indexPath =[_tableViewList indexPathForRowAtPoint:location];
    
    UITableViewCell * cell = [_tableViewList cellForRowAtIndexPath:indexPath];
    if (!cell) {
        return nil;
    }
    DetailViewController *detailVC =[[DetailViewController alloc]initWithTitle:[_arrayData objectAtIndex:indexPath.row]];
    detailVC.preferredContentSize = CGSizeMake(0, 0);
    previewingContext.sourceRect = cell.frame;
    return detailVC;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self.navigationController pushViewController:viewControllerToCommit animated:NO];
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text =[_arrayData objectAtIndex:indexPath.row];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC =[[DetailViewController alloc]initWithTitle:[_arrayData objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
