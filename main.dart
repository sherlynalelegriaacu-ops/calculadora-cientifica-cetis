import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InicioScreen(),
    );
  }
}

////////////////////////////////////////////////////////
/// PANTALLA DE INICIO
////////////////////////////////////////////////////////

class InicioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F172A),

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // LOGO
              Image.asset(
                'assets/logo_plantel.png',
                height: 150,
              ),

              SizedBox(height: 30),

              // TITULO
              Text(
                "Calculadora Científica",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 15),

              // NOMBRE
              Text(
                "SHERLYN ACUÑA ZALETA",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  letterSpacing: 2,
                ),
              ),

              SizedBox(height: 50),

              // BOTON ENTRAR
              ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  padding: EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 18,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalculadoraScreen(),
                    ),
                  );
                },

                child: Text(
                  "ENTRAR",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////
/// CALCULADORA CIENTIFICA
////////////////////////////////////////////////////////

class CalculadoraScreen extends StatefulWidget {
  @override
  _CalculadoraScreenState createState() =>
      _CalculadoraScreenState();
}

class _CalculadoraScreenState
    extends State<CalculadoraScreen> {

  String expresion = "";
  String resultado = "0";

  void presionar(String texto) {

    setState(() {

      if (texto == "C") {

        expresion = "";
        resultado = "0";

      } else if (texto == "=") {

        calcular();

      } else {

        expresion += texto;
      }
    });
  }

  void calcular() {

    try {

      Parser p = Parser();

      Expression exp = p.parse(
        expresion
            .replaceAll("×", "*")
            .replaceAll("÷", "/")
            .replaceAll("√", "sqrt")
            .replaceAll("π", "3.1416"),
      );

      ContextModel cm = ContextModel();

      double eval =
      exp.evaluate(EvaluationType.REAL, cm);

      resultado = eval.toString();

    } catch (e) {

      resultado = "Error";
    }
  }

  Widget boton(String texto,
      {Color color = Colors.white24}) {

    return Expanded(

      child: Padding(

        padding: EdgeInsets.all(5),

        child: ElevatedButton(

          style: ElevatedButton.styleFrom(

            backgroundColor: color,

            padding: EdgeInsets.all(22),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),

          onPressed: () => presionar(texto),

          child: Text(

            texto,

            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Color(0xFF020617),

      appBar: AppBar(

        backgroundColor: Colors.black,

        title: Text("Calculadora Científica"),

        centerTitle: true,
      ),

      body: Column(

        children: [

          Expanded(

            child: Container(

              alignment: Alignment.bottomRight,

              padding: EdgeInsets.all(25),

              child: Column(

                mainAxisAlignment: MainAxisAlignment.end,

                crossAxisAlignment:
                CrossAxisAlignment.end,

                children: [

                  Text(

                    expresion,

                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 28,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(

                    resultado,

                    style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          ////////////////////////////////////////////////////
          /// BOTONES
          ////////////////////////////////////////////////////

          Row(
            children: [
              boton("sin("),
              boton("cos("),
              boton("tan("),
              boton("log("),
            ],
          ),

          Row(
            children: [
              boton("√("),
              boton("^"),
              boton("("),
              boton(")"),
            ],
          ),

          Row(
            children: [
              boton("7"),
              boton("8"),
              boton("9"),
              boton("÷",
                  color: Colors.orange),
            ],
          ),

          Row(
            children: [
              boton("4"),
              boton("5"),
              boton("6"),
              boton("×",
                  color: Colors.orange),
            ],
          ),

          Row(
            children: [
              boton("1"),
              boton("2"),
              boton("3"),
              boton("-",
                  color: Colors.orange),
            ],
          ),

          Row(
            children: [
              boton("0"),
              boton("."),
              boton("π"),
              boton("+",
                  color: Colors.orange),
            ],
          ),

          Row(
            children: [
              boton("C",
                  color: Colors.red),

              boton("=",
                  color: Colors.green),
            ],
          ),

          SizedBox(height: 10),
        ],
      ),
    );
  }
}