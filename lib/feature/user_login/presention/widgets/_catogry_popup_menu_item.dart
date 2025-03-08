import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  OverlayEntry? _overlayEntry;

  void _showPopupMenu(BuildContext context) {
    final overlay = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _removePopup(),
        child: Stack(
          children: [
            Positioned(
              top: 100,
              right: 50,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildMenuItem("الخيار الأول"),
                      _buildMenuItem("الخيار الثاني"),
                      _buildMenuItem("الخيار الثالث"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  Widget _buildMenuItem(String title) {
    return InkWell(
      onTap: () {
        print("تم اختيار: $title");
        // لا تغلق القائمة هنا
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(title, style: TextStyle(fontSize: 16)),
      ),
    );
  }

  void _removePopup() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("قائمة منبثقة بدون إغلاق تلقائي")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showPopupMenu(context),
          child: Text("عرض القائمة"),
        ),
      ),
    );
  }
}

