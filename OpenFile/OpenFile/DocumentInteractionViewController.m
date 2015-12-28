
//
//  DocumentInteractionViewController.m
//  OpenFile
//
//  Created by 郑文明 on 15/12/28.
//  Copyright © 2015年 郑文明. All rights reserved.
//

#import "DocumentInteractionViewController.h"

@interface DocumentInteractionViewController ()
{
    NSURL *_fileURL;
    BOOL _isPreview;
    BOOL _isOpenInMenu;
}
@end

@implementation DocumentInteractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationController.navigationBarHidden = YES;

}
- (void)openFileWithURL:(NSURL *)URL
{
    NSLog(@"now open %@",URL);
    if (URL) {
        _fileURL = URL;
        _isPreview = NO;
        _isOpenInMenu = NO;
        // Initialize Document Interaction Controller
        self.documentInteractionController = [UIDocumentInteractionController
                                              interactionControllerWithURL:URL];
        // Configure Document Interaction Controller
        self.documentInteractionController.delegate = self;
        // Preview File
        [self.documentInteractionController presentPreviewAnimated:YES];
        
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkPreview) userInfo:nil repeats:NO];
    }
}

- (void)checkPreview
{
    if(_isPreview == NO)
    {
        if (_fileURL) {
            // Initialize Document Interaction Controller
            self.documentInteractionController = [UIDocumentInteractionController
                                                  interactionControllerWithURL:_fileURL];
            // Configure Document Interaction Controller
            self.documentInteractionController.delegate = self;
            // Present Open In Menu
            [self.documentInteractionController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
            
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkOpenInMenu) userInfo:nil repeats:NO];
        }
    }
}

- (void)checkOpenInMenu{
    if(_isOpenInMenu == NO)
    {
        [self showWarning];
        [[UIApplication sharedApplication]openURL:_fileURL];
    }
}

- (void)showWarning{
    NSString *fileType = [[_fileURL.absoluteString componentsSeparatedByString:@"."]lastObject];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"出错提示" message:[NSString stringWithFormat:@"不支持%@格式，请下载相关播放器打开",fileType] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}

// Preview presented/dismissed on document.  Use to set up any HI underneath.
- (void)documentInteractionControllerWillBeginPreview:(UIDocumentInteractionController *)controller{
    controller.name = @"附件预览";
    NSLog(@"willBeginPreview");
    _isPreview = YES;
}

- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller{
    NSLog(@"didEndPreview");
    [self.navigationController popViewControllerAnimated:YES];
}

// Options menu presented/dismissed on document.  Use to set up any HI underneath.
- (void)documentInteractionControllerWillPresentOptionsMenu:(UIDocumentInteractionController *)controller{
    NSLog(@"willPresentOptionsMenu");
}

- (void)documentInteractionControllerDidDismissOptionsMenu:(UIDocumentInteractionController *)controller{
    NSLog(@"didDismissOptionsMenu");
    
}

// Open in menu presented/dismissed on document.  Use to set up any HI underneath.
- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller{
    NSLog(@"willPresentOpenInMenu");
    _isOpenInMenu = YES;
}

- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller{
    NSLog(@"didDismissOpenInMenu");
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
