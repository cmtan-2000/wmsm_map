// import 'package:flutter/material.dart';

// class DraggableLine extends StatefulWidget {
//   final double value;
//   final double minValue;
//   final double maxValue;
//   final ValueChanged<double> onChanged;
//   final Color lineColor;
//   final Color indicatorColor;
//   final Color activeLineColor;

//   const DraggableLine({
//     required this.value,
//     required this.minValue,
//     required this.maxValue,
//     required this.onChanged,
//     this.lineColor = Colors.grey,
//     this.indicatorColor = Colors.blue,
//     this.activeLineColor = Colors.green,
//   });

//   @override
//   _DraggableLineState createState() => _DraggableLineState();
// }

// class _DraggableLineState extends State<DraggableLine> {
//   late double _value;

//   @override
//   void initState() {
//     super.initState();
//     _value = widget.value;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Container(
//             height: 10,
//             color: widget.lineColor,
//           ),
//           Positioned(
//             left: _value,
//             child: Container(
//               height: 20,
//               width: 20,
//               decoration: BoxDecoration(
//                 color: widget.indicatorColor,
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           GestureDetector(
//             onPanUpdate: (details) {
//               setState(() {
//                 _value += details.delta.dx;

//                 if (_value < widget.minValue) {
//                   _value = widget.minValue;
//                 } else if (_value > widget.maxValue) {
//                   _value = widget.maxValue;
//                 }

//                 widget.onChanged(_value);
//               });
//             },
//             child: Container(
//               height: 10,
//               width: double.infinity,
//               color: _getLineColor(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Color _getLineColor() {
//     if (_value < widget.minValue + (widget.maxValue - widget.minValue) * 0.25) {
//       return widget.activeLineColor;
//     } else if (_value <
//         widget.minValue + (widget.maxValue - widget.minValue) * 0.75) {
//       return widget.activeLineColor;
//     } else {
//       return widget.lineColor;
//     }
//   }
// }
