import 'package:flutter/material.dart';
class RoundedCard extends StatelessWidget {
  Widget child;
   RoundedCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          shadowColor: Colors.black,
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: child
      ),
    );
  }
}
