import "package:developer_company/shared/utils/responsive.dart";
import "package:flutter/material.dart";

class RoundedContainer extends StatelessWidget {
    final String text;
    final double width; 
    final double height;
    final Color color; 

  RoundedContainer({required this.text, required this.width, required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    Responsive responsive =  Responsive(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color, // Color de fondo
        borderRadius: BorderRadius.circular(10), // Bordes redondeados
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Color de la sombra
            spreadRadius: 5, // Extensión de la sombra
            blurRadius: 7, // Desenfoque de la sombra
            offset: Offset(0, 3), // Desplazamiento de la sombra
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: responsive.hp(1.8), // Tamaño de fuente
            fontWeight: FontWeight.bold, // Peso de la fuente
          ),
        ),
      ),
    );
  }
}