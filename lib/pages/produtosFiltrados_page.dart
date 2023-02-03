import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:nodeshop_front/pages/carrinho_page.dart';
late final List<dynamic> carrinho;
  late final List<dynamic> produtosFiltrados;
  late final String? filtro;
  late final String? nomeUser;

class ProdutoFiltradoPage extends StatelessWidget {
  
  
  
  ProdutoFiltradoPage({super.key, required this.carrinho,required this.produtosFiltrados, this.filtro, required String this.nomeUser});

  final List<dynamic> carrinho;
  final List<dynamic> produtosFiltrados;
  final String? filtro;
  final String? nomeUser;
  
 
  

  @override
  Widget build(BuildContext context) {
    
    //print(valor);
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtrados'),
        backgroundColor: Color.fromARGB(255, 8, 39, 87),
        actions: [
          IconButton(onPressed: () => {Navigator.push(context, MaterialPageRoute(
            builder: (context) => CarrinhoPage(carrinho: carrinho, nomeUser: '${nomeUser}',string: nomeUser) ,
          ),)}, icon: const Icon(Icons.shopping_cart)),
          
        
        SizedBox(width: 30,)
        
        ],
      ),
      body: Column(children: <Widget>[
        Text("${produtosFiltrados.length >0? 'Produtos filtrados por $filtro':'Não foi encontrado produto'}",
        textAlign: TextAlign.start, 
        
        style:  GoogleFonts.inter(
                  color:  Color.fromARGB(255, 8, 39, 87),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  
                  )
                  ),
        Expanded(child: 
        ListView.builder(
        itemCount: produtosFiltrados.length,
        itemBuilder: (context, index) {
          final produto = produtosFiltrados[index];
          return Card( child: ListTile(
                  
                  onTap: (() {
                    print(produto);
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
                      
                      TextButton(
                        
                        onPressed: () {
                          carrinho.add(produto);
                          showAlertDialog1(context, produto['nome']);
                           
                          
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 20),
                          textStyle: TextStyle(
                            fontSize: 16, height: 1.2),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))
                        ),
                        child: Text('Adicionar ao carrinho')),
                      


                      
                      
                      

                    ],
                    
                    
                    
                  ),
                 
                  
                )
          );
          
          
        })
        
        ) ,

      ],
      mainAxisAlignment: MainAxisAlignment.start,)
      
      

        
      );
  }
  
 showAlertDialog1(BuildContext context, String nome) 
{ 
    // configura o button
  Widget okButton = TextButton(
    child: Text("CONTINUAR COMPRANDO"),
    onPressed: () { Navigator.of(context).pop(); },
  );
  Widget irParaCarrinho = TextButton(
    child: Text("ir para carrinho"),
    onPressed: () { Navigator.push(context, MaterialPageRoute(
            builder: (context) => CarrinhoPage(carrinho: carrinho, nomeUser: '${nomeUser}',string: nomeUser) ,
          ),); },
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("Aviso"),
    content: Text("${nome} foi adicionado ao carrinho"),
    actions: [
      irParaCarrinho,
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
  
// }
// class MinhaLista extends StatelessWidget {
  
//   final List<dynamic> produtosFiltrados;
//   const MinhaLista({super.key, required this.produtosFiltrados });

//   @override
//   Widget? build(BuildContext context) {
//     return null;
//   }
//   showAlertDialog1(BuildContext context, String nome) 
// { 
//     // configura o button
//   Widget okButton = TextButton(
//     child: Text("CONTINUAR COMPRANDO"),
//     onPressed: () { Navigator.of(context).pop(); },
//   );
//   Widget irParaCarrinho = TextButton(
//     child: Text("ir para carrinho"),
//     onPressed: () { Navigator.push(context, MaterialPageRoute(
//             builder: (context) => CarrinhoPage(carrinho: carrinho, nomeUser: '${nomeUser}',string: nomeUser) ,
//           ),); },
//   );
//   // configura o  AlertDialog
//   AlertDialog alerta = AlertDialog(
//     title: Text("Aviso"),
//     content: Text("${nome} foi adicionado ao carrinho"),
//     actions: [
//       irParaCarrinho,
//       okButton,
      
//     ],
//   );
//   // exibe o dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alerta;
//     },
//   );
// }
  
// }