//
//  GBDViewController.h
//  GestionDeFicheros
//
//  Created by 	Gonzalo on 10/19/13.
//  Copyright (c) 2013 Gonzalo. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreMedia/CoreMedia.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <UIKit/UIKit.h>
@interface GBDViewController : UIViewController <UIActionSheetDelegate,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *txLbl;
@property (weak, nonatomic) IBOutlet UIImageView *cameraImageView;

- (IBAction)readFile:(id)sender;
- (IBAction)addPhoto:(id)sender;
@end
