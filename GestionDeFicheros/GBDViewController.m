//
//  GBDViewController.m
//  GestionDeFicheros
//
//  Created by 	Gonzalo on 10/19/13.
//  Copyright (c) 2013 Gonzalo. All rights reserved.
//

#import "GBDViewController.h"

@interface GBDViewController ()

@end

@implementation GBDViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction for view controller

- (IBAction)readFile:(id)sender {
#ifndef NDEBUG
    NSLog(@"%s (line:%d)", __PRETTY_FUNCTION__, __LINE__);
#endif
    
    NSString *ruta = [[NSBundle mainBundle] pathForResource:@"plantilla"
                                                        ofType:@"txt"];
    
    NSError *error = [[NSError alloc] init];
    
    NSString *text = [NSString stringWithContentsOfFile:ruta
                                               encoding:NSUTF8StringEncoding
                                                  error:&error];
    if ([error code]!=0){
        [_txLbl setText:[error localizedDescription]];
    } else{
        [_txLbl setText:text];
        /*también vale hacerlo así
         _txLbl.text = text*/
    }
}

- (IBAction)addPhoto:(id)sender {
#ifndef NDEBUG
    NSLog(@"%s (line:%d)", __PRETTY_FUNCTION__, __LINE__);
#endif
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Opciones"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancelar"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Camara", @"Librería", nil];
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
#ifndef NDEBUG
    NSLog(@"%s (line:%d) clicked %i", __PRETTY_FUNCTION__, __LINE__, buttonIndex);
#endif
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    
    NSString *requiredType;
    requiredType = (NSString *)kUTTypeImage;
        
    picker.mediaTypes = @[requiredType];
    picker.allowsEditing = YES;

    
    if (buttonIndex == 0){//camara
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;        
        [self presentViewController:picker animated:YES completion:nil];
        
    } else if (buttonIndex == 1) {//librería
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
        
    } else {
        [_txLbl setText:@"No sé que has presionado"];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        UIImage *pickedImg = [info objectForKey:UIImagePickerControllerEditedImage];
        [_cameraImageView setImage:pickedImg];
        
        //Guardar en disco
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
        
        
        NSString *path = [NSString stringWithFormat:@"%@/%.f%@",
                          [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSAllDomainsMask], timestamp, @"nombre_imagen.jpg"];
        [fileManager createFileAtPath:path
                             contents:UIImageJPEGRepresentation(pickedImg, 1.0)
                           attributes:nil];
#ifndef NDEBUG
        NSLog(@"%s (line:%d) %@", __PRETTY_FUNCTION__, __LINE__, path);
#endif
        
    } else {
        [_txLbl setText:@"No he recibido una imagen válida"];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

@end
