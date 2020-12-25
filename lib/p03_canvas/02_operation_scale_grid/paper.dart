import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明: 纸

class Paper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        // 使用CustomPaint
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  Paint _gridPint; // 画笔
  final double step = 20; // 小格边长
  final double strokeWidth = .5; // 线宽
  final Color color = Colors.grey; // 线颜色

  PaperPainter() {
    _gridPint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 画布起点移动到了屏幕忠心
    canvas.translate(size.width / 2, size.height / 2);
    // 绘制网格
    _drawGrid(canvas, size);
    // 绘制其他
    _drawPart(canvas);
  }

  void _drawPart(Canvas canvas) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;
    canvas.drawCircle(Offset(0, 0), 50, paint);
    canvas.drawLine(
        Offset(20, 20),
        Offset(50, 50),
        paint
          ..color = Colors.red
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);
  }

  void _drawGrid(Canvas canvas, Size size) {
    _drawBottomRight(canvas, size);
    /// 保存当前画布的状态
    canvas.save();
    /// 小诀窍，通过缩放来实现对称变化，而不是旋转
    // 如果第二个参数没有给定值，那么x、y都会使用第一个参数
    canvas.scale(1, -1); //沿x轴镜像，绘制右上角
    _drawBottomRight(canvas, size);
    /// 回到上次保存的状态
    canvas.restore();

    canvas.save();
    canvas.scale(-1, 1); //沿y轴镜像，左下角
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, -1); //沿原点镜像，左上角
    _drawBottomRight(canvas, size);
    canvas.restore();
  }

  void _drawBottomRight(Canvas canvas, Size size) {
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      // 绘制横线
      canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), _gridPint);
      // Y 轴向下移动
      canvas.translate(0, step);
    }
    canvas.restore();

    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      // 绘制竖线
      canvas.drawLine(Offset(0, 0), Offset(0, size.height / 2), _gridPint);
      // X 轴向右移动
      canvas.translate(step , 0);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
