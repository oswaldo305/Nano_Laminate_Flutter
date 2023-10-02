// ignore_for_file: empty_constructor_bodies

import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      CustomColors.light
    ]
  );
 
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      CustomColors.dark
    ]
  );


}

@immutable

class CustomColors extends ThemeExtension<CustomColors>{
  final Color? customOne;
  final Color? customTwo;
  
  const CustomColors(
    {this.customOne,
    this.customTwo}
  );

  @override
  ThemeExtension<CustomColors> copyWith({
    Color? customOne,
    Color? customTwo
  }) {
    return CustomColors(
      customOne: customOne ?? this.customOne,
      customTwo: customTwo ?? this.customTwo,
    );
  }

  @override
  ThemeExtension<CustomColors> lerp(ThemeExtension<CustomColors>? other, double t){
   if(other is! CustomColors){
    return this;
   }
   return CustomColors(

    customOne: Color.lerp(customOne, other.customOne,t),
    customTwo: Color.lerp(customTwo, other.customTwo, t),

   );
  }

  static const light =CustomColors(
    customOne: Color.fromARGB(255, 246, 8, 8),
    customTwo: Color.fromARGB(255, 11, 47, 166)
  );

   static const dark =CustomColors(
    customOne: Color.fromARGB(49, 85, 43, 43),
    customTwo: Color.fromARGB(255, 11, 47, 166)
  );

}

