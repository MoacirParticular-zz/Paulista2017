//
//  CompartilharJogo_ViewController.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface CompartilharJogo_ViewController : UIViewController  {
}

@property BOOL mens;

@property (strong, nonatomic) NSString* data, *hora, *jogo;
@property (strong, nonatomic) IBOutlet UIImageView *imgView_Mandante;
@property (strong, nonatomic) IBOutlet UILabel *lbNomeMandante;
@property (strong, nonatomic) IBOutlet UILabel *lb_GolsMandante;
@property (strong, nonatomic) IBOutlet UILabel *lb_GolsVisitante;
@property (strong, nonatomic) IBOutlet UILabel *lb_NomeVisitante;
@property (strong, nonatomic) IBOutlet UIImageView *imgView_Visitante;

- (IBAction)cancelar:(id)sender;
- (IBAction)compartilhar:(id)sender;

@end
