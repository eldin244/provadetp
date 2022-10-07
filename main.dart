//Feito por elder gabriel
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String _infoText = "insira  as informações";
  String valorSelecionado = "";



  void _resetFields(){
    _formKey = GlobalKey<FormState>();
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "insira  as informações";
    });
  }
  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);

      double imc = weight;

      if(imc <= 1212 && imc >= 0 && valorSelecionado == '2filho'){
        _infoText = "Você receberá 2,5 salários minimos de auxílio ";
      }
      if(imc <= 2424 && imc >= 0 && valorSelecionado == '2filho'){
        _infoText = "Você receberá 1,5 salários minimos de auxílio ";
      }if(imc <= 2424 && imc >=0 && valorSelecionado == '3filho'){
        _infoText = "Você receberá 3 salários minimos de auxílio ";
      }if(imc <= 2424 && imc >= 0 && valorSelecionado == 'maesolteira'){
        _infoText = "por favor calcule seu auxilio normalmente e acrescente 600 reais ";
      }else if(imc <= 2424 && imc >= 0 && valorSelecionado == '1filho') {
        _infoText = "Infelizmente vocẽ não pode receber auxílio ";
      }else if(imc > 2424 && imc >= 0 && valorSelecionado == '2filho'){
        _infoText = "Infelizmente vocẽ não pode receber auxílio ";
      }else if(imc > 2424 && imc >= 0 && valorSelecionado == '3filho'){
        _infoText = "Infelizmente vocẽ não pode receber auxílio ";
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Seu auxílio"),
        centerTitle: true,
        backgroundColor: Colors.yellow,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.yellow),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "quanto você recebe(por mês)",
                    labelStyle: TextStyle(color:
                    Colors.black)

                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.yellow, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty){
                    return "valor não preenchido";
                  }else if(double.parse(value) > 3636 && double.parse(value) <1000) {
                    return "você não pode receber o auxilio";
                  }else if(double.parse(value) < 0){
                    return "informe um número positivo!";
                  }else if(double.parse(value) >= 10000){
                    return "me da um pouco desse salario";
                  }
                },
              ),
              DropdownButton(
                onChanged: (value){
                  valorSelecionado = value.toString();
                },
                items: [
                  DropdownMenuItem(child: Text("tenho nenhum ou 1 filho apenas na escola e vacinados"), value: '1filho',),
                  DropdownMenuItem(child: Text("tenho pelo menos 2 filhos na escola e vacinados"), value: '2filho', ),
                  DropdownMenuItem(child: Text("tenho pelo menos 3 filhos ou mais na escola e vacinados"), value: '3filho', ),
                  DropdownMenuItem(child: Text("sou mãe solteira"), value: 'maesolteira', ),                ],
                iconEnabledColor: Colors.yellow,
                isExpanded: true,

              ),

              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate() )
                        _calculate();
                    },
                    child: Text("Calcular",style: TextStyle(color: Colors.white, fontSize: 25.0),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow,
                    ),
                  ),
                ),
              ),
              Text(
                "$_infoText", style: TextStyle(color: Colors.black ,fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}