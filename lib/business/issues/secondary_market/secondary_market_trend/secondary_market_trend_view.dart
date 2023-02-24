import 'dart:math';

import 'package:dbook/common/utils/logger.dart';
import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/view_state/base_container_view.dart';
import '../../../../generated/assets.dart';
import 'secondary_market_trend_logic.dart';

class SecondaryMarketTrendPage extends StatelessWidget {
  final logic = Get.put(SecondaryMarketTrendLogic());
  final state = Get.find<SecondaryMarketTrendLogic>().refreshState;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      viewState: state.viewState,
      retry: logic.refresh,
      child: _list(),
    );
  }


  Widget _list() {
    return Obx(() {
      if (state.list.length == 0) return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SvgPicture.asset(Assets.svgIssuesDetailNoData, width: 50.w),
        SizedBox(height: 20.h),
        TextX('no data',color: ColorX.txtHint),
      ],);
      return Container(
        padding: EdgeInsets.only(top: 10, right: 20),
        child: LineChart(mainData()),);
    });
  }


  LineChartData mainData() {
    var dataMax = state.list.map((element) => element.quantities).toList().reduce((a, b) => max<int>(a, b));
    double leftInterval = dataMax / 8 < 1 ? 1.0 : dataMax / 8;
    var bottomInterval = state.list.length / 8 < 1 ? 1.0 : state.list.length / 8;

    logX.d('最大值>>>$leftInterval');
    double leftReservedSize = 28;
    if (dataMax < 1000) {
      leftReservedSize = 22;
    } else if (dataMax >= 1000 && dataMax < 10000) {
      leftReservedSize = 34;
    } else if (dataMax >= 10000 && dataMax < 100000) {
      leftReservedSize = 40;
    } else {
      leftReservedSize = 46;
    }
    logX.d('最大值11>>>$leftReservedSize');

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: leftInterval.floorToDouble(),
        verticalInterval: bottomInterval,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xFFE8E8E8),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 24,
            interval: bottomInterval,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: leftInterval.floorToDouble(),
            getTitlesWidget: leftTitleWidgets,
            reservedSize: leftReservedSize,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Color(0xFFE8E8E8)),
      ),
      // minX: 0,
      // maxX: 11,
      // minY: 0,
      // maxY: 18,
      lineBarsData: [
        LineChartBarData(
          spots: state.list.asMap().keys.map((index) => FlSpot(index.toDouble(), (state.list[index].quantities as int).toDouble())).toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: state.gradientColors,
          ),
          barWidth: 2,
          color: Color(0xFF4D85D0),
          isStrokeCapRound: true,
          dotData: FlDotData(show: true, getDotPainter: _defaultGetDotPainter),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: state.gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String date = state.list[value.toInt()].date;
    var dateList = date.split('-');

    var dateStr;

    if (dateList.length == 3) {
      dateStr = '${dateList[1]}/${dateList[2]}';
    } else {
      dateStr = date;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: TextX(
        dateStr,
        fontSize: FontSizeX.s11,
        color: ColorX.txtDesc,
      ),
    );
  }

  FlDotPainter _defaultGetDotPainter(FlSpot spot, double xPercentage, LineChartBarData bar, int index, {double? size}) {
    return FlDotCirclePainter(radius: size, color: Colors.white, strokeColor: Color(0xFF4D85D0), strokeWidth: 2);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 6,
      child: TextX(
        meta.formattedValue,
        fontSize: FontSizeX.s11,
        color: ColorX.txtDesc,
      ),
    );
  }
}
