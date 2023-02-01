import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:nodeshop_front/pages/carrinho_page.dart';
import 'package:nodeshop_front/widgets/app_text.dart';


class ProdutosPage extends StatelessWidget {
   ProdutosPage({super.key, required this.nomeUser});
   final String? nomeUser;
   final _tCategoria = TextEditingController();

   var carrinho = [];

  
  @override
  Widget build(BuildContext context) {
    
    
    
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Olá ${nomeUser}'),
        backgroundColor: Color.fromARGB(255, 8, 39, 87),
        actions: [
          
        IconButton(onPressed: () => {Navigator.push(context, MaterialPageRoute(
            builder: (context) => CarrinhoPage(carrinho: carrinho, nomeUser: '${nomeUser}',string: nomeUser) ,
          ),)}, icon: const Icon(Icons.shopping_cart)),
        SizedBox(width: 30,),
        
        
        ],
      ),
      
      body: Column(
        children: [
          SizedBox(height: 20,),
          Row(
            children: [
              Flexible(
              child: TextField(
                              controller: _tCategoria,
                              decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Categoria',
                              
                              
                            ),
                            ),),
                            IconButton(onPressed:() => {print(_tCategoria.text)}, icon: const Icon(Icons.search))
                           
                      
                            
                            
                   

            ],
            
          ),
          
                   SizedBox(height: 20,),
          
          Expanded(child:  Container(
        child: FutureBuilder<dynamic>(
          future: getProdutos(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var produto = snapshot.data![index];
                return Card( child: ListTile(
                  
                  onTap: (() {
                    // print(carrinho.length);
                    
                  }) ,
                  leading: CircleAvatar(backgroundImage: NetworkImage(produto['imagem'])
                  ),
                  title: Text(produto['nome']),
                  subtitle:  Row(mainAxisAlignment: MainAxisAlignment.end,
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
                                Text(produto['preco']),

                              ],
                             mainAxisAlignment: MainAxisAlignment.end,
                            )

                          ],
                          mainAxisAlignment: MainAxisAlignment.end,
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

              });

            }else if(snapshot.hasError){
              return Center(child: Text('${snapshot.error}'));

            }
            return const Center(child: CircularProgressIndicator(),);
            
          },
      )
      ),
        
      
      ),
        ],
      )
    );
  }
  

  getProdutos() async{
    var url = Uri.parse('http://616d6bdb6dacbb001794ca17.mockapi.io/devnology/brazilian_provider');
    var response = await http.get(url);
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception('Não foi possivel pegar os produtos');
    }
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