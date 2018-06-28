//
//  TvAddProductScreen.m
//  Tradologie
//
//  Created by Chandresh Maurya on 06/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "TvAddProductScreen.h"
#import "Constant.h"
#import "AppConstant.h"
#import "CommonUtility.h"
#import "MBDataBaseHandler.h"
#import "SharedManager.h"
#import "MBAPIManager.h"
#import "VcNegotiationDetail.h"
#import <AFNetworking/AFHTTPSessionManager.h>

@interface TvAddProductScreen ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSMutableArray *arrCategoryList, *arrCategoryID, *arrPackingTypeID, *arrPackingSizeID , *arrGradeID ,*arrAttribute2ID,*arrAttribute1ID;
    NSMutableArray *arrCategoryType , *arrItemUnit , *arrPackingType, *arrPackingSize, *arrProductType, *arrQuantity;
    NSString *selectedCategoryID, *strPackingID, *strPackingSizeID , *strGradeID , *strAttribute2ID, *strAttribute1ID;
    NSData *imageDatatoUpload;
    NSString *strUploadImage;
}
@end

@implementation TvAddProductScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setNavigationTittleWithLogo:@"Add Product"];
    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBounces:NO];
    
    [self.navigationItem SetBackButtonWithID:self withSelectorAction:@selector(btnBackItemtapped:)];
    
    [txtProductName setAdditionalInformationTextfieldStyle:@"--Select Product Name--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:0];
    [txtGrade setAdditionalInformationTextfieldStyle:@"--Select Grade--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:1];
    [txtQuality setAdditionalInformationTextfieldStyle:@"--Select Quality--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:2];
    [txtProductType setAdditionalInformationTextfieldStyle:@"--Select Product Type--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:3];
    [txtProductUnit setAdditionalInformationTextfieldStyle:@"--Select Product Unit--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:4];
    [txtPackingType setAdditionalInformationTextfieldStyle:@"--Select Packing Type--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:5];
    [txtPackingSize setAdditionalInformationTextfieldStyle:@"--Select Packing Size--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:6];
    
    [txtTotalQty setDefaultTextfieldStyleWithPlaceHolder:@"Total Quantity" withTag:11];
    [txtSpecification setDefaultTextfieldStyleWithPlaceHolder:@"Please Enter Other Specifications,if any." withTag:12];
    
    [btnImagePickUp addTarget:self action:@selector(btnImageUploadTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btnSubmit addTarget:self action:@selector(btnSubmitProductTapped:) forControlEvents:UIControlEventTouchUpInside];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW DATASOURCE & DELEGATE ❉===❉===
/*****************************************************************************************************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return _viewFooter;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== BUTTON ACTION EVENT CALLED HERE ===❉===❉
/*****************************************************************************************************************/
-(IBAction)btnBackItemtapped:(UIButton *)sender
{
    [self.navigationItem setNavigationTittleWithLogo:@"tradologie.com"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        RootViewController * rootVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
        AppDelegate *delegateClass = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        [delegateClass setRootViewController:rootVC];
    });
}

-(IBAction)btnDropMethodTaped:(UIButton *)sender
{
    if (sender.tag ==0)
    {
        [self getAllCategorylistfromDatabase];
        [self showPopUpWithData:sender];
    }
    else if (sender.tag == 1)
    {
        if (arrCategoryType.count > 0)
        {
            [self showPopUpWithData:sender];
        }
    }
    else if (sender.tag == 2)
    {
        if (arrQuantity.count > 0)
        {
            [self showPopUpWithData:sender];
        }
    }
    else if (sender.tag == 3)
    {
        if (arrProductType.count > 0)
        {
            [self showPopUpWithData:sender];
        }
    }
    
    else if (sender.tag == 4)
    {
        if (arrItemUnit.count > 0)
        {
            [self showPopUpWithData:sender];
        }
    }
    else if (sender.tag == 5)
    {
        if (arrPackingType.count > 0)
        {
            [self showPopUpWithData:sender];
        }
        else
        {
            [arrPackingType addObject:@"Not Applicable"];
             [self showPopUpWithData:sender];
        }
    }
    else if (sender.tag == 6)
    {
        if (arrPackingSize.count > 0)
        {
            [self showPopUpWithData:sender];
        }
        else
        {
            [arrPackingSize addObject:@"Not Applicable"];
             [self showPopUpWithData:sender];
        }
    }
}

-(IBAction)btnSubmitProductTapped:(UIButton *)sender
{
    BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
    AuctionDetailForEdit *data = [MBDataBaseHandler getAuctionDetailForEditNegotiation];
    
    NSMutableDictionary *dicParams = [[NSMutableDictionary alloc]init];
    [dicParams setValue:objBuyerdetail.detail.APIVerificationCode forKey:@"Token"];
    [dicParams setValue:objBuyerdetail.detail.CustomerID forKey:@"CustomerID"];
    [dicParams setValue:data.detail.AuctionID forKey:@"AuctionID"];
    [dicParams setValue:selectedCategoryID forKey:@"GroupID"];
    [dicParams setValue:strGradeID forKey:@"CategoryID"];
    [dicParams setValue:strAttribute1ID forKey:@"AttributeValue1"];
    [dicParams setValue:strAttribute2ID forKey:@"AttributeValue2"];
    [dicParams setValue:txtProductUnit.text forKey:@"Unit"];
    [dicParams setValue:strPackingID forKey:@"PackingTypeID"];
    [dicParams setValue:strPackingSizeID forKey:@"PackingSizeID"];
    [dicParams setValue:txtGrade.text forKey:@"CustomCategory"];
    [dicParams setValue:txtTotalQty.text forKey:@"Qty"];
    [dicParams setValue:txtSpecification.text forKey:@"Note"];
    
    
    if (SharedObject.isNetAvailable)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        
        MBCall_AddAuctionItemProductAPI(dicParams, ^(id response, NSString *error, BOOL status)
       {
           [CommonUtility HideProgress];
           
           if (status && [[response valueForKey:@"success"]isEqual:@1])
           {
               if (response != (NSDictionary *)[NSNull null])
               {
                  
                   NSString *strAuctionTransID = [NSString stringWithFormat:@"%@",[response valueForKey:@"AuctionTranID"]];
                   NSMutableDictionary *dicImage = [[NSMutableDictionary alloc]init];
                   [dicImage setValue:self->strUploadImage forKey:@"Image"];
                   [dicImage setValue:strAuctionTransID forKey:@"AuctionTranID"];
                   [dicImage setValue:@"image/jpeg" forKey:@"ContentType"];
                   
                   
                   MBCall_AddPackingImageUploadAPI(dicImage, self->imageDatatoUpload, ^(id response, NSString *error, BOOL status)
                   {
                       if (status && [[response valueForKey:@"success"]isEqual:@1])
                       {
                           if (response != (NSDictionary *)[NSNull null])
                           {
                               
                           }
                       }
                   });
                   
                   [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
                   
                   VcNegotiationDetail *objScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"VcNegotiationDetail"];
                   objScreen.isfromViewEnquiry =  NO;
                   objScreen.AuctionID = [data.detail.AuctionID stringValue];
                   [self.navigationController pushViewController:objScreen animated:YES];

               }
           }
           else
           {
               [CommonUtility HideProgress];
               [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:error];
           }
       });
    }
    else
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
}


-(IBAction)btnImageUploadTapped:(UIButton *)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Choose Packing Image" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *pickerView =[[UIImagePickerController alloc]init];
            pickerView.allowsEditing = YES;
            pickerView.delegate = self;
            pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:pickerView animated:YES completion:nil];
        }
        else
        {
            
        }
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
        pickerView.allowsEditing = YES;
        pickerView.delegate = self;
        [pickerView setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:pickerView animated:YES completion:nil];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    dispatch_async(dispatch_get_main_queue(), ^ {
        [self presentViewController:actionSheet animated:YES completion:nil];
    });
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== UI-IMAGE PICKER DELEGATE CALLED ===❉===❉
/******************************************************************************************************************/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:true completion:nil];
    
    UIImage * img = [info valueForKey:UIImagePickerControllerEditedImage];
    strUploadImage = [CommonUtility saveImageTODocumentAndGetPath:img];

    imageDatatoUpload = UIImageJPEGRepresentation(img, 0);
   // strUploadImage = [imageDatatoUpload base64EncodedStringWithOptions:0];
   // NSLog(@"%@",strUploadImage);
    if(img != nil)
    {
        [btnImagePickUp setImage:img forState:UIControlStateNormal];
    }
    else
    {
        
    }
    
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== GET CATEGORIES FROM DATABASE ===❉===❉
/******************************************************************************************************************/
-(void)getAllCategorylistfromDatabase
{
    ProductCategory *categoryList = [MBDataBaseHandler getAllProductCategories];
    
    arrCategoryList = [[NSMutableArray alloc]init];
    arrCategoryID = [[NSMutableArray alloc]init];
    
    for (NSMutableDictionary *dic in categoryList.detail)
    {
        [arrCategoryID addObject:[dic valueForKey:@"GroupID"]];
        [arrCategoryList addObject:[dic valueForKey:@"GroupName"]];
    }
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== SHOW POPUP DATA HERE ===❉===❉
/******************************************************************************************************************/
-(void)showPopUpWithData:(UIView *)viewtoShow
{
    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor colorWithRed:29.0f/255.0f green:65.0f/255.0f blue:106.0f/255.0f alpha:.30f]];
    
    if (viewtoShow.tag == 0)
    {
        [CommonUtility showPopUpWithData:viewtoShow withArray:arrCategoryList withCompletion:^(NSInteger response)
        {
            [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
            [self->txtProductName setText:[self->arrCategoryList objectAtIndex:response]];
            self->selectedCategoryID = [NSString stringWithFormat:@"%@",[self->arrCategoryID objectAtIndex:response]];
            [self getDetailCategoryWithCategoryID:self->selectedCategoryID];
            
        } withDismissBlock:^{
            [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
        }];
    }
    else if (viewtoShow.tag == 1)
    {
        [CommonUtility showPopUpWithData:viewtoShow withArray:self->arrCategoryType withCompletion:^(NSInteger response)
         {
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
             [self->txtGrade setText:[NSString stringWithFormat:@"%@",[self->arrCategoryType objectAtIndex:response]]];
             self->strGradeID = [NSString stringWithFormat:@"%@",[self->arrGradeID objectAtIndex:response]];
             [self.tableView reloadData];
         } withDismissBlock:^{
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
         }];
    }
    else if (viewtoShow.tag == 2)
    {
        [CommonUtility showPopUpWithData:viewtoShow withArray:self->arrQuantity withCompletion:^(NSInteger response)
         {
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
             [self->txtQuality setText:[NSString stringWithFormat:@"%@",[self->arrQuantity objectAtIndex:response]]];
             self->strAttribute1ID = [NSString stringWithFormat:@"%@",[self->arrAttribute1ID objectAtIndex:response]];

             [self.tableView reloadData];
         } withDismissBlock:^{
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
         }];
    }
    
    else if (viewtoShow.tag == 3)
    {
        [CommonUtility showPopUpWithData:viewtoShow withArray:self->arrProductType withCompletion:^(NSInteger response)
         {
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
             [self->txtProductType setText:[NSString stringWithFormat:@"%@",[self->arrProductType objectAtIndex:response]]];
             self->strAttribute2ID = [NSString stringWithFormat:@"%@",[self->arrAttribute2ID objectAtIndex:response]];

             [self.tableView reloadData];
         } withDismissBlock:^{
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
         }];
    }
    else if (viewtoShow.tag == 4)
    {
        [CommonUtility showPopUpWithData:viewtoShow withArray:self->arrItemUnit withCompletion:^(NSInteger response)
         {
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
             [self->txtProductUnit setText:[NSString stringWithFormat:@"%@",[self->arrItemUnit objectAtIndex:response]]];
             [self.tableView reloadData];
         } withDismissBlock:^{
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
         }];
    }
    else if (viewtoShow.tag == 5)
    {
        [CommonUtility showPopUpWithData:viewtoShow withArray:self->arrPackingType withCompletion:^(NSInteger response)
         {
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
             [self->txtPackingType setText:[NSString stringWithFormat:@"%@",[self->arrPackingType objectAtIndex:response]]];
             if (self->arrPackingTypeID.count >0)
             {
                 self->strPackingID = [NSString stringWithFormat:@"%@",[self->arrPackingTypeID objectAtIndex:response]];

             }
             [self.tableView reloadData];
         } withDismissBlock:^{
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
         }];
    }
    else if (viewtoShow.tag == 6)
    {
        [CommonUtility showPopUpWithData:viewtoShow withArray:self->arrPackingSize withCompletion:^(NSInteger response)
         {
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
             [self->txtPackingSize setText:[NSString stringWithFormat:@"%@",[self->arrPackingSize objectAtIndex:response]]];
             self->strPackingSizeID = [NSString stringWithFormat:@"%@",[self->arrPackingSizeID objectAtIndex:response]];
             [self.tableView reloadData];
         } withDismissBlock:^{
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
         }];
    }
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== TEXTFIELD DELEGATE CALLED HERE ===❉===❉
/*****************************************************************************************************************/
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == txtTotalQty || txtTotalQty.isEditing )
    {
         return YES;
    }
    else if (textField == txtSpecification || txtSpecification.isEditing)
    {
        return YES;
    }
    [textField resignFirstResponder];
    return NO;
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== GET ALL CATEGORY API CALLED HERE ===❉===❉
/******************************************************************************************************************/
-(void)getDetailCategoryWithCategoryID:(NSString *)GroupID
{
    BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
    NSMutableDictionary *dicParams = [[NSMutableDictionary alloc]init];
    [dicParams setValue:objBuyerdetail.detail.APIVerificationCode forKey:@"Token"];
    [dicParams setValue:GroupID forKey:@"GroupID"];
    
    if (SharedObject.isNetAvailable)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        
        MBCall_GetAuctionItemDetailAccordingtoCategoryID(dicParams, ^(id response, NSString *error, BOOL status)
        {
            if (status && [[response valueForKey:@"success"]isEqual:@1])
            {
                [CommonUtility HideProgress];
                if (response != (NSDictionary *)[NSNull null])
                {
                    NSError *error;
                    CategoryDetail *objCategoryItem = [[CategoryDetail alloc]initWithDictionary:response error:&error];
                    [MBDataBaseHandler saveCategoryDetailItemListWithData:objCategoryItem];
                    
                    self->arrCategoryType = [[NSMutableArray alloc]init];
                    self->arrQuantity = [[NSMutableArray alloc]init];
                    self->arrProductType = [[NSMutableArray alloc]init];
                    self->arrItemUnit = [[NSMutableArray alloc]init];
                    self->arrPackingSize = [[NSMutableArray alloc]init];
                    self->arrPackingType = [[NSMutableArray alloc]init];
                    self->arrPackingSizeID = [[NSMutableArray alloc]init];
                    self->arrPackingTypeID = [[NSMutableArray alloc]init];
                    self->arrGradeID = [[NSMutableArray alloc]init];
                    self->arrAttribute1ID = [[NSMutableArray alloc]init];
                    self->arrAttribute2ID = [[NSMutableArray alloc]init];

                    for (CategoryItemList *objlist in objCategoryItem.detail.CategoryList)
                    {
                        [self->arrGradeID addObject:objlist.CategoryID];
                        [self->arrCategoryType addObject:objlist.CategoryName];
                    }
                    for (Attribute1List *objlist in objCategoryItem.detail.Attribute1List)
                    {
                        [self->arrQuantity addObject:objlist.AttributeValue];
                        [self->arrAttribute1ID addObject:objlist.AttributeValueID];

                    }
                    for (Attribute2List *objlist in objCategoryItem.detail.Attribute2List)
                    {
                        [self->arrProductType addObject:objlist.AttributeValue];
                        [self->arrAttribute2ID addObject:objlist.AttributeValueID];

                    }
                    for (ItemUnitList *objlist in objCategoryItem.detail.ItemUnitList)
                    {
                        [self->arrItemUnit addObject:objlist.UnitName];
                    }
                    for (PackingSizeList *objlist in objCategoryItem.detail.PackingSizeList)
                    {
                        [self->arrPackingSize addObject:objlist.PackingSizeValue];
                         [self->arrPackingSizeID addObject:objlist.PackingSizeID];
                    }
                    for (PackingTypeList *objlist in objCategoryItem.detail.PackingTypeList)
                    {
                        [self->arrPackingType addObject:objlist.PackingValue];
                        [self->arrPackingTypeID addObject:objlist.PackingTypeID];

                    }
                    [self.tableView reloadData];
                }
                else{
                    
                }
            }
            else
            {
                [CommonUtility HideProgress];
                
            }
            
        });
    }
    else
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
}
@end
