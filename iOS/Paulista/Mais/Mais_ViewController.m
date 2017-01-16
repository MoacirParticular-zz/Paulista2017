//
//  Mais_ViewController.m
//  Reaprendetia
//
//  Created by Moacir Ezequiel Lamego on 12/11/12.
//  Copyright (c) 2012 Mobiles App All rights reserved.
//
//

#import "Mais_ViewController.h"
#import "Mais_Celula.h"

@interface Mais_ViewController ()

@end

@implementation Mais_ViewController
@synthesize tabela;

#pragma mark - ****************** Table view data source ******************

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idCelula = @"idCelulaMais";
    Mais_Celula *celula = [tableView dequeueReusableCellWithIdentifier:idCelula];

    UIImage* img;
    

    switch (indexPath.row) {
        case 0:
            img = [UIImage imageNamed:@"app.png"];
            celula.icone.image = img;
            [celula.imageView setFrame:CGRectMake(20,6,20,30)];
            celula.titulo.text = @"Sobre o aplicativo";
            break;
            
        case 1:
            img = [UIImage imageNamed:@"avaliar.png"];
            celula.icone.image = img;
            [celula.imageView setFrame:CGRectMake(20,6,20,33)];
            celula.titulo.text = @"Avaliar o aplicativo";
            break;
            
        case 2:
            img = [UIImage imageNamed:@"indicar.png"];
            celula.icone.image = img;
            [celula.imageView setFrame:CGRectMake(20,6,30,28)];
            celula.titulo.text = @"Indicar o aplicativo";
            break;
            
        case 3:
            img = [UIImage imageNamed:@"mail.png"];
            celula.icone.image = img;
            [celula.imageView setFrame:CGRectMake(20,6,30,24)];
            celula.titulo.text = @"Contato";
            break;
            
        case 4:
            img = [UIImage imageNamed:@"divulg.png"];
            celula.icone.image = img;
            [celula.imageView setFrame:CGRectMake(20,6,58,30)];
            celula.titulo.text = @"Para anunciar";
            break;
            
        case 5:
            img = [UIImage imageNamed:@"logo_MA.png"];
            celula.icone.image = img;
            [celula.imageView setFrame:CGRectMake(20,6,58,30)];
            celula.titulo.text = @"Sobre a Mobiles App";
            break;
            
        default:
            break;
    }
    
    return celula;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    sobre_ViewController* sobre = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"idSobre"];

    switch (indexPath.row) {
        case 0:
            [sobre Iniciar:self _pathForResource:@"sobreApp" _ofType:@"html"];
            [self.navigationController pushViewController:sobre animated:YES];

            break;
            
        case 1:
            [self AvaliarEnvios:self];
            break;
            
        case 2:
            [self MandarEmail:self];
            break;
            
        case 3:
            [self MandarEmailErro:self];
            break;
            
        case 5:
            [sobre Iniciar:self _pathForResource:@"sobreMobilesApp" _ofType:@"html"];
            [self.navigationController pushViewController:sobre animated:YES];
            break;
            
        case 4:
            [self MandarEmailAnuncio:self];
            break;
        default:
            break;
    }
    
    [tabela deselectRowAtIndexPath:indexPath animated:YES];
}

-(IBAction)MandarEmailAnuncio:(id) sender {
    if([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController* meuView = [[MFMailComposeViewController alloc] init];
        meuView.mailComposeDelegate = sender;
        
        NSArray *detino = [[NSArray alloc] initWithObjects:@"contato@mobilesapp.com.br", nil];
        
        [meuView setToRecipients:detino];
        [meuView setSubject:@"Anúncio no Paulista 2017"];
        
        
        NSString* Linha1 = @"Olá, eu gostaria de obter mais informações sobre como anunciar no aplicativo Campeonato Paulista 2017 para iPhone";
        
        NSString* body =[NSString stringWithFormat:@"%@", Linha1];
        
        [meuView setMessageBody:body isHTML:YES];
        
        [sender presentModalViewController:meuView animated:YES];
    }
}

-(IBAction)MandarEmail:(id) sender {
    if([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController* meuView = [[MFMailComposeViewController alloc] init];
        meuView.mailComposeDelegate = sender;
        [meuView setSubject:@"Paulista 2017"];
        
        
        NSString* Linha1 = @"Olá, estou indicando o aplicativo Campeonato Paulista 2017 para iPhone, com ele você poderá acompanhar os Jogos e resultados, Classificação e a Artilharia.";
        NSString* Linha2 = @"Segue o link na AppStore.";
        NSString* Linha3 = @"Paulista 2017";
        
        NSString* body =[NSString stringWithFormat:@"<p>%@</p><p>%@</p><p><a href='https://itunes.apple.com/us/app/campeonato-paulista-2017/id597494005?l=pt&ls=1&mt=8'>%@ </a></p>", Linha1, Linha2, Linha3];
        
        [meuView setMessageBody:body isHTML:YES];
        
        [sender presentModalViewController:meuView animated:YES];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(IBAction)AvaliarEnvios:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/campeonato-paulista-2017/id597494005?l=pt&ls=1&mt=8"]];
}

-(IBAction)MandarEmailErro:(id) sender {
    if([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController* meuView = [[MFMailComposeViewController alloc] init];
        meuView.mailComposeDelegate = sender;
        
        NSArray *detino = [[NSArray alloc] initWithObjects:@"contato@mobilesapp.com.br", nil];
        
        [meuView setToRecipients:detino];
        [meuView setSubject:@"Contato app Paulista 2017"];
        
        
        NSString* Linha1 = @"Olá equipe do Campeonato Paulista 2017, o motivo do meu contato é: ";
        NSString* Linha2 = @"";
        NSString* Linha3 = @"";
        
        NSString* body =[NSString stringWithFormat:@"<p>%@</p><p>%@</p><p>%@</p>", Linha1, Linha2, Linha3];
        
        [meuView setMessageBody:body isHTML:YES];
        
        [sender presentModalViewController:meuView animated:YES];
    }
}
























#pragma -Mark ****************** Inicialização ******************

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTabela:nil];
    [super viewDidUnload];
}
@end
