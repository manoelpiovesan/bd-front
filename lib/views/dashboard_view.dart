import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:projeto_bd_front/consumers/dashboard_consumer.dart';
import 'package:projeto_bd_front/models/dashboard/average_salary_by_department.dart';
import 'package:projeto_bd_front/models/dashboard/common_stats.dart';
import 'package:projeto_bd_front/models/dashboard/employees_by_department.dart';
import 'package:projeto_bd_front/models/my_response.dart';
import 'package:projeto_bd_front/views/widgets/sql_preview.dart';
import 'package:projeto_bd_front/views/widgets/stats_card.dart';

///
///
///
class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  ///
  ///
  ///
  @override
  State<DashboardView> createState() => _DashboardViewState();
}

///
///
///
class _DashboardViewState extends State<DashboardView> {
  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estatísticas')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              /// Common Stats
              FutureBuilder<MyResponse<CommonStats>?>(
                future: DashboardConsumer().getCommonStats(),
                builder: (
                  final BuildContext context,
                  final AsyncSnapshot<MyResponse<CommonStats>?> snapshot,
                ) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.data.isNotEmpty) {
                    final CommonStats dashboard = snapshot.data!.data.first;
                    return Column(
                      spacing: 12,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          spacing: 12,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Estatísticas Gerais',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            SqlPreview(snapshot.data?.queries.first),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            /// Employees
                            StatsCard(
                              title: 'Funcionários',
                              subtitle: dashboard.totalEmployees.toString(),
                            ),

                            /// Departments
                            StatsCard(
                              title: 'Departamentos',
                              subtitle: dashboard.totalDepartments.toString(),
                            ),
                          ],
                        ),

                        /// Employees without Department
                        Row(
                          children: <Widget>[
                            StatsCard(
                              title: ' Funcionários sem Departamento',
                              subtitle:
                                  dashboard.unassignedEmployees.toString(),
                            ),
                          ],
                        ),

                        Row(
                          children: <Widget>[
                            /// Average Salary
                            StatsCard(
                              title: 'Salário Médio',
                              subtitle:
                                  r'R$ '
                                  '${dashboard.avgSalary.toStringAsFixed(2)}',
                            ),
                          ],
                        ),

                        Row(
                          children: <Widget>[
                            /// Highest Salary
                            StatsCard(
                              title: 'Maior Salário',
                              subtitle: 'R\$ ${dashboard.highestSalary}',
                            ),

                            /// Lowest Salary
                            StatsCard(
                              title: 'Menor Salário',
                              subtitle: 'R\$ ${dashboard.lowestSalary}',
                            ),
                          ],
                        ),

                        Row(
                          children: <Widget>[
                            /// New Hires in Last 30 Days
                            StatsCard(
                              title: 'Contratações (30 dias)',
                              subtitle: dashboard.newHiresLast30Days.toString(),
                            ),

                            /// Active Departments
                            StatsCard(
                              title: 'Departamentos Ativos',
                              subtitle: dashboard.activeDepartments.toString(),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),

              /// Employees by Department
              FutureBuilder<MyResponse<EmployeesByDepartment>?>(
                future: DashboardConsumer().getEmployeesByDepartment(),
                builder: (
                  final BuildContext context,
                  final AsyncSnapshot<MyResponse<EmployeesByDepartment>?>
                  snapshot,
                ) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.data.isNotEmpty) {
                    final List<EmployeesByDepartment> employeesByDepartment =
                        snapshot.data!.data;
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[
                            Row(
                              spacing: 12,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Funcionários por Departamento',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                SqlPreview(snapshot.data?.queries.first),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(18),
                              height: 600,
                              child: PieChart(
                                PieChartData(
                                  sections: List<PieChartSectionData>.generate(
                                    employeesByDepartment.length,
                                    (final int index) {
                                      final EmployeesByDepartment dept =
                                          employeesByDepartment[index];
                                      final MaterialColor color =
                                          Colors.primaries[index %
                                              Colors.primaries.length];
                                      return PieChartSectionData(
                                        value: dept.totalEmployees.toDouble(),
                                        title:
                                            '${dept.name} '
                                            '(${dept.totalEmployees})',
                                        color: color,
                                        radius: 200,
                                        titleStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          shadows: <Shadow>[
                                            Shadow(
                                              color: Colors.black54,
                                              blurRadius: 2,
                                            ),
                                            Shadow(
                                              color: Colors.black26,
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  sectionsSpace: 2,
                                  centerSpaceRadius: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),

              /// Average Salary by Department
              FutureBuilder<MyResponse<AverageSalaryByDepartment>?>(
                future: DashboardConsumer().getAverageSalaryByDepartment(),
                builder: (
                  final BuildContext context,
                  final AsyncSnapshot<MyResponse<AverageSalaryByDepartment>?>
                  snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        spacing: 12,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Média Salarial por Departamento',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SqlPreview(snapshot.data?.queries.first),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(18),
                            height: 300,
                            child: BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceAround,
                                barTouchData: BarTouchData(
                                  enabled: true,
                                  touchTooltipData: BarTouchTooltipData(
                                    getTooltipItem: (
                                      final BarChartGroupData group,
                                      final int groupIndex,
                                      final BarChartRodData rod,
                                      final int rodIndex,
                                    ) {
                                      final AverageSalaryByDepartment dept =
                                          snapshot.data!.data[group.x];
                                      return BarTooltipItem(
                                        '${dept.name}\nR\$ '
                                        '${dept.avgSalary.toStringAsFixed(2)}',
                                        const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                titlesData: FlTitlesData(
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 1000,
                                      getTitlesWidget: (
                                        final double value,
                                        final TitleMeta meta,
                                      ) {
                                        if (value % 1 != 0) {
                                          return const SizedBox.shrink();
                                        }
                                        return Container(
                                          alignment: Alignment.centerRight,
                                          width: 40,
                                          child: Text(
                                            value.toInt().toString(),
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.right,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (
                                        final double value,
                                        final TitleMeta meta,
                                      ) {
                                        final int idx = value.toInt();
                                        if (idx < 0 ||
                                            idx >= snapshot.data!.data.length) {
                                          return const SizedBox.shrink();
                                        }
                                        final String name =
                                            snapshot.data!.data[idx].name;
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                          ),
                                          child: Transform.rotate(
                                            angle: -0.5,
                                            child: SizedBox(
                                              width: 80,
                                              child: Text(
                                                name,
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  topTitles: const AxisTitles(),
                                  rightTitles: const AxisTitles(),
                                ),
                                borderData: FlBorderData(show: false),
                                barGroups: List.generate(
                                  snapshot.data!.data.length,
                                  (final int index) {
                                    final AverageSalaryByDepartment dept =
                                        snapshot.data!.data[index];
                                    return BarChartGroupData(
                                      x: index,
                                      barRods: <BarChartRodData>[
                                        BarChartRodData(
                                          toY: dept.avgSalary,
                                          color: Colors.green,
                                          width: 18,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
