//
//  DocumentInteractionViewController.h
//  OpenFile
//
//  Created by 郑文明 on 15/12/28.
//  Copyright © 2015年 郑文明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocumentInteractionViewController : UIViewController<UIDocumentInteractionControllerDelegate,UIAlertViewDelegate>
@property(nonatomic,strong) UIDocumentInteractionController *documentInteractionController;



- (void)openFileWithURL:(NSURL *)URL;

@end
