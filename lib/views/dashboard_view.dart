import 'package:fl_chart/fl_chart.dart'; // Adicionado para o gráfico
import 'package:flutter/material.dart';
import 'package:projeto_bd_front/consumers/dashboard_consumer.dart';
import 'package:projeto_bd_front/models/dashboard/average_salary_by_department.dart';
import 'package:projeto_bd_front/models/dashboard/dashboard.dart';
import 'package:projeto_bd_front/models/dashboard/employees_by_department.dart';
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
      body: FutureBuilder<Dashboard?>(
        future: DashboardConsumer().getDashboard(),
        builder: (
          final BuildContext context,
          final AsyncSnapshot<Dashboard?> snapshot,
        ) {
          if (snapshot.hasData) {
            final Dashboard? dashboard = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      /// Employees
                      StatsCard(
                        title: 'Funcionários',
                        subtitle: (dashboard?.totalEmployees ?? 0).toString(),
                      ),

                      /// Departments
                      StatsCard(
                        title: 'Departamentos',
                        subtitle: (dashboard?.totalDepartments ?? 0).toString(),
                      ),
                    ],
                  ),

                  /// Employees without Department
                  Row(
                    children: <Widget>[
                      StatsCard(
                        title: ' Funcionários sem Departamento',
                        subtitle:
                            (dashboard?.unassignedEmployees ?? 0).toString(),
                      ),
                    ],
                  ),

                  /// Gráficos lado a lado: pizza e barras
                  if (dashboard != null &&
                      dashboard.employeesByDepartment.isNotEmpty &&
                      dashboard.averageSalaryByDepartment.isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Gráfico de pizza de funcionários por departamento
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Funcionários por Departamento',
                                    style: Theme.of(context).textTheme.headlineSmall,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(18),
                                    height: 300,
                                    child: PieChart(
                                      PieChartData(
                                        sections: List<PieChartSectionData>.generate(
                                          dashboard.employeesByDepartment.length,
                                          (final int index) {
                                            final EmployeesByDepartment dept =
                                                dashboard.employeesByDepartment[index];
                                            final MaterialColor color =
                                                Colors.primaries[index % Colors.primaries.length];
                                            return PieChartSectionData(
                                              value: dept.totalEmployees.toDouble(),
                                              title: '${dept.name} (${dept.totalEmployees})',
                                              color: color,
                                              radius: 80,
                                              titleStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
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
                          ),
                        ),

                        const SizedBox(width: 16),

                        /// Gráfico de barras de salário médio por departamento
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Salário Médio por Departamento',
                                    style: Theme.of(context).textTheme.headlineSmall,
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
                                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                              final dept = dashboard.averageSalaryByDepartment[group.x.toInt()];
                                              return BarTooltipItem(
                                                '${dept.name}\nR\$ ${dept.averageSalary.toStringAsFixed(2)}',
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
                                                if (value % 1 != 0)
                                                  return const SizedBox.shrink();
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
                                                    idx >= dashboard.averageSalaryByDepartment.length) {
                                                  return const SizedBox.shrink();
                                                }
                                                final String name =
                                                    dashboard.averageSalaryByDepartment[idx].name;
                                                // Nome do departamento no eixo X, rotacionado para melhor visualização
                                                return Padding(
                                                  padding: const EdgeInsets.only(top: 8.0),
                                                  child: Transform.rotate(
                                                    angle: -0.5, // Aproximadamente -30 graus
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
                                          dashboard.averageSalaryByDepartment.length,
                                          (final int index) {
                                            final AverageSalaryByDepartment dept =
                                                dashboard.averageSalaryByDepartment[index];
                                            return BarChartGroupData(
                                              x: index,
                                              barRods: <BarChartRodData>[
                                                BarChartRodData(
                                                  toY: dept.averageSalary,
                                                  color: Colors.green,
                                                  width: 18,
                                                  borderRadius: BorderRadius.circular(4),
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
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
