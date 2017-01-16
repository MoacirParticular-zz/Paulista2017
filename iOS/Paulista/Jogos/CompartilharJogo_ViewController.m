//
//  CompartilharJogo_ViewController.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import "CompartilharJogo_ViewController.h"

@interface CompartilharJogo_ViewController ()

@end

@implementation CompartilharJogo_ViewController
@synthesize lb_GolsMandante, lb_GolsVisitante, lb_NomeVisitante, lbNomeMandante, data, hora, imgView_Mandante, imgView_Visitante, jogo, mens;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    NSLog(@"altura dos demonios: %f", self.view.frame.size.height);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    //   NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
//    //[FBSession.activeSession closeAndClearTokenInformation];
//    
//    [FBSession openActiveSessionWithPublishPermissions:nil defaultAudience:FBSessionDefaultAudienceEveryone allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
//    }];
//    
//    if (mens == YES) {
//        
//        [FBSession openActiveSessionWithPublishPermissions:[NSArray arrayWithObject:@"publish_stream"] defaultAudience:FBSessionDefaultAudienceEveryone allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
//            if (status == FBSessionStateOpen)
//            {
//                
//                mens = NO;
//                
//                NSMutableDictionary* params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                               @"https://itunes.apple.com/us/app/campeonato-paulista-2017/id597494005?l=pt&ls=1&mt=8", @"link",
//                                               @"http://www.blusistemas.com.br/icone_paulista.jpg", @"picture",
//                                               @"Campeonato Paulista 2017 para iPhone/iPod", @"name",
//                                               jogo, @"caption",
//                                               @"Baixe agora mesmo o aplicativo Campeonato Paulista 2017 para ter na ponta dos dedos as informações mais importantes da competição!", @"description",
//                                               [[alertView textFieldAtIndex:0] text], @"message",
//                                               nil];
//                
//                
//                [FBRequestConnection
//                 startWithGraphPath:@"me/feed"
//                 parameters:params
//                 HTTPMethod:@"POST"
//                 completionHandler:^(FBRequestConnection *connection,
//                                     id result,
//                                     NSError *error) {
//                     NSString *alertText;
//                     if (error) {
//                         alertText = [NSString stringWithFormat:
//                                      @"Não foi possível postar, tente novamente mais tarde."];
//                     } else {
//                         alertText = [NSString stringWithFormat:
//                                      @"Publicado com sucesso."];
//                     }
//                     // Show the result in an alert
//                     [[[UIAlertView alloc] initWithTitle:@"Resultado"
//                                                 message:alertText
//                                                delegate:nil
//                                       cancelButtonTitle:@"OK!"
//                                       otherButtonTitles:nil]
//                      show];
//                 }];
//                
//            }
//            
//        }];
//    }
//}

- (IBAction)compartilhar:(id)sender {
    
    mens = YES;
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Personalize" message:@"Digite sua mensagem" delegate:self cancelButtonTitle:@"Publicar" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alert show];
}

@end
