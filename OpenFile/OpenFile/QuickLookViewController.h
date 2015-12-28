//
//  QuickLookViewController.h
//  OpenFile
//
//  Created by 郑文明 on 15/12/28.
//  Copyright © 2015年 郑文明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>

@interface QuickLookViewController : UIViewController<QLPreviewControllerDataSource,
QLPreviewControllerDelegate>
@property (nonatomic,strong) QLPreviewController *previewController;
@property (nonatomic,retain)NSURL *fileURL;

@end
