import 'package:flutter/material.dart';
import 'package:wallet_wise/core/app_export.dart';

import '../../../data/data_manager.dart';

class StatisticsChart extends StatefulWidget {
  final String period; // 'day', 'week', 'month'
  final Future<Map<String, double>> Function() fetchBalanceData;

  const StatisticsChart({
    required this.period,
    required this.fetchBalanceData,
    Key? key,
  }) : super(key: key);

  @override
  _StatisticsChartState createState() => _StatisticsChartState();
}

class _StatisticsChartState extends State<StatisticsChart> {
  late String _currentPeriod;
  List<_ChartData> _balanceData = [];
  @override
  void initState() {
    super.initState();
    _currentPeriod = widget.period;
    _loadData();
  }

  Future<void> _loadData() async {
    Future<Map<String, double>> Function() fetchBalanceData;

    switch (_currentPeriod) {
      case 'week':
        fetchBalanceData = DataManager.getWeeklyBalance;
        break;
      case 'month':
        fetchBalanceData = DataManager.getMonthlyBalance;
        break;
      case 'day':
      default:
        fetchBalanceData = DataManager.getDailyBalance;
    }

    final balanceData = await fetchBalanceData();

    setState(() {
      _balanceData = balanceData.entries
          .map((e) => _ChartData(e.key, e.value))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Expanded(
          child: Padding(
            padding:  EdgeInsets.all(25.0),
            child: CustomPaint(
              painter: BarChartPainter(_balanceData),
            ),
          ),
        ),

      ],
    );
  }

}


class _ChartData {
  _ChartData(this.label, this.value);
  final String label;
  final double value;
}

class BarChartPainter extends CustomPainter {
  final List<_ChartData> data;
  final double barWidth = 25.0;
  final double spaceBetweenBars = 30.0;
  final double minBarHeight = 5.0; // Минимальная высота для нулевых значений

  BarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final double chartHeight = size.height;
    final double maxBarHeight = chartHeight * 0.8; // Максимальная высота баров
    final double maxDataValue = data.isNotEmpty
        ? data.map((e) => e.value).reduce((a, b) => a > b ? a : b)
        : 1.0;

    final double xOffset = (size.width - data.length * barWidth - (data.length - 1) * spaceBetweenBars) / 2;

    for (int i = 0; i < data.length; i++) {
      final double barHeight = ((data[i].value / maxDataValue) * maxBarHeight).clamp(minBarHeight, maxBarHeight);
      final double x = xOffset + i * (barWidth + spaceBetweenBars);
      final double y = chartHeight - barHeight;

      final RRect rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, barHeight),
        Radius.circular(8.0), // Радиус закругления углов
      );

      canvas.drawRRect(rrect, paint);

      final TextSpan span = TextSpan(style: CustomTextStyles.titleSmallSemiBold, text: data[i].label);
      final TextPainter tp = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(x, chartHeight + 5));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

