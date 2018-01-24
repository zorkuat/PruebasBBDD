//
//  DiscosTableViewController.m
//  PruebasBBDD
//
//  Created by cice on 24/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import "DiscosTableViewController.h"
#import "Disco+CoreDataClass.h"
#import "BaseDatos.h"

@interface DiscosTableViewController ()

@property (nonatomic) NSArray *discos;

@end

@implementation DiscosTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /// Filtramos por el artista seleccionado a través de la propiedad 'publicaciones'
    /// Al hacer AllObjects nos lo convierte a un array ordenado.
    self.discos = [self.artista.publicaciones allObjects];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.discos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celdaDisco" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.discos[indexPath.row] titulo];
    cell.detailTextLabel.text = [self.discos[indexPath.row] genero];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)botonAnnadirDiscoPulsado:(id)sender
{
    UIAlertController *alerta = [UIAlertController alertControllerWithTitle:@"Nuevo Disco" message:@"introduce el nombre del disco" preferredStyle:UIAlertControllerStyleAlert];
    
    [alerta addTextFieldWithConfigurationHandler:nil];
    [alerta addTextFieldWithConfigurationHandler:nil];
    [alerta addAction:[UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        /// Aquí va codigo, señores.
        
        Disco *nuevoDisco = [NSEntityDescription insertNewObjectForEntityForName:@"Disco" inManagedObjectContext:[[BaseDatos instancia] moc]];
        
        nuevoDisco.titulo = alerta.textFields.firstObject.text;
        nuevoDisco.genero = alerta.textFields.lastObject.text;
        nuevoDisco.publicadoPor = self.artista;
        
        [[[BaseDatos instancia] moc] save:nil];
        
        self.discos = [self.artista.publicaciones allObjects];
        
        [self.tableView reloadData];
    }]];
    
    [alerta addAction:[UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alerta animated:true completion:nil];
}

@end
