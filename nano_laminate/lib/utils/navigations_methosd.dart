import 'package:flutter/material.dart';

void pushAndReplaceTopage(BuildContext context, page){
  // Navigator.pushReplacementNamed(context, page);
  final route = MaterialPageRoute(
    builder: (context) => page
  );
  Navigator.pushReplacement(context, route);
  
}

void pushTopage(BuildContext context, page){
  // Navigator.pushReplacementNamed(context, page);
  final route = MaterialPageRoute(
    builder: (context) => page
  );
  Navigator.push(context, route);
  
}