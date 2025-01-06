import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DrawingPage extends StatefulWidget {
  const DrawingPage({super.key});

  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  List<Offset?> points = [];
  List<List<Offset?>> undoStack = [];
  List<List<Offset?>> redoStack = [];
  Color selectedColor = Colors.blue;
  double strokeWidth = 4.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.undo, color: Colors.white),
            onPressed: undo,
          ),
          IconButton(
            icon: Icon(Icons.redo, color: Colors.white),
            onPressed: redo,
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Tambahkan menu di sini jika diperlukan
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GestureDetector(
            onPanStart: (details) {
              // Simpan state sebelum menggambar untuk Undo
              setState(() {
                undoStack.add(List.from(points));
                redoStack.clear(); // Hapus redo stack saat mulai menggambar
              });
            },
            onPanUpdate: (details) {
              setState(() {
                points.add(details.localPosition);
              });
            },
            onPanEnd: (details) {
              points.add(null); // Penanda untuk memulai garis baru
            },
            child: CustomPaint(
              painter: DrawingPainter(points, selectedColor, strokeWidth),
              size: Size.infinite,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.crop_square, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        points.clear();
                        undoStack.clear();
                        redoStack.clear();
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.brush, color: selectedColor),
                    onPressed: () {
                      // Pilih warna
                      _selectColor(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.create, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        strokeWidth = 4.0;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.format_paint, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        strokeWidth = 10.0;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void undo() {
    if (undoStack.isNotEmpty) {
      setState(() {
        redoStack.add(List.from(points)); // Simpan status saat ini ke redoStack
        points = undoStack.removeLast(); // Ambil status terakhir dari undoStack
      });
    }
  }

  void redo() {
    if (redoStack.isNotEmpty) {
      setState(() {
        undoStack.add(List.from(points)); // Simpan status saat ini ke undoStack
        points = redoStack.removeLast(); // Ambil status terakhir dari redoStack
      });
    }
  }

  Future<void> _selectColor(BuildContext context) async {
    Color? picked = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pilih Warna'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: selectedColor,
            onColorChanged: (color) {
              Navigator.pop(context, color);
            },
          ),
        ),
      ),
    );

    if (picked != null) {
      setState(() {
        selectedColor = picked;
      });
    }
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;
  final Color color;
  final double strokeWidth;

  DrawingPainter(this.points, this.color, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
