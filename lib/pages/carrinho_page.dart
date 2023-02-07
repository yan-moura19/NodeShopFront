import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CarrinhoPage extends StatelessWidget {
  
  
  
  CarrinhoPage({super.key, required this.carrinho, this.string, required String this.nomeUser});

  final List<dynamic> carrinho;
  final String? string;
  final String? nomeUser;
  
 
  

  @override
  Widget build(BuildContext context) {
    double valor = 0;
    for(var val in carrinho){
      //print(val['preco']);
      valor = valor + double.parse( val['preco']);
    }
    //print(valor);
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        backgroundColor: Color.fromARGB(255, 8, 39, 87),
        actions: [
          
        
        SizedBox(width: 30,)
        
        ],
      ),
      body: Column(children: <Widget>[
        Text("ITENS",
        textAlign: TextAlign.end, 
        
        style:  GoogleFonts.inter(
                  color:  Color.fromARGB(255, 8, 39, 87),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  
                  )
                  ),
        Expanded(child: MinhaLista(carrinho: carrinho)) ,
        Text("TOTAL: ${valor} REAIS",
        style:  GoogleFonts.inter(
                  color:  Color.fromARGB(255, 8, 39, 87),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  
                  )),
                  ButtonBar(
                    children: [
                      TextButton(onPressed: () => {
                         showAlertDialog1(context, valor,),
                         postCompra(valor, carrinho)
                         }, child: Text("Finalizar compra")),

                    ],
                  )
        
        

      ],
      mainAxisAlignment: MainAxisAlignment.start,)
      
      

        
      );
  }
  postCompra(valor, carrinho) async{
    var url = Uri.parse('http://localhost:3030/compra');
    final encoding = Encoding.getByName('utf-8');
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var body = jsonEncode(<String, String>{
      'usuario' : 'YanApp',
      'produtos': jsonEncode(carrinho),
      'valor': '105',
    });
    var response = await http.post(url, body: body, encoding: encoding, headers: headers
    );
    if(response.statusCode == 200){
      print("Compra efetuada");
      
      
    }else{
      throw Exception('Não foi possivel finalizar a compra');
    }
  }
  
  showAlertDialog1(BuildContext context, double valor)
{ 
    // configura o button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () { Navigator.of(context).pop(); },
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("Compra"),
    content: Text("Compra no valor de ${valor} efetuada"),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}
}
class MinhaLista extends StatelessWidget {
  
  final List<dynamic> carrinho;
  const MinhaLista({super.key, required this.carrinho});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: carrinho.length,
        itemBuilder: (context, index) {
          final produto = carrinho[index];
          return Card( child: ListTile(
                  
                  onTap: (() {
                    // print(produto);
                  }) ,
                  leading: CircleAvatar(backgroundImage: NetworkImage(produto['imagem'])
                  ),
                  title: Text(produto['nome']),
                  subtitle:  Row(
                    children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('Categoria: '),
                                Text(produto['categoria']),
                                

                              ],
                              
                            ),
                            Row(
                              children: [
                                Text('Preco: '),
                                Text( produto['preco']),

                              ],
                             
                            )

                          ],
                          
                        ),
                       
                      SizedBox(width: 20),
                      


                      
                      
                      

                    ],
                    
                    
                    
                  ),
                 
                  
                )
          );
          
          
        });
  }
  
}