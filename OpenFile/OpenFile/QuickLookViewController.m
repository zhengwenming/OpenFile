
//
//  QuickLookViewController.m
//  OpenFile
//
//  Created by 郑文明 on 15/12/28.
//  Copyright © 2015年 郑文明. All rights reserved.
//

#import "QuickLookViewController.h"

@interface QuickLookViewController ()

@end

@implementation QuickLookViewController
@synthesize previewController = _previewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"附件预览";
    _previewController = [[QLPreviewController alloc] init];
    _previewController.dataSource = self;
    _previewController.delegate = self;
    
    _previewController.view.frame = CGRectMake(0, 64, self.view.frame.size.width , self.view.frame.size.height);
    _previewController.currentPreviewItemIndex = 0;
        [self addChildViewController:_previewController];
    [self.view addSubview:_previewController.view];
    [_previewController reloadData];
    
    
}
- (id <QLPreviewItem>) previewController: (QLPreviewController *) controller previewItemAtIndex: (NSInteger) index{
    return self.fileURL;
}
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
